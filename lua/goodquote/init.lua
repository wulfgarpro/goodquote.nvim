package.cpath = package.cpath .. ";/home/pwent/code/personal/goodquote.nvim/src/build/?.so"

local M = {}
local gq = require "gq"
local curl = require "plenary.curl"

function M.GoodQuote()
  if not M.opts or not M.opts.rss_url then
    vim.notify("GoodQuote: `rss_url` not set in opts.", vim.log.levels.ERROR)
    return
  end

  local rss_url = M.opts.rss_url

  -- Validate the RSS URL.
  -- For now, just confirm `rss_url` includes the Goodreads quotes RSS URL.
  if not rss_url:find "https://www.goodreads.com/quotes/list_rss/" then
    vim.notify("GoodQuote: Invalid Goodreads quotes RSS URL.", vim.log.levels.ERROR)
    return
  end

  local rss_xml_response = curl.get(rss_url)

  if rss_xml_response.status ~= 200 then
    vim.notify("GoodQuote: Failed to fetch RSS feed.", vim.log.levels.ERROR)
    return
  end

  local q = gq.gq_parse_rss(rss_xml_response.body)
  if #q > 0 then
    vim.notify(q[math.random(#q)], vim.log.levels.INFO)
  else
    vim.notify("GoodQuote: No quotes found.", vim.log.levels.WARN)
  end
end

function M.setup(opts)
  opts = opts or {}
  M.opts = opts
  -- Define the user command
  vim.api.nvim_create_user_command("GoodQuote", M.GoodQuote, {})
end

-- Return the module
return M
