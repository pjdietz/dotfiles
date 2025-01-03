-- Set this early to avoid adding keymaps with the default leader.
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local options = {

  -- Line Numbers
  number = true,                           -- set numbered lines
  relativenumber = true,                   -- set relative numbered lines
  numberwidth = 4,                         -- set number column width
  signcolumn = "yes",                      -- always show the sign column, otherwise it would shift the text each time

  -- Tabs
  expandtab = true,                        -- convert tabs to spaces
  shiftwidth = 4,                          -- the number of spaces inserted for each indentation
  tabstop = 4,                             -- insert 2 spaces for a tab
  smartindent = true,                      -- make indenting smarter again
  backspace = { "indent", "eol", "start" },

  -- Wrap
  wrap = false,                            -- display lines as one long line
  scrolloff = 8,
  sidescrolloff = 8,
  conceallevel = 0,                        -- so that `` is visible in markdown files

  -- Highlight
  hlsearch = true,                         -- highlight all matches on previous search pattern
  ignorecase = true,                       -- ignore case in search patterns
  smartcase = true,                        -- smart case

  -- Splits
  splitbelow = true,                       -- force all horizontal splits to go below current window
  splitright = true,                       -- force all vertical splits to go to the right of current window
  fillchars= "vert:│",

  -- Invisibles
  list = false,
  listchars = {
    tab = "→ ",
    space = "·",
    nbsp = "␣",
    trail = "•",
    precedes = "«",
    extends = "»",
  },

  -- Presentation
  colorcolumn = { 80, 100 },
  laststatus = 3,
  cmdheight = 0,
  completeopt = { "menuone", "noselect" }, -- mostly just for cmp
  pumheight = 10,                          -- pop up menu height
  showtabline = 0,                         -- never show tabs
  termguicolors = true,                    -- set term gui colors (most terminals support this)
  timeoutlen = 300,                        -- time to wait for a mapped sequence to complete (in milliseconds)
  updatetime = 50,                         -- faster completion (4000ms default)
  cursorline = true,                       -- highlight the current line
  guifont = "DroidSansMono Nerd Font:h18", -- the font used in graphical neovim applications
  showmode = false,                        -- -- INSERT --
  modeline = true,
  errorbells = false,

  -- Wild menu
  wildmenu = true,
  wildmode = "longest:full,full",

  -- Files
  fileencoding = "utf-8",                  -- the encoding written to a file
  backup = false,                          -- creates a backup file
  swapfile = false,                        -- creates a swapfile
  writebackup = false,                     -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
  undofile = true,                         -- enable persistent undo

  -- Mouse and Clipboard
  clipboard = "unnamedplus",               -- allows neovim to access the system clipboard
  mouse = "a",                            -- allow the mouse to be used in neovim
}

vim.opt.shortmess:append "cW"

for k, v in pairs(options) do
  vim.opt[k] = v
end
