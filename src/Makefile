PLUGIN_NAME = gq
SRC         = gq.c
BUILD_DIR   = ../build
CFLAGS     += -O2 -fPIC
LDFLAGS    += -shared
LUA_FLAGS  := $(shell pkg-config --cflags --libs luajit)

all:
	mkdir -p $(BUILD_DIR)
	$(CC) $(CFLAGS) $(LDFLAGS) $(SRC) -o $(BUILD_DIR)/$(PLUGIN_NAME).so $(LUA_FLAGS)

clean:
	rm -f $(BUILD_DIR)/$(PLUGIN_NAME).so

.PHONY: all clean
