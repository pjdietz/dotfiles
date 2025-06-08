return {
  cmd = { "bash-language-server", "start" },
  filetypes = { "bash", "sh" },
  settings = {
    bashls = {
      diagnostic = {
        excludeGlobs = { ".env" },
      },
    },
  },
}
