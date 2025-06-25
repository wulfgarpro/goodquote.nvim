#include "gq_rss.h"
#include <lauxlib.h>
#include <lua.h>
#include <lualib.h>

static int _push_rss_items_table(lua_State *L, const char *xml) {
  lua_newtable(L);

  GqRssParser parser;
  gq_rss_parser_init(&parser, xml);

  const char *text;
  size_t length;
  int count = 0;

  while (gq_rss_parser_next_quote(&parser, &text, &length)) {
    // Push into Lua table as t[1]=…, t[2]=…, etc.
    // Use `lua_pushlstring` (with length) and `lua_rawseti` for numeric index.
    lua_pushlstring(L, text, length);
    lua_rawseti(L, -2, ++count);
  }

  return 1;
}

static int gq_parse_rss(lua_State *L) {
  const char *rss_xml = luaL_checkstring(L, 1);

  return _push_rss_items_table(L, rss_xml);
}

int luaopen_gq(lua_State *L) {
  luaL_Reg funcs[] = {
      {"gq_parse_rss", gq_parse_rss}, {NULL, NULL} // Sentinel
  };

  luaL_newlib(L, funcs);

  return 1;
}
