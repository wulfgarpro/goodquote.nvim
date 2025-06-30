package.cpath = package.cpath .. ";/home/pwent/code/personal/goodquote.nvim/src/build/?.so"

local M = {}
local gq = require "gq"
local curl = require "plenary.curl"

function M.GoodQuote()
  if not M.opts or not M.opts.rss_url then
    print "GoodQuote: `rss_url` not set in opts."
    return
  end

  local rss_url = M.opts.rss_url

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

  local q = gq.gq_parse_rss(rss_xml_response.body)
  if #q > 0 then
    print(q[math.random(#q)])
  else
    print "GoodQuote: No quotes found."
  end
end

function M.setup(opts)
  -- Merge user opts with defaults.
  opts = opts or {}

  M.opts = opts

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
