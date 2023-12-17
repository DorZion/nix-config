{ stdenvNoCC, fetchFromGitHub, fetchpatch, writeShellScriptBin, lib, lndir, nvidia_x11 }: 

let
  nvpatch = writeShellScriptBin "nvpatch" ''
    set -eu
    patchScript=$1
    objdir=$2
    set -- -sl
    source $patchScript
    echo "Patching $nvidiaVersion" >&2
    patch="''${patch_list[$nvidiaVersion]-}"
    object="libnvidia-fbc.so"
    if [[ -z $patch || -z $object ]]; then
      echo "$nvidiaVersion not supported for $patchScript" >&2
      exit 1
    fi
    sed -e "$patch" $objdir/$object.$nvidiaVersion > $object.$nvidiaVersion
  '';
in stdenvNoCC.mkDerivation {
  pname = "nvidia-patch";
  version = "2023-12-13";

  src = fetchFromGitHub {
    # mirror: git clone https://ipfs.io/ipns/Qmed4r8yrBP162WK1ybd1DJWhLUi4t6mGuBoB9fLtjxR7u
    owner = "keylase";
    repo = "nvidia-patch";
    rev = "564c0661a942f7163cb2cfa6cb1b14b4bcff3a30";
    hash = "sha256-85h94r3XZq1wME6+AxsTIIsM1TmMMr97RJjDygdnxtA=";
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
