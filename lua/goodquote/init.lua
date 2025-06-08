local M = {}

function M.GoodQuote()
  print "GoodQuote!"
end

function M.setup(opts)
  -- Merge user opts with defaults
  opts = opts or {}

  -- Create a user command
  vim.api.nvim_create_user_command("GoodQuote", M.GoodQuote, {})

  -- Set up a key mapping
  -- Use opts.keymap if provided, otherwise default
  local keymap = opts.keymap or "<leader>gq"
  -- Create the key map
  vim.api.nvim_set_keymap("n", keymap, ":GoodQuote<CR>", { noremap = true, silent = true })
end

-- Return the module
return M
