local M = {}

M.get_poetry_envs = function()
  local Path = require('plenary.path')
  local scan_dir = require('plenary.scandir').scan_dir
  local get_venvs_for = function(base_path, source, opts)
    local venvs = {}
    if base_path == nil then
      return venvs
    end
    local paths = scan_dir(base_path, vim.tbl_extend('force', { depth = 1, only_dirs = true, silent = true }, opts or {}))
    for _, path in ipairs(paths) do
      table.insert(venvs, {
        name = Path:new(path):make_relative(base_path),
        path = path,
        source = source,
      })
    end
    return venvs
  end
  local get_poetry_root = function()
    local poetry_root = vim.fn.getenv('POETRY_ROOT')
    if poetry_root == vim.NIL then
      return nil
    else
      return Path:new(poetry_root) .. 'virtualenvs'
    end
  end
  local poetry_env_path = get_venvs_for(get_poetry_root(), 'poetry', { only_dirs = true })
  return poetry_env_path
end

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

M.show_selection_count = function()
  local starts = vim.fn.line("v")
  local ends = vim.fn.line(".")
  local count = starts <= ends and ends - starts + 1 or starts - ends + 1
  local wc = vim.fn.wordcount()
  return count .. ":" .. wc["visual_chars"]
end

M.show_macro_recording = function()
  local recording_register = vim.fn.reg_recording()
  if recording_register == "" then
    return ""
  else
    return "Recording @" .. recording_register
  end
end

return M
