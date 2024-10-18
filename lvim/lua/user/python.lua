-- install plugins
-- local poetry_path_sys
-- if vim.fn.has("win32") == 1 then
-- 	poetry_path_sys = os.getenv("POETRY_ROOT") .. "virtualenvs"
-- elseif vim.fn.has("linux") then
-- 	poetry_path_sys = "~/.cache/pypoetry/virtualenvs"
-- end
for _, plugin in ipairs({
	{
		"linux-cultist/venv-selector.nvim",
		dependencies = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim", "mfussenegger/nvim-dap-python" },
		lazy = false,
		branch = "regexp", -- This is the regexp branch, use this for the new version
		-- poetry_path = poetry_path_sys,
		config = function()
			require("venv-selector").setup({
				settings = {
				-- 	search = {
				-- 		poetry = {
				-- 			command = "fd python$ ~/.cache/pypoetry/virtualenvs/",
				-- 		},
				-- 	},
					options = {
						-- poetry_path = poetry_path_sys,
						notify_user_on_venv_activation = true, -- notifies user on activation of the virtual env
						search_timeout = 5, -- if a search takes longer than this many seconds, stop it and alert the user
            enable_default_searches = true,            -- switches all default searches on/off
					},
				},
			})
		end,
	},
	{ "stevearc/dressing.nvim" },
	{ "mfussenegger/nvim-dap-python" },
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
	},
	{ "nvim-neotest/neotest-python" },
}) do
	lvim.plugins[#lvim.plugins + 1] = plugin
end

-- automatically install python syntax highlighting
lvim.builtin.treesitter.ensure_installed = {
	"python",
}

local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
	{ command = "black", filetypes = { "python" } },
	-- { command = "autopep8", filetypes = { "python" } },
	{ command = "isort", filetypes = { "python" } },
})

-- setup debug adapter
lvim.builtin.dap.active = true
local mason_path = vim.fn.glob(vim.fn.stdpath("data") .. "/mason/")
pcall(function()
	local os_python_bin = ""
	if vim.fn.has("linux") == 1 then
		os_python_bin = "bin"
	else
		os_python_bin = "Scripts"
	end
	require("dap-python").setup(mason_path .. "packages/debugpy/venv/" .. os_python_bin .. "/python")
end)

-- TODO: according to docs, launch.js chould be loaded automatically, but doesn't seem to work.
-- FIX: ???
-- require("dap.ext.vscode").load_launchjs()
local dap = require('dap')
dap.defaults.fallback.external_terminal = {
  command = 'wt';
}

-- neotest-python config
-- setup testing

local Path = require("plenary.path")
local lib = require("neotest.lib")
require("neotest").setup({
	adapters = {
		require("neotest-python")({
			-- Extra arguments for nvim-dap configuration
			-- See https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for values
			dap = {
				justMyCode = false,
				console = "integratedTerminal",
			},
			-- args = { "--log-level", "DEBUG", "--quiet" },
			runner = "unittest",
			python = function()
				if vim.fn.has("linux") == 1 then
					OS_PYTHON_BIN = "bin"
				else
					OS_PYTHON_BIN = "Scripts"
				end
				-- Use activated virtualenv.
				if vim.env.VIRTUAL_ENV then
					return { Path:new(vim.env.VIRTUAL_ENV, OS_PYTHON_BIN, "python").filename }
				elseif lib.files.exists("pyproject.toml") then
					local success, exit_code, data = pcall(
						lib.process.run,
						{ "poetry", "run", "poetry", "env", "info", "-p" },
						{ stdout = true }
					)
					if success and exit_code == 0 then
						local venv = data.stdout:gsub("\r\n", "")
						if venv then
							return { Path:new(venv, OS_PYTHON_BIN, "python.exe").filename }
						end
					end
				end
			end,
      pytest_discover_instances = true,
		}),
	},
  status = { virtual_text = true },
})

lvim.keys.normal_mode["<F3>"] = ":!python %<CR>"

lvim.builtin.which_key.mappings["dm"] = { "<cmd>lua require('neotest').run.run()<cr>", "Test Method" }
lvim.builtin.which_key.mappings["dM"] =
	{ "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>", "Test Method DAP" }
lvim.builtin.which_key.mappings["df"] = {
	"<cmd>lua require('neotest').run.run({vim.fn.expand('%')})<cr>",
	"Test Class",
}
lvim.builtin.which_key.mappings["dF"] = {
	"<cmd>lua require('neotest').run.run({vim.fn.expand('%'), strategy = 'dap'})<cr>",
	"Test Class DAP",
}
lvim.builtin.which_key.mappings["dS"] = { "<cmd>lua require('neotest').summary.toggle()<cr>", "Test Summary" }
lvim.builtin.which_key.mappings["da"] = { "<cmd>lua require('neotest').output_panel.toggle()<cr>", "Test Output" }
lvim.builtin.which_key.mappings["dr"] = { "<cmd>lua require('dap').repl.toggle(nil, 'vsplit')<cr>", "open repl" }
lvim.builtin.which_key.mappings["dl"] = { "<cmd>lua require('dap.ext.vscode').load_launchjs()<cr>", "load launch.json file" }

-- binding for switching
lvim.builtin.which_key.mappings["dz"] = {
	{ "<CMD>VenvSelect<CR>'", "Choose Env  " },
}
