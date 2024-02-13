-- add selctioncount to lualine
local show_selection_count = require("user.functions").show_selection_count
local show_macro_recording = require("user.functions").show_macro_recording
local components = require("lvim.core.lualine.components")
lvim.builtin.lualine.sections.lualine_y = {
  components.location,
  {
    show_selection_count,
    cond = function()
      return vim.fn.mode():find("[vv]") ~= nil
    end
  },
  {
    show_macro_recording
  }
}
