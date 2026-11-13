{ pkgs, nix2nvimrc, ... }:
{
  configs.oil = {
    plugins = with pkgs; [
      vimPlugins.oil-nvim
    ];
    lua = [
      ''require("oil").setup()''
    ];
    keymaps = map (nix2nvimrc.toKeymap { silent = true; }) [
      [
        "n"
        "-"
        "<CMD>Oil<CR>"
        { desc = "Open parent directory"; }
      ]
    ];
  };
}
