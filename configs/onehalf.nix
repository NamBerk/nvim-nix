{ pkgs, config, ... }:
{
  configs.onehalf = {
    after = [
      "global"
      "toggleterm"
    ];
    plugins = [ pkgs.vimPlugins.onehalf ];
    vim = [ "colorscheme onehalf${config.opt.background}" ];
  };
}
