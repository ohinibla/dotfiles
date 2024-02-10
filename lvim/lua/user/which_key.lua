-- Use which-key to add extra bindings with the leader-key prefix
lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
lvim.builtin.which_key.mappings["t"] = {
  name = "+Trouble",
  r = { "<cmd>Trouble lsp_references<cr>", "References" },
  f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
  d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" },
  q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
  l = { "<cmd>Trouble loclist<cr>", "LocationList" },
  w = { "<cmd>Trouble workspace_diagnostics<cr>", "Workspace Diagnostics" },
}

lvim.builtin.which_key.mappings["s"]["T"] = {
  "<CMD>Telescope tags<CR>", "Search Workspace tags"
}

lvim.builtin.which_key.vmappings["s"] = {
  "<cmd>lua require('ssr').open()<CR>", "search and replace"
}

local lazygit_toggle = require("user.functions").lazygit_toggle
local gh_workflow_toggle = require("user.functions").gh_workflow_list

lvim.builtin.which_key.mappings["g"]["g"] = {
  lazygit_toggle, "LazyGit"
}

lvim.builtin.which_key.mappings["g"]["h"] = {
  gh_workflow_toggle, "LazyGit"
}

lvim.builtin.which_key.mappings["C"] = {
  name = "Python",
  c = { "<cmd>lua require('swenv.api').pick_venv()<cr>", "Choose Env" },
}

lvim.builtin.which_key.mappings["q"] = { "<cmd>confirm q<CR>", "Quit" }
lvim.builtin.which_key.mappings["n"] = { "<cmd>Noice dismiss<CR>", "Noice dismiss" }

require("which-key").register {
  g = {
    name = "peek",
    p = {
      name = "peek more",
      d = { "<cmd>lua require('goto-preview').goto_preview_definition()<CR>", "definition" },
      t = { "<cmd>lua require('goto-preview').goto_preview_type_definition()<CR>", "peek type definition" },
      i = { "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>", "peek implantation" },
      r = { "<cmd>lua require('goto-preview').goto_preview_declaration()<CR>", "peek declaration" },
      D = { "<cmd>lua require('goto-preview').goto_preview_references()<CR>", "peek references" }
    },
  }
}


-- lvim.builtin.which_key.mappings["L"].p = {
--   "<cmd>! git --git-dir C:\\Users\\AppData\\Local\\lvim\\.git\\ --work-tree C:\\Users\\AppData\\Local\\lvim\\ add *<cr><cmd>! git --git-dir C:\\Users\\AppData\\Local\\lvim\\.git\\ --work-tree C:\\Users\\AppData\\Local\\lvim\\ commit -m 'update'<cr>",
--   "push LunarVim config" }
