{ pkgs, ... }:
{
  configs.vim-easymotion.plugins = [ pkgs.vimPlugins.vim-easymotion ];
}
