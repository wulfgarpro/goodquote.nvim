#include <lauxlib.h>
#include <lua.h>
#include <lualib.h>

static int gq_parse_rss(lua_State *L) {
  const char *rss_xml = luaL_checkstring(L, 1);
  // For now we'll just return the input string as is.
  lua_pushstring(L, rss_xml);
  return 1; // 1 for one return value.
}

int luaopen_gq(lua_State *L) {
  luaL_Reg funcs[] = {
      {"gq_parse_rss", gq_parse_rss}, {NULL, NULL} // Sentinel
  };

  luaL_newlib(L, funcs);

  return 1;
}
