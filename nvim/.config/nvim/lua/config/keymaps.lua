local map = vim.keymap.set

-- Y works like C and D
map("n", "Y", "y$", { desc = "[Y]ank to end of line" })

-- Splits
map("n", "<Leader>|", "<C-w>v", { desc = "Vertical split" })
map("n", "<Leader>-", "<C-w>s", { desc = "Horizontal split" })

-- Buffers
map("n", "<C-n>", "<CMD>bn<CR>", { desc = "[N]ext buffer" })
map("n", "<C-p>", "<CMD>bp<CR>", { desc = "[P]revious buffer" })
map("n", "<Leader>bd", "<CMD>bd<CR>", { desc = "[B]uffer [D]elete" })
map("n", "<Leader>bo", "<CMD>%bd|e#<CR>", { desc = "[B]uffer [O]nly" })
map("n", "<Leader>ba", "<CMD>Neotree close<CR><CMD>bufdo bwipeout<CR>", { desc = "[B]uffer wipe [A]ll" })
map("n", "<Leader>j", "<CMD>e#<CR>", { desc = "Alternate file" })

-- Keep cursor in place while navigating, joining.
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")
map("n", "J", "mzJ`z")

-- Yank to clipboard
map({ "n", "v" }, "<Leader>y", '"+y', { desc = "[Y]ank to clipboard" })
map("n", "<Leader>Y", '"+Y', { remap = true, desc = "[Y]ank to end of line to clipboard" })
map("n", "<Leader>yb", "gg\"*yG", { desc = "[Y]ank [B]uffer to clipboard" })

map("n", "<Leader><Esc>", "<CMD>nohl<CR>", { desc = "Clear highlight" })

-- Move lines up or down
map("v", "J", "<CMD>move '>+1<CR>gv=gv", { desc = "Move lines down" })
map("v", "K", "<CMD>move '<-2<CR>gv=gv", { desc = "Move lines up" })

-- Indent and keep selection
map({ "v", "x" }, "<", "<gv", { desc = "Unindent" })
map({ "v", "x" }, ">", ">gv", { desc = "Indent" })

-- Remap for dealing with word wrap
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Lookup Treesitter highlight groups under cursor
map("n", "<Leader>th", "<CMD>TSHighlightCapturesUnderCursor<CR>", { desc = "Show TS captures" })

map("n", "<Leader>ti", "<CMD>set list!<CR>", { desc = "[T]oggle [I]nvisibles" })
-- Toggle rulers
local function toggle_column_guides()
  local default = { 80, 100 }
  local current = vim.inspect(vim.opt.colorcolumn:get())
  if current == "{}" then
    vim.opt.colorcolumn = default
  else
    vim.opt.colorcolumn = {}
  end
end
vim.keymap.set("n", "<Leader>tc", toggle_column_guides, { desc = "[T]oggle [C]olumn guides" })

-- Git and merge
map("n", "<Leader>gh", "<CMD>diffget //2<CR>", { desc = "[G]it merge take left" })
map("n", "<Leader>gl", "<CMD>diffget //3<CR>", { desc = "[G]it merge take right" })

map("n", "<Leader>gb", "<CMD>lua Snacks.gitbrowse()<CR>", { desc = "[G]it [B]rowse repo" })

vim.keymap.set("n", "<leader>gd", function()
  if next(require("diffview.lib").views) == nil then
    vim.cmd("DiffviewOpen")
  else
    vim.cmd("DiffviewClose")
  end
end, { desc = "Toggle [G]it [D]iffview" })

map({ "n", "v" }, "<Leader>ct", ":Convert<CR>", { desc = "[C]onvert [T]ext", silent = true })
