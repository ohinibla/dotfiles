-- TODO: use async capability so that it doesn't effect start-up time
local git_work_tree = "C:\\Users\\Babak\\.config\\dotfiles\\"
local git_dir = git_work_tree .. ".git"

local handle = io.popen("git -C " .. git_work_tree .. " fetch && git -C " .. git_work_tree .. " status")
local result = handle:read("*a")
handle:close()

if string.match(result, "Your branch is behind") then
  vim.notify("Update available for dotfiles repository", vim.log.levels.WARN)
else
  vim.notify("No update available for dotfiles repository", vim.log.levels.WARN)
end
