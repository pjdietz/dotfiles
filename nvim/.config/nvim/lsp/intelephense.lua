-- https://github.com/bmewburn/intelephense-docs/blob/master/installation.md#configuration-options
return {
  cmd = { "intelephense", "--stdio" },
  filetypes = { "php" },
  root_markers = { "composer.json", ".git" },
  -- flags = {
  --   debounce_text_changes = 150,
  -- },
  settings = {
    intelephense = {
      diagnostics = {
        -- Prophecy causes a lot of false positives.
        undefinedMethods = false
      },
      formatting = true,
      -- https://github.com/JetBrains/phpstorm-stubs
      stubs = {
        "Core",
        "Reflection",
        "SPL",
        "bcmath",
        "crypto",
        "curl",
        "date",
        "ds",
        "fpm",
        "filter",
        "hash",
        "json",
        "ldap",
        "memcached",
        "openssl",
        "opentelemetry",
        "pcntl",
        "pcre",
        "pdo",
        "redis",
        "regex",
        "session",
        "superglobals",
        "standard",
        "zlib"
      }
    }
  }
}
