-- os specific config
vim.notify = require("notify")

if (vim.fn.has('linux') == 1)
then
  vim.notify("os specific python venv path...LINUX", "info")
  -- set proper virtual env
  vim.g.python3_host_prog = "/home/babak/.pyenv/versions/neovim/bin/python"
elseif (vim.fn.has('win32') == 1)
then
  vim.notify("os specific python venv path...WIN32", "info")
  -- Enable powershell as your default shell
  vim.opt.shell = "pwsh.exe"
  vim.opt.shellcmdflag =
  "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;"
  vim.cmd [[
    let &shellredir = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
    let &shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
    set shellquote= shellxquote=
  ]]
  -- Set a compatible clipboard manager
  vim.g.clipboard = {
    copy = {
      ["+"] = "win32yank.exe -i --crlf",
      ["*"] = "win32yank.exe -i --crlf",
    },
    paste = {
      ["+"] = "win32yank.exe -o --lf",
      ["*"] = "win32yank.exe -o --lf",
    },
  }
  -- set proper virtual env
  vim.g.python3_host_prog = "C:\\Users\\Babak\\.pyenv-win-venv\\envs\\py3nvim\\Scripts\\python.exe"
end
