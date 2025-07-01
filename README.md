# goodquote.nvim

A Neovim plugin that displays quotes from your [Goodreads](https://goodreads.com) list - fast and
minimal, with a native C backend.

## Features

- Fetches and displays a random quote from a Goodreads RSS feed.
- Simple and fast (uses a native C parser).
- Trigger via `:GoodQuote` or `<leader>gq`.
- Fully compatible with [lazy.nvim](https://github.com/folke/lazy.nvim).

## Installation

Using [lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
{
  "wulfgarpro/goodquote.nvim",
  keys = {
    { "<leader>gq", "<cmd>GoodQuote<CR>", desc = "GoodQuote" },
  },
  opts = {
    rss_url = "https://www.goodreads.com/quotes/list_rss/12541417-james-fraser",
  },
}
```

> Tip: Replace the RSS URL with your own - available via the "RSS feed" link on your
> [Goodreads quote list](https://www.goodreads.com/quotes/list).

## Configuration

The plugin defines a single command `:GoodQuote`.

To lazy-load it, just use a keymap (as shown above). You can also explicitly lazy-load on command:

```lua
cmd = "GoodQuote", -- optional
```

To disable the keymap:

```lua
keys = {
  { "<leader>gq", false },
},
```

## Usage

- Run `:GoodQuote` in Neovim.
- Or press `<leader>gq` in normal mode.

## Notes

- Requires `make`, a C compiler, and LuaJIT development headers.
- The native shared object (`gq.so`) is compiled automatically.

## LICENSE

MIT @ [James Fraser](https://wulfgar.pro)
