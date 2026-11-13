{ pkgs, nix2nvimrc, ... }:
{
  configs.yanky = {
    plugins = with pkgs; [
      vimPlugins.yanky-nvim
    ];
    setup.args = {
      picker = {
        telescope = {
          use_default_mappings = true;
        };
      };
    };
    setup.args = {};
    lua = [
      ''
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "TelescopePrompt",
        callback = function()
          vim.keymap.set("i", "<CR>", "<CR>p", { buffer = true })
          vim.keymap.set("n", "<CR>", "<CR>p", { buffer = true })
        end,
      })
      ''
    ];
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
