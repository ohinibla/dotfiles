return {
  "jackMort/ChatGPT.nvim",
  -- event = "VeryLazy",
  cmd = { "ChatGPT", "ChatGPTRun", "ChatGPTEditWithInstructions", "ChatGPTActAs", "ChatGPTCompeleteCode" },
  -- keys = "<leader>C",
  config = function()
    require("chatgpt").setup(
      {
        api_key_cmd = "op read op://MazBob/auth0.openai.com/63xz76vyggvctegbph2b4o66hi --no-newline",
        extra_curl_params = {
          "--socks5",
          "127.0.0.1:10808"
        }
      })
  end,
  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-lua/plenary.nvim",
    "folke/trouble.nvim",
    "nvim-telescope/telescope.nvim"
  }
}
