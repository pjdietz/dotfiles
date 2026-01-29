return {
  cmd = { "ruff", "server" },
  filetypes = { "python" },
  root_markers = {
    "pyproject.toml",
    "ruff.toml",
    ".ruff.toml",
    ".git",
  },
  settings = {
    -- Ruff reads most config from pyproject.toml / ruff.toml.
  },
}
