return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/neotest-go",
    "Issafalcon/neotest-dotnet",
    "olimorris/neotest-phpunit"
  },
  keys = {
    { "<Leader>ntt", function() require("neotest").run.run() end, { desc = "[N]eo[T]est [T]est" } },
    { "<Leader>ntf", function() require("neotest").run.run(vim.fn.expand("%")) end, { desc = "[N]eo[T]est [F]ile" } },
    { "<Leader>nto", function() require("neotest").output.open() end, { desc = "[N]eo[T]est [O]utput" } },
  },
  config = function ()
    -- get neotest namespace (api call creates or returns namespace)
    local neotest_ns = vim.api.nvim_create_namespace("neotest")
    vim.diagnostic.config({
      virtual_text = {
        format = function(diagnostic)
          local message = diagnostic.message
            :gsub("\n", " ")
            :gsub("\t", " ")
            :gsub("%s+", " ")
            :gsub("^%s+", "")
          return message
        end,
      },
    }, neotest_ns)

    local neotest = require("neotest")

    neotest.setup {
      adapters = {
        require("neotest-dotnet"),
        require("neotest-go"),
        require("neotest-phpunit")
      },
      icons = {
        child_indent = "│",
        child_prefix = "├",
        collapsed = "─",
        expanded = "╮",
        failed = "",
        final_child_indent = " ",
        final_child_prefix = "╰",
        non_collapsible = "─",
        passed = "",
        running = "",
        running_animated = { "/", "|", "\\", "-", "/", "|", "\\", "-" },
        skipped = "-",
        unknown = "?"
      },
    }
  end
}
