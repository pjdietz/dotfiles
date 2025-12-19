local languages = {
  "bash",
  "c_sharp",
  "diff",
  "git_config",
  "git_rebase",
  "gitcommit",
  "gitignore",
  "go",
  "html",
  "lua",
  "luadoc",
  "markdown",
  "php",
  "python",
  "sh",
  "sql",
  "vim",
  "vimdoc",
  "yaml",
}

local disabled_languages = {
  "dockerfile",
}

---@module "lazy"
---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  enabled = true,
  lazy = false,
  branch = "main",
  build = ":TSUpdate",
  config = function ()

    require("nvim-treesitter").install(languages)

    vim.api.nvim_create_autocmd("FileType", {
      group = vim.api.nvim_create_augroup("treesitter.setup", {}),
      callback = function (args)
         local buf = args.buf
         local filetype = args.match

         -- check if language is disabled
         for _, disabled in ipairs(disabled_languages) do
           if disabled == filetype then
             return
           end
         end

         -- you need some mechanism to avoid running on buffers that do not
         -- correspond to a language (like oil.nvim buffers), this implementation
         -- checks if a parser exists for the current language
         local language = vim.treesitter.language.get_lang(filetype) or filetype
         if not vim.treesitter.language.add(language) then
           return
         end

         -- replace `fold = { enable = true }`
         vim.wo.foldmethod = "expr"
         vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"

         -- replicate `highlight = { enable = true }`
         vim.treesitter.start(buf, language)

         -- replicate `indent = { enable = true }`
         vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

       end
    })

  end
}
