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
      "set clipboard=unnamedplus
      set shiftwidth=2 smarttab
      set tabstop=4 softtabstop=0
      set expandtab
    '';
  };
}
