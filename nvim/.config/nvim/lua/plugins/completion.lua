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
      ["<C-Space>"] = {
        function()
          require("copilot.suggestion").next()
          require("blink.cmp")["hide"]()
          return true
        end
      },
      ["<C-n>"] = {
        function ()
          local cop = require("copilot.suggestion")
          if cop.is_visible() then
            cop.next()
            return true
          end
        end,
        "select_next",
        "fallback",
      },
      ["<C-p>"] = {
        function ()
          local cop = require("copilot.suggestion")
          if cop.is_visible() then
            cop.prev()
            return true
          end
        end,
        "select_prev",
        "fallback",
      },
      ["<C-y>"] = {
        function ()
          local cop = require("copilot.suggestion")
          if cop.is_visible() then
            cop.accept()
            return true
          end
        end,
        "select_and_accept",
        "fallback",
      }
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
      default = function(ctx)
        local success, node = pcall(vim.treesitter.get_node)
        if vim.bo.filetype == "markdown" then
          return { "buffer", "path" }
        elseif success and node and vim.tbl_contains({ "comment", "line_comment", "block_comment" }, node:type()) then
          return { "buffer" }
        else
          return { "lsp", "path", "snippets", "buffer" }
        end
      end,
      -- default = { "lsp", "path", "snippets", "buffer" },
      min_keyword_length = 0,
      providers = {
        lsp = {
          score_offset = 4,
        },
        snippets = {
          score_offset = 3,
        },
        path = {
          -- min_keyword_length = 5,
          score_offset = 2,
        },
        buffer = {
          -- min_keyword_length = 5,
          score_offset = 1,
        },
        cmdline = {
          min_keyword_length = function(ctx)
            -- when typing a command, only show when the keyword is 3 characters or longer
            if ctx.mode == "cmdline" and string.find(ctx.line, " ") == nil then return 3 end
            return 0
          end
        }
      }
    },

    completion = {
      menu = {
        border = "single",
        auto_show = function(ctx)
          return vim.bo.filetype ~= "markdown"
        end,
        draw = {
          columns = {
            { "kind_icon", gap = 1 },
            { "label", "label_description", gap = 1 },
            { "kind" },
            { "source_name" }
          },
        },
      },
      documentation = {
        treesitter_highlighting = true,
        window = {
          border = "single",
          winblend = 0,
          winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,EndOfBuffer:BlinkCmpDoc",
        }
      },
    },

    cmdline = {
      enabled = true,
      keymap = { preset = "cmdline" },
      completion = {
        ghost_text = { enabled = true }
      }
    },

    signature = { window = { border = "solid" } },

  },
  opts_extend = { "sources.default" }
}
