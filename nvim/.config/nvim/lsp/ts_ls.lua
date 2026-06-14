return {
  cmd = { "typescript-language-server", "--stdio" },
  filetypes = { "javascript", "typescript", "typescriptreact", "vue" },
  init_options = {
    preferences = {
      disableSuggestions = true,
    },
  },
}
