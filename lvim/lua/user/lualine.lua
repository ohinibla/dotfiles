-- add selctioncount to lualine
local components = require("lvim.core.lualine.components")
lvim.builtin.lualine.sections.lualine_y = {
  components.location,
  {
    function()
      local starts = vim.fn.line("v")
      local ends = vim.fn.line(".")
      local count = starts <= ends and ends - starts + 1 or starts - ends + 1
      local wc = vim.fn.wordcount()
      return count .. ":" .. wc["visual_chars"]
    end,
    cond = function()
      return vim.fn.mode():find("[Vv]") ~= nil
    end
  }
}
