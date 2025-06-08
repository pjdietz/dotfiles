-- https://github.com/golang/tools/blob/master/gopls/doc/settings.md
return {
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gowork", "gotmpl", "gosum" },
  root_markers = { "go.mod", "go.word", ".git" },
  settings = {
    gopls = {
      buildFlags = { "-tags=integration" },
      gofumpt = true
    }
  }
}
