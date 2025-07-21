{ pkgs, lib, ... }:
{
  configs.ale = {
    plugins = [ pkgs.vimPlugins.ale ];
     lua = [
      "vim.g.ale_javascript_eslint_executable = 'eslint_d'"
      "vim.g.ale_javascript_eslint_use_global = 1"
      "vim.g.ale_linter_aliases = { vue = {'javascript'} }"
      "vim.g.ale_linters = {
         javascript = {'eslint'},
         typescript = {'eslint'},
         vue = {'eslint'}
      }"
      "vim.g.ale_fixers = {
         javascript = {'eslint'},
         typescript = {'eslint'},
         vue = {'eslint'}
      }"
      "vim.g.ale_fix_on_save = 1"
    ];
    env.PATH.values = [ "${lib.makeBinPath [ pkgs.eslint_d ]}" ];
  };
}
