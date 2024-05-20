-- Configure Lazy for plugin management
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load configurations from the module found in ./lua/user
require("user.options")
require("user.keymap")

-- Load plugins sepcs with Lazy from ./lua/plugins
require("lazy").setup("plugins", {
    change_detection = {
      -- automatically check for config file changes and reload the ui
      enabled = false,
      notify = false, -- get a notification when changes are found
    },
})
