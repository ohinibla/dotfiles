-- -- set additional linters
local linters = require("lvim.lsp.null-ls.linters")
linters.setup({
	{
		-- each linter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
		command = "shellcheck",
		---@usage arguments to pass to the formatter
		-- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
		extra_args = { "--severity", "warning" },
		filetypes = { "*" },
	},
	{
		command = "codespell",
		---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
		-- filetypes = { "javascript", "python" },
		filetypes = { "*" },
	},
--   {
--   command = "mypy",
--   ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--   -- filetypes = { "javascript", "python" },
--   filetypes = { "python" },
-- }
})
