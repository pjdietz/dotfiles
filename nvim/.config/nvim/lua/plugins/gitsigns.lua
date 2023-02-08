return {
  "lewis6991/gitsigns.nvim",
  opts = {
    signcolumn = true,
    preview_config = {
      -- Options passed to nvim_open_win
      border = "single",
      style = "minimal",
      relative = "cursor",
      row = 0,
      col = 1
    },
    on_attach = function (bufnr)
      local function map(mode, lhs, rhs, opts)
        opts = vim.tbl_extend("force", { noremap = true, silent = true }, opts or {})
        vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts)
      end

      -- Navigation
      map("n", "]c", "&diff ? ']c' : '<CMD>Gitsigns next_hunk<CR>'", { desc = "Next git hunk", expr = true })
      map("n", "[c", "&diff ? '[c' : '<CMD>Gitsigns prev_hunk<CR>'", { desc = "Previous git hunk", expr = true })

      -- Actions
      map("n", "<leader>hs", "<CMD>Gitsigns stage_hunk<CR>", { desc = "[H]unk [S]tage" } )
      map("v", "<leader>hs", "<CMD>Gitsigns stage_hunk<CR>", { desc = "[H]unk [S]tage" } )
      map("n", "<leader>hr", "<CMD>Gitsigns reset_hunk<CR>", { desc = "[H]unk [R]eset" } )
      map("v", "<leader>hr", "<CMD>Gitsigns reset_hunk<CR>", { desc = "[H]unk [R]eset" } )
      map("n", "<leader>hp", "<cMD>Gitsigns preview_hunk<CR>", { desc = "[H]unk [P]review" } )
    end
  }
}
