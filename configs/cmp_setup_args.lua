-- https://github.com/hrsh7th/nvim-cmp/blob/main/lua/cmp/config/default.lua
return {
  snippet = {expand = function(args) vim.fn['vsnip#anonymous'](args.body) end},
  sources = require'cmp'.config.sources({
    {name = "nvim_lua"}, {name = "nvim_lsp"}, {name = "treesitter"},
    {name = "vsnip"}, {name = "buffer", keyword_length = 4},
    {name = "path", keyword_length = 2}, {name = "tags", keyword_length = 4},
    {name = "spell", keyword_length = 4},
  }, {{name = "buffer"}}),
  mapping = require'cmp'.mapping.preset.insert({
    ['<C-y>'] = require'cmp'.mapping.confirm({select = true}),
    ['<C-n>'] = require 'cmp'.mapping.select_next_item();
    ['<C-p>'] = require 'cmp'.mapping.select_prev_item();
  }),
}
