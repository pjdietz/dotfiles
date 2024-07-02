return {
  {
    "kylechui/nvim-surround",
    config = function () require("nvim-surround").setup() end
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("todo-comments").setup {}
    end
  },
}
