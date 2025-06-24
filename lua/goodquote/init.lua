package.cpath = package.cpath .. ";src/build/?.so"

local M = {}
local gq = require "gq"
local curl = require "plenary.curl"

function M.GoodQuote()
  if M.config and M.config.rss_url then
    local rss_url = M.config.rss_url

    -- Validate the RSS URL.
    -- For now, just confirm `rss_url` includes the Goodreads quotes RSS URL.
    if not rss_url:find "https://www.goodreads.com/quotes/list_rss/" then
      print "GoodQuote: Invalid Goodreads quotes RSS URL."
      return
    end

    local rss_xml_response = curl.get(rss_url)

    if rss_xml_response.status ~= 200 then
      print "GoodQuote: Failed to fetch RSS feed."
      return
    end

    -- print(rss_xml_response.body)

    local m = gq.gq_parse_rss(rss_xml_response.body)
    print(m)
  else
    print "GoodQuote: `rss_url` not set in configuration."
  end
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
