return {
  "L3MON4D3/LuaSnip",
  version = "v2.*",
  enabled = true,
  config = function()

    local ls = require "luasnip"

    ls.config.set_config {
      history = true,
      updateevents = "TextChanged,TextChangedI",
      enable_autosnipts = true,
    }

    vim.keymap.set({ "i", "s" }, "<C-k>", function ()
      if ls.expand_or_jumpable() then
        ls.expand_or_jump()
      end
    end, { silent = true })

    vim.keymap.set({ "i", "s" }, "<C-j>", function ()
      if ls.jumpable(-1) then
        ls.jump(-1)
      end
    end, { silent = true })

    vim.keymap.set("i", "<C-l>", function ()
      if ls.choice_active() then
        ls.change_choice(1)
      end
    end)

    ls.filetype_extend("php", { "php", "twig" })

    require("luasnip.loaders.from_lua").load({ paths = vim.fn.stdpath("config") .. "/luasnippets" })
  end

}
