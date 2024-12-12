{ pkgs, nix2nvimrc, ... }:
let
  inherit (nix2nvimrc) toLuaFn luaExpr;
in
{
  configs.telescope = {
    # https://github.com/nvim-telescope/telescope.nvim/blob/master/lua/telescope/mappings.lua
    keymaps = map (nix2nvimrc.toKeymap { silent = true; }) [
      # override ck3d
      [
        "n"
        "<Leader>ft"
        "<Cmd>Telescope file_browser path=%:p:h<CR>"
        { desc = "Find file via browser"; }
      ]
      # extend ck3d
      [
        "n"
        "<Leader><Tab>"
        (luaExpr "function() require'telescope.builtin'.buffers({sort_mru=true, sort_lastused=true}) end")
        { desc = "Find buffers (sorted)"; }
      ]
      [
        "n"
        "<Leader><Leader><Tab>"
        (luaExpr "require'telescope.builtin'.resume")
        { desc = "Resume telescope"; }
      ]
      [
        "n"
        "<Leader>fo"
        "<Cmd>lua require'telescope.builtin'.oldfiles({cwd_only=true,cwd=vim.fn.systemlist(\"git -C \" .. vim.fn.expand(\"%:p:h\") .. \" rev-parse --show-toplevel\")[1]})<CR>"
        { desc = "Find recent file in repo"; }
      ]
      [
        "n"
        "<Leader>fO"
        "<Cmd>Telescope oldfiles<CR>"
        { desc = "Find recent file"; }
      ]
      [
        "n"
        "<Leader>fG"
        "<Cmd>lua require'telescope.builtin'.live_grep({cwd=vim.fn.systemlist(\"git -C \" .. vim.fn.expand(\"%:p:h\") .. \" rev-parse --show-toplevel\")[1]})<CR>"
        { desc = "Grep in repo"; }
      ]
      [
        [
          "n"
          "v"
        ]
        "<Leader>fs"
        "<Cmd>Telescope grep_string<CR>"
        { }
      ]
    ];
  };
}
