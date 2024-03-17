{ config, lib, ... }:
{
  # overwrite ck3d
  configs.lualine.setup.args.options.theme = lib.mkForce "one${config.opt.background}";
}
