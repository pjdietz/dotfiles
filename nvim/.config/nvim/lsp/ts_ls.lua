return {
  cmd = { "typescript-language-server", "--stdio" },
  filetypes = { "javascript", "typescript", "typescriptreact" },
  init_options = {
    preferences = {
      disableSuggestions = true,
    },
  },
}
