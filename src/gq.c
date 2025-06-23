#include <lauxlib.h>
#include <lua.h>
#include <lualib.h>

static int hello(lua_State *L) {
  lua_pushstring(L, "Hello from C!");
  return 1;
}

int luaopen_gq(lua_State *L) {
  luaL_Reg funcs[] = {{"hello", hello}, {NULL, NULL}};
  luaL_newlib(L, funcs);
  return 1;
}
