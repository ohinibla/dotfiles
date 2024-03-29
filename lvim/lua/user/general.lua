-- neovide font
vim.opt.termguicolors = true
vim.opt.guifont = "JetBrainsMono Nerd Font:h14"
vim.opt.background = "dark"
-- lvim.colorscheme = "gruvbox"
lvim.colorscheme = "kanagawa"


-- general
lvim.log.level = "warn"
lvim.format_on_save = true
vim.opt.relativenumber = true
-- vim.g.tagbar_silent = 1
--
vim.g.skip_ts_context_commentstring_module = true
-- lvim.builtin.treesitter.context_commentstring.enable = false

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false
lvim.builtin.nvimtree.setup.actions.open_file.resize_window = true

vim.g.clever_f_across_no_line = 1
vim.g.vista_stay_on_open = 0
vim.g.vista_echo_cursor = 0
-- lvim.transparent_window = true
