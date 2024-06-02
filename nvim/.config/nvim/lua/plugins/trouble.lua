return {
  "folke/trouble.nvim",
  opts = { },
  cmd = "Trouble",
  keys = {
    {
      "<Leader>ss",
      "<CMD>Trouble symbols toggle focus=false<CR>",
      desc = "[S]how [S]ymbols"
    },
    {
      "<Leader>sd",
      "<CMD>Trouble diagnostics toggle<CR>",
      desc = "[S]how [D]iagnostics"
    }
  }
}
