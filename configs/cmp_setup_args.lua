-- https://github.com/hrsh7th/nvim-cmp/blob/main/lua/cmp/config/default.lua
return {
  snippet = {expand = function(args) vim.fn['vsnip#anonymous'](args.body) end},
  sources = require'cmp'.config.sources({
    {name = "yank"},
    {name = "treesitter"},
    {name = "nvim_lsp"},
    {name = "vsnip"},
    {name = "buffer", keyword_length = 4},
    {name = "path", keyword_length = 2},
    {name = "tags", keyword_length = 4},
    {name = "spell", keyword_length = 4},
    {name = "nvim_lua"},
  },
  {{name = "buffer"}}),
  mapping = require'cmp'.mapping.preset.insert({
    ['<CR>'] = require'cmp'.mapping.confirm({select = true}),
    ['<Tab>'] = require 'cmp'.mapping.select_next_item();
    ['<C-n>'] = require 'cmp'.mapping.select_next_item();
    ['<C-p>'] = require 'cmp'.mapping.select_prev_item();
  }),
}
