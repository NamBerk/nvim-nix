{ pkgs, nix2nvimrc, ... }:
{
  configs.neoclip = {
    after = [ "leader" "telescope" ];
    plugins = with pkgs; [ vimPlugins.nvim-neoclip-lua vimPlugins.sqlite-lua ];
    lua = map (a: nix2nvimrc.toLuaFn "require'telescope'.load_extension" [ a ]) [
      "neoclip"
    ];
    setup.args = {
      enable_persistent_history = true;
    };
    keymaps = map (nix2nvimrc.toKeymap { silent = true; }) [
      [ "n" "<Leader>p" "<Cmd>Telescope neoclip<CR>" { desc = "Find in paste register"; } ]
    ];
  };
}
