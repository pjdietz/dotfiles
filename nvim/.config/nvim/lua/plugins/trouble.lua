return {
  "folke/trouble.nvim",
  opts = { },
  cmd = "Trouble",
  keys = {
    {
      "<Leader>ts",
      "<CMD>Trouble symbols toggle focus=false<CR>",
      desc = "[T]oggle [S]ymbols"
    },
    {
      "<Leader>td",
      "<CMD>Trouble diagnostics toggle<CR>",
      desc = "[T]oggle [D]iagnostics"
    }
  }
}
