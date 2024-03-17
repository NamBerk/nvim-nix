{ pkgs, ... }:
{
  # overwrite ck3d
  configs.which-key.setup.args = {
    plugins.spelling.enabled = true;
  };
}
