-- -- set a formatter, this will override the language server formatting capabilities (if it exists)
lvim.format_on_save.enabled = true
lvim.format_on_save.pattern = { "*.py" }

local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { command = "stylua",   filetypes = { "lua" } },
  -- { command = "black",    filetypes = { "python" } },
  -- { command = "autopep8", filetypes = { "python" } },
  -- { command = "isort",    filetypes = { "python" } },
  { command = "codespell" },
  {
    -- each formatter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
    command = "prettier",
    ---@usage arguments to pass to the formatter
    -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
    extra_args = { "--print-with", "100" },
    ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
    filetypes = { "javascript", "typescript", "typescriptreact", "css", "html", "yaml" },
  },
}
