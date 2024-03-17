{ pkgs, nix2nvimrc, ... }:
{
  configs.undotree = {
    after = [ "leader" ];
    plugins = [ pkgs.vimPlugins.undotree ];
    keymaps = map (nix2nvimrc.toKeymap { silent = true; }) [
      [ "n" "<Leader>u" "<Cmd>UndotreeToggle<CR>" { } ]
    ];
  };
}
