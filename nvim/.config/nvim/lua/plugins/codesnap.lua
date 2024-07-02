return {
  "mistricky/codesnap.nvim",
  build = "make build_generator",
  keys = {
    { "<leader>cc", "<cmd>CodeSnap<cr>", mode = "x", desc = "Save selected code snapshot into clipboard" },
    { "<leader>cs", "<cmd>CodeSnapSave<cr>", mode = "x", desc = "Save selected code snapshot in ~/Desktop" },
  },
  opts = {
    save_path = "~/Desktop",
    has_breadcrumbs = false,
    -- bg_theme = "bamboo",
    bg_color = "#ffffff",
  }
}
