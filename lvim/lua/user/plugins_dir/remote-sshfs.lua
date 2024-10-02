require('telescope').load_extension 'remote-sshfs'
return {
 "nosduco/remote-sshfs.nvim",
 dependencies = { "nvim-telescope/telescope.nvim" },
 opts = {
  -- Refer to the configuration section below
  -- or leave empty for defaults
 },
}
