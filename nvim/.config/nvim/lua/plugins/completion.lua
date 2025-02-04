return {
  "saghen/blink.cmp",
  dependencies = {
    { "L3MON4D3/LuaSnip", version = "v2.*" },
    "rafamadriz/friendly-snippets",
  },
  version = "*",

  ---@module "blink.cmp"
  ---@type blink.cmp.Config
  opts = {
    keymap = {
      preset = "default",
      ["<C-Space>"] = { "show", "fallback" },
      ["<CR>"] = { "select_and_accept", "fallback" },
    },

    appearance = {
      -- Sets the fallback highlight groups to nvim-cmp's highlight groups
      -- Useful for when your theme doesn't support blink.cmp
      -- Will be removed in a future release
      use_nvim_cmp_as_default = true,
      -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
      nerd_font_variant = "mono"
    },

    snippets = {
      expand = function(snippet) require("luasnip").lsp_expand(snippet) end,
      active = function(filter)
        if filter and filter.direction then
          return require("luasnip").jumpable(filter.direction)
        end
        return require("luasnip").in_snippet()
      end,
      jump = function(direction) require("luasnip").jump(direction) end,
    },

    -- Default list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, due to `opts_extend`
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
    },

    completion = {
      menu = {
        border = "single",
        auto_show = function(ctx)
          return ctx.mode ~= "cmdline"
            and vim.bo.filetype ~= "markdown"
        end,
      },
      documentation = {
        treesitter_highlighting = true,
        window = {
          border = "single",
          winblend = 0,
          winhighlight = 'Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,EndOfBuffer:BlinkCmpDoc',
        }
      },
    },

    signature = { window = { border = "solid" } },

  },
  opts_extend = { "sources.default" }
}
