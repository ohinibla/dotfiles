return {
  "AckslD/swenv.nvim",
  opts = {
    post_set_venv = function()
      vim.cmd("LspRestart")
    end,
  }
}
