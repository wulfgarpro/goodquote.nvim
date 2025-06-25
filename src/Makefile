PLUGIN_NAME = gq
COMMON_SRC  = gq_xml.c gq_rss.c
SRC         = gq.c
TEST_SRC    = test/gq_xml_test.c test/gq_rss_test.c
BUILD_DIR   = build
CFLAGS     += -O2 -fPIC -I.
LDFLAGS    += -shared
LUA_FLAGS  := $(shell pkg-config --cflags --libs luajit)

all:
	mkdir -p $(BUILD_DIR)
	$(CC) $(CFLAGS) $(LDFLAGS) $(SRC) $(COMMON_SRC) -o $(BUILD_DIR)/$(PLUGIN_NAME).so $(LUA_FLAGS)

test:
	mkdir -p $(BUILD_DIR)
	$(CC) $(CFLAGS) $(TEST_SRC) $(COMMON_SRC) -o $(BUILD_DIR)/$(PLUGIN_NAME)_test

clean:
	rm -rf $(BUILD_DIR)/*

.PHONY: all clean test
