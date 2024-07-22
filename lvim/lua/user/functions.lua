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
      -- Percentage of the Neovim window's width
      width = function() return math.floor(vim.o.columns * 0.95) end,
      -- Percentage of the Neovim window's height
      height = function() return math.floor(vim.o.lines * 0.95) end,
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
    cmd = "gh run watch $(gh run list --limit 1 --json databaseId --jq '.[0].databaseId')",
    hidden = true,
    direction = "vertical",
    auto_scroll = true,
    close_on_exit = false,
    -- on_open = function(_)
    --   vim.cmd "startinsert!"
    -- end,
    count = 98,
  }
  workflow:toggle(40)
end

M.gh_workflow_run_and_list = function()
  local Terminal = require("toggleterm.terminal").Terminal
  local workflow = Terminal:new {
    cmd = "gh workflow run",
    hidden = true,
    direction = "vertical",
    auto_scroll = true,
    close_on_exit = true,
    on_exit = function ()
      vim.cmd("sleep 1000m")
      M.gh_workflow_list()
    end,
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
    return "󰑊 Recording @" .. recording_register
  end
end

-- TODO: add error handling and progress update
M.get_dotfiles_update_git = function()
  vim.loop.spawn("git", {
    args = { "-C", "C:\\Users\\Babak\\.config\\dotfiles\\", "fetch" },
    stdio = { nil, nil, nil }
  }, function(code)
    if code == 0 then
      local handle = io.popen("git -C C:\\Users\\Babak\\.config\\dotfiles\\ status")
      local result = handle:read("*a")
      handle:close()
      if string.match(result, "Your branch is behind") or string.match(result, "Your branch and 'origin/main' have diverged") then
        vim.notify("Update available for dotfiles repository  ", "warn")
      else
        vim.notify("Dotfiles config is up to date ", "info")
      end
    else
      vim.notify("there was an error fetching dotfiles updates 😢", "error")
    end
  end)
end

return M
