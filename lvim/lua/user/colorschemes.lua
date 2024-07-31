for _, plugin in ipairs({
	{ "rebelot/kanagawa.nvim" },
	{ "ellisonleao/gruvbox.nvim", priority = 1000, config = true },
}) do
	lvim.plugins[#lvim.plugins + 1] = plugin
end
