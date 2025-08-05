{ lib, ... }:
{
  # overwrite from ck3d
  configs.cmp.setup.args = lib.mkForce ./cmp_setup_args.lua;

}
