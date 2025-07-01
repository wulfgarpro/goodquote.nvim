PLUGIN_NAME = gq
SRC_DIR     = src
TEST_DIR    = test
BUILD_DIR   = .

COMMON_SRC  = $(SRC_DIR)/gq_xml.c $(SRC_DIR)/gq_rss.c
SRC         = $(SRC_DIR)/gq.c
TEST_SRC    = $(TEST_DIR)/gq_xml_test.c $(TEST_DIR)/gq_rss_test.c
CFLAGS     += -O2 -fPIC -I$(SRC_DIR)
LDFLAGS    += -shared
LUA_FLAGS  := $(shell pkg-config --cflags --libs luajit)

all:
	$(CC) $(CFLAGS) $(LDFLAGS) $(SRC) $(COMMON_SRC) -o $(BUILD_DIR)/$(PLUGIN_NAME).so $(LUA_FLAGS)

test:
	$(CC) $(CFLAGS) $(TEST_SRC) $(COMMON_SRC) -o $(BUILD_DIR)/$(PLUGIN_NAME)_test

clean:
	rm -f $(BUILD_DIR)/$(PLUGIN_NAME).so $(BUILD_DIR)/$(PLUGIN_NAME)_test

.PHONY: all clean test
