{ stdenvNoCC, fetchFromGitHub, fetchpatch, writeShellScriptBin, lib, lndir, nvidia_x11 }: 

let
  nvpatch = writeShellScriptBin "nvpatch" ''
    set -eu
    patchScript=$1
    objdir=$2
    set -- -sl
    source $patchScript
    patch="''${patch_list[$nvidiaVersion]-}"
    object="''${object_list[$nvidiaVersion]-}"
    if [[ -z $patch || -z $object ]]; then
      echo "$nvidiaVersion not supported for $patchScript" >&2
      exit 1
    fi
    sed -e "$patch" $objdir/$object.$nvidiaVersion > $object.$nvidiaVersion
  '';
in stdenvNoCC.mkDerivation {
  pname = "nvidia-patch";
  version = "2023-08-26";

  src = fetchFromGitHub {
    # mirror: git clone https://ipfs.io/ipns/Qmed4r8yrBP162WK1ybd1DJWhLUi4t6mGuBoB9fLtjxR7u
    owner = "keylase";
    repo = "nvidia-patch";
    rev = "e800f66a18dcb2af3cfc2a505d7a582536682002";
    hash = "sha256-986G696PCjffSU9CYIap4GKYlJVFeAypggXpXM7yDVk=";
  };

  nativeBuildInputs = [ nvpatch lndir ];
  patchedLibs = [
    "libnvidia-encode${stdenvNoCC.hostPlatform.extensions.sharedLibrary}"
    "libnvidia-fbc${stdenvNoCC.hostPlatform.extensions.sharedLibrary}"
  ];

  inherit nvidia_x11;
  nvidia_x11_bin = nvidia_x11.bin;
  nvidia_x11_lib32 = nvidia_x11.lib32; # XXX: no patches for 32bit?
  nvidiaVersion = nvidia_x11.version;

  outputs = [ "out" "bin" "lib32" ];

  buildPhase = ''
    runHook preBuild
    nvpatch patch.sh $nvidia_x11/lib || nvenc=$?
    nvpatch patch-fbc.sh $nvidia_x11/lib || nvfbc=$?
    if [[ -n $nvenc && -n $nvfbc ]]; then
      exit 1
    fi
    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall
    for f in $patchedLibs; do
      if [[ -e $f.$nvidiaVersion ]]; then
        install -Dm0755 -t $out/lib $f.$nvidiaVersion
      else
        echo WARN: $f not patched >&2
      fi
    done
    install -d $out $bin $lib32
    lndir -silent $nvidia_x11 $out
    ln -s $nvidia_x11_bin/* $bin/
    ln -s $nvidia_x11_lib32/* $lib32/
    runHook postInstall
  '';

  meta = with lib.licenses; {
    license = unfree;
  };
  passthru = {
    ci.cache.wrap = true;
    inherit (nvidia_x11) useProfiles persistenced settings bin lib32;
  };
}
