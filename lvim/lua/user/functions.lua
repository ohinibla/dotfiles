local M = {}

M.lazygit_toggle = function()
  local Terminal = require("toggleterm.terminal").Terminal
  local lazygit = Terminal:new {
    cmd = "lazygit",
    hidden = true,
    direction = "float",
    float_opts = {
      --NOTE: causes neovide to terminate in windows
      -- border = "none",
      -- width = 100000,
      -- height = 100000,
      border = "curved",
    },
    on_open = function(_)
      vim.cmd "startinsert!"
    end,
    on_close = function(_) end,
    count = 99,
  }
  lazygit:toggle()
end

M.gh_workflow_list = function()
  local Terminal = require("toggleterm.terminal").Terminal
  local workflow = Terminal:new {
    cmd = "gh run watch",
    hidden = true,
    direction = "vertical",
    auto_scroll = true,
    close_on_exit = false,
    count = 98,
  }
  workflow:toggle(40)
end

return M
