{ pkgs, nix2nvimrc, ... }:
{
  configs.yanky = {
    plugins = with pkgs; [
      vimPlugins.yanky-nvim
    ];
    setup.args = {};
    keymaps = map (nix2nvimrc.toKeymap { silent = true; }) [
      [ "n" "p" "<Plug>(YankyPutAfter)" { desc = "Put after cursor"; } ]
      [ "n" "P" "<Plug>(YankyPutBefore)" { desc = "Put before cursor"; } ]
      [ "x" "p" "<Plug>(YankyPutAfter)" { desc = "Put after cursor"; } ]
      [ "x" "P" "<Plug>(YankyPutBefore)" { desc = "Put before cursor"; } ]
      [ "n" "<C-p>" "<Plug>(YankyPreviousEntry)" { desc = "Cycle to previous yank history"; } ]
      [ "n" "<C-n>" "<Plug>(YankyNextEntry)" { desc = "Cycle to next yank history"; } ]
      [ "n" "<leader>p" "<cmd>Telescope yank_history<CR>" { desc = "Open clipboard history menu"; } ]
    ];
  };
}
