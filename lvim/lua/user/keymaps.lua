--  _  _________   ____  __    _    ____  ____
-- | |/ / ____\ \ / /  \/  |  / \  |  _ \/ ___|
-- | ' /|  _|  \ V /| |\/| | / _ \ | |_) \___ \
-- | . \| |___  | | | |  | |/ ___ \|  __/ ___) |
-- |_|\_\_____| |_| |_|  |_/_/   \_\_|   |____/
--
-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping
-- lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"
lvim.keys.normal_mode["<C-Q>"] = false
lvim.keys.normal_mode["<C-V>"] = false
lvim.keys.insert_mode["jk"] = "<ESC>"
lvim.keys.normal_mode["<F8>"] = ":Vista!!<CR>"
lvim.keys.normal_mode["<F9>"] = vim.cmd.UndotreeToggle
lvim.keys.normal_mode["ms"] = ":Telescope bookmarks list<CR>"
lvim.keys.normal_mode["<C-E>"] = "ct"
lvim.keys.normal_mode["?"] = vim.cmd.ChatGPT

-- lvim.keys.normal_mode["gx"] = [[:execute '!firefox ' . shellescape(expand('<cfile>'), 1)<CR>]]
-- leap mappings
vim.keymap.set({ "n", "x", "o" }, "s", "<Plug>(leap-forward)")
vim.keymap.set({ "n", "x", "o" }, "S", "<Plug>(leap-backward)")
vim.keymap.set({ "n", "x", "o" }, "gs", "<Plug>(leap-from-window)")

-- Adding the following keymap, will redirect the active cmdline when pressing <S-Enter>.
-- The cmdline stays open, so you can change the command and execute it again.
-- When exiting the cmdline, the popup window will be focused.
vim.keymap.set("c", "<S-Enter>", function()
	require("noice").redirect(vim.fn.getcmdline())
end, { desc = "Redirect Cmdline" })

-- unmap a default keymapping
-- vim.keymap.del("n", "<C-Up>")
-- override a default keymapping
-- lvim.keys.normal_mode["<C-q>"] = ":q<cr>" -- or vim.keymap.set("n", "<C-q>", ":q<cr>" )

-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
-- local _, actions = pcall(require, "telescope.actions")
-- lvim.builtin.telescope.defaults.mappings = {
--   -- for input mode
--   i = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--     ["<C-n>"] = actions.cycle_history_next,
--     ["<C-p>"] = actions.cycle_history_prev,
--   },
--   -- for normal mode
--   n = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--   },
-- }

-- if lsp hover doc present, use <C-f> and <C-b> to scroll lsp window
vim.keymap.set({ "n", "i", "s" }, "<c-f>", function()
	if not require("noice.lsp").scroll(4) then
		return "<c-f>"
	end
end, { silent = true, expr = true })

vim.keymap.set({ "n", "i", "s" }, "<c-b>", function()
	if not require("noice.lsp").scroll(-4) then
		return "<c-b>"
	end
end, { silent = true, expr = true })

