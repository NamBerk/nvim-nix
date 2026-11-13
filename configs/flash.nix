{ pkgs, nix2nvimrc, ... }:
{
  configs.flash = {
    plugins = with pkgs; [
      vimPlugins.flash-nvim
    ];
    lua = [
      ''require("flash").setup()''
    ];
    keymaps = map (nix2nvimrc.toKeymap { silent = true; }) [
      [
        "n"
        "s"
        "function() require(\"flash\").jump() end"
        { desc = "Flash jump"; expr = true; }
      ]
    ];
  };
}
