#pragma once

#include "gq_xml.h"
#include <stddef.h>

typedef struct {
  GqXmlCursor cursor;
} GqRssParser;

void gq_rss_parser_init(GqRssParser *parser, const char *xml);
int gq_rss_parser_next_quote(GqRssParser *parser, const char **text,
                             size_t *text_length);
