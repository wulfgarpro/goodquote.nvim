return {
  "wulfgarpro/goodquote.nvim",
  build = "make",
  cmd = "GoodQuote",
  keys = {
    { "<leader>gq", "<cmd>GoodQuote<CR>", desc = "GoodQuote" },
  },
  opts = {},
  dependencies = {
    { "nvim-lua/plenary.nvim", lazy = true },
  },
}
