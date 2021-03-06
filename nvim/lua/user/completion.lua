local cmp = require "cmp"
if not cmp then
  return
end

local lspkind = require "lspkind"
lspkind.init()

local luasnip = require "luasnip"

cmp.setup({
  snippet = {
    expand = function (args)
      luasnip.lsp_expand(args.body)
    end
  },
  mapping = {
    ["<C-n>"] = cmp.mapping(cmp.mapping.select_next_item()),
    ["<C-p>"] = cmp.mapping(cmp.mapping.select_prev_item()),
    ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
    ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
    ["<C-e>"] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  },
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "nvim_lua" },
    { name = "luasnip" },
    { name = "buffer" },
    -- { name = "buffer", keyword_length = 5 },
  }),
  formatting = {
    format = lspkind.cmp_format {
      mode = "symbol_text",
      maxwidth = 50,
      menu = {
        buffer = "[buf]",
        nvim_lsp = "[LSP]",
      }
    }
  },
  experimental = {
    native_menu = false,
    ghost_text = true
  }
})
