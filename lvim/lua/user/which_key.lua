local functions_module = require("user.functions")
local lazygit_toggle = functions_module.lazygit_toggle
local gh_workflow_toggle = functions_module.gh_workflow_list
local gh_workflow_run_watch = functions_module.gh_workflow_run_and_list
local grep_lunarvim_config_folder = functions_module.grep_lunarvim_config_folder

-- Use which-key to add extra bindings with the leader-key prefix
lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects  " }
lvim.builtin.which_key.mappings["t"] = {
	name = "+Trouble",
	r = { "<cmd>Trouble lsp_references<cr>", "References" },
	f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
	d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" },
	q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
	l = { "<cmd>Trouble loclist<cr>", "LocationList" },
	w = { "<cmd>Trouble workspace_diagnostics<cr>", "Workspace Diagnostics" },
}

lvim.builtin.which_key.mappings["s"] = {
	T = { "<CMD>!ctags -R %<CR><CMD>Telescope tags<CR>", "Search Workspace tags" },
	d = { "<CMD>TodoTelescope<CR>", "Search TODO" },
	m = { "<CMD>Telescope vim_bookmarks<CR>", "Search marks " },
	f = {
		"<CMD>lua require('telescope.builtin').find_files(require('telescope.themes').get_ivy({ winblend = 50 }))<CR>",
		"Find File ",
	},
	r = {
		"<CMD>lua require('telescope.builtin').oldfiles(require('telescope.themes').get_ivy({ winblend = 50 }))<CR>",
		"Open Recent File 󰔠",
	},
	h = {
		"<CMD>lua require('telescope.builtin').help_tags(require('telescope.themes').get_ivy({ winblend = 50 }))<CR>",
		"Find Help ",
	},
}

lvim.builtin.which_key.mappings["f"] = {
	"<CMD>lua require('telescope.builtin').git_files(require('telescope.themes').get_ivy({ winblend = 50 }))<CR>",
	"Search files  ",
}

lvim.builtin.which_key.vmappings["s"] = {
	"<cmd>lua require('ssr').open()<CR>",
	"search and replace  ",
}

lvim.builtin.which_key.mappings["z"] = {
	name = "Extra",
	e = { "<CMD>IconPickerInsert<CR>", "Icon Picker -> Insert ⌣" },
}

lvim.builtin.which_key.mappings["L"]["x"] = {
	grep_lunarvim_config_folder,
	"Grep LunarVim files ",
}

lvim.builtin.which_key.mappings["g"]["g"] = {
	lazygit_toggle,
	"LazyGit",
}

lvim.builtin.which_key.mappings["g"]["h"] = {
	name = "Github Actions  ",
	w = { gh_workflow_toggle, "Github Workflow watch" },
	r = { gh_workflow_run_watch, "Github Workflow run and watch" },
}

lvim.builtin.which_key.mappings["q"] = { "<cmd>confirm q<CR>", "Quit ❌" }
lvim.builtin.which_key.mappings["n"] = { "<cmd>Noice dismiss<CR>", "Noice dismiss" }

require("which-key").register({
	g = {
		name = "peek",
		p = {
			name = "peek more",
			d = { "<cmd>lua require('goto-preview').goto_preview_definition()<CR>", "definition" },
			t = { "<cmd>lua require('goto-preview').goto_preview_type_definition()<CR>", "peek type definition" },
			i = { "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>", "peek implantation" },
			r = { "<cmd>lua require('goto-preview').goto_preview_declaration()<CR>", "peek declaration" },
			D = { "<cmd>lua require('goto-preview').goto_preview_references()<CR>", "peek references" },
		},
	},
})

lvim.builtin.which_key.mappings["C"] = {
	name = "ChatGPT 🤖",
	c = { "<cmd>ChatGPT<CR>", "ChatGPT" },
	e = { "<cmd>ChatGPTEditWithInstruction<CR>", "Edit with instruction", mode = { "n", "v" } },
	g = { "<cmd>ChatGPTRun grammar_correction<CR>", "Grammar Correction", mode = { "n", "v" } },
	t = { "<cmd>ChatGPTRun translate<CR>", "Translate", mode = { "n", "v" } },
	k = { "<cmd>ChatGPTRun keywords<CR>", "Keywords", mode = { "n", "v" } },
	d = { "<cmd>ChatGPTRun docstring<CR>", "Docstring", mode = { "n", "v" } },
	a = { "<cmd>ChatGPTRun add_tests<CR>", "Add Tests", mode = { "n", "v" } },
	o = { "<cmd>ChatGPTRun optimize_code<CR>", "Optimize Code", mode = { "n", "v" } },
	s = { "<cmd>ChatGPTRun summarize<CR>", "Summarize", mode = { "n", "v" } },
	f = { "<cmd>ChatGPTRun fix_bugs<CR>", "Fix Bugs", mode = { "n", "v" } },
	x = { "<cmd>ChatGPTRun explain_code<CR>", "Explain Code", mode = { "n", "v" } },
	r = { "<cmd>ChatGPTRun roxygen_edit<CR>", "Roxygen Edit", mode = { "n", "v" } },
	l = { "<cmd>ChatGPTRun code_readability_analysis<CR>", "Code Readability Analysis", mode = { "n", "v" } },
	z = { "<cmd>ChatGPTRun answer_with_context<CR>", "explain continuously (gpt-4o 󰚩 ) ", mode = { "n", "v" } },
}

-- TODO: write indicator with notify
-- local git_work_tree = "C:\\Users\\Babak\\.config\\dotfiles\\"
-- local git_dir = git_work_tree .. ".git"
-- lvim.builtin.which_key.mappings["L"].p = {
--   "<cmd>! git --git-dir=" .. git_dir .. " --work-tree=" .. git_work_tree .. " pull<cr>",
--   "pull dotfiles config" }

lvim.builtin.which_key.mappings["L"].p = {
	{
		"<CMD>lua require('user.functions').get_dotfiles_update_git()<CR>",
		"check dotfiles for updates",
	},
}
