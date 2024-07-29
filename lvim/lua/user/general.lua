--   ____ _____ _   _ _____ ____      _    _
--  / ___| ____| \ | | ____|  _ \    / \  | |
-- | |  _|  _| |  \| |  _| | |_) |  / _ \ | |
-- | |_| | |___| |\  | |___|  _ <  / ___ \| |___
--  \____|_____|_| \_|_____|_| \_\/_/   \_\_____|
--
--

-- neovide font
vim.opt.termguicolors = true
vim.opt.guifont = "JetBrainsMono Nerd Font:h12"
vim.opt.background = "dark"
-- lvim.colorscheme = "gruvbox"
lvim.colorscheme = "kanagawa"

-- general
lvim.log.level = "warn"

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

vim.fn.setreg('x', vim.fn.setreg('a', vim.fn.getreg('a') .. '\n'))
