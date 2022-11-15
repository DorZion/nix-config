{config, ...}:
{
  programs.vim = {
    enable = true;
    # plugins = with pkgs.vimPlugins; [ vim-airline ];
    # settings = { ignorecase = true; };
    extraConfig = ''
      set mouse-=a
      set number relativenumber
      set numberwidth=1
      set clipboard=unnamedplus
    '';
  };
}
