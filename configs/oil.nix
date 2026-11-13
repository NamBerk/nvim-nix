{ nix2nvimrc, pkgs, ... }:
let
  inherit (nix2nvimrc) luaExpr;
in
{
  configs.oil = {
    plugins = [ pkgs.vimPlugins.oil-nvim ];

    luaConfig = ''
      require("oil").setup({
        default_file_explorer = true,
        delete_to_trash = true,
        float = { border = "rounded" },
      })
    '';

    keymaps = map (nix2nvimrc.toKeymap { silent = true; }) [
      [ "n" "-" "<CMD>Oil<CR>" { desc = "Open parent directory"; } ]
      [ "n" "<Leader>-" (luaExpr "require('oil').toggle_float") { desc = "Open floating Oil"; } ]
    ];
  };
}
