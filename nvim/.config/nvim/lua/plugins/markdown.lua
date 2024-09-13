return {
  "MeanderingProgrammer/render-markdown.nvim",
  opts = {},
  dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
  config = function ()
    require("render-markdown").setup({
      heading = {
        position = "inline",
        icons = { "󰉫", "󰉬", "󰉭", "󰉮", "󰉯", "󰉰" },
        signs = { "󰌕" },
      },
      bullet = {
        icons = { "", "", "", "" },
      },
      checkbox =  {
        unchecked = {
          icon = "󰄱",
        },
        checked = {
          icon = "󰱒"
        },
        custom = {
          progress1 = { raw = "[.]", rendered = '', highlight = 'RenderMarkdownUnchecked' },
          progress2 = { raw = "[o]", rendered = '', highlight = 'RenderMarkdownUnchecked' },
          progress3 = { raw = "[O]", rendered = '', highlight = 'RenderMarkdownUnchecked' },
        },
      }
    })
  end
}
