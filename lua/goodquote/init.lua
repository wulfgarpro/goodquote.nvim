package.cpath = package.cpath .. ";src/build/?.so"

local gq = require "gq"
local M = {}

function M.GoodQuote()
  print("Fetching quotes from: " .. (M.config and M.config.rss_url or "URL not set"))
  print(gq.hello())
end

function M.setup(opts)
  -- Merge user opts with defaults.
  opts = opts or {}

  M.config = opts

  -- Create a user command `:GoodQuote`.
  vim.api.nvim_create_user_command("GoodQuote", M.GoodQuote, {})

  -- Set up a key mapping.
  -- Use `opts.keymap`, if provided, otherwise a default.
  local keymap = opts.keymap or "<leader>gq"
  -- Create the key map.
  vim.keymap.set("n", keymap, M.GoodQuote, {
    desc = "GoodQuote",
    silent = true, -- Prevents the cmd from being echoed in the command line.
  })
end

-- Return the module
return M
