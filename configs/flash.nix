{ nix2nvimrc,pkgs, ... }:
let
  inherit (nix2nvimrc) luaExpr;
in
{
  configs.flash = {
    plugins = [ pkgs.vimPlugins.flash-nvim ];
    luaConfig = ''
      require("flash").setup({
        modes = {
          char = { jump_labels = true },
        },
      })
    '';
    keymaps = map (nix2nvimrc.toKeymap { silent = true; }) [
      [ [ "n" "x" "o" ] "s" (luaExpr "function() require('flash').jump() end") { desc = "Flash jump"; } ]
      [ [ "n" "x" "o" ] "S" (luaExpr "function() require('flash').treesitter() end") { desc = "Flash Treesitter"; } ]
    ];
  };
}
