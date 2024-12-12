{
  config,
  pkgs,
  lib,
  nix2nvimrc,
  ...
}:
{
  # extend ck3d
  configs.nvim-treesitter = {
    plugins = with pkgs.vimPlugins; [
      rainbow-delimiters-nvim
    ];
    setup.args = {
      rainbow = {
        enable = true;
        extended_mode = true;
      };
    };
  };
}
