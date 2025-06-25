#pragma once

#include <stddef.h>

typedef struct {
  const char *buffer;
  size_t length;
  size_t offset;
} GqXmlCursor;

void gq_xml_parser_init(GqXmlCursor *cursor, const char *xml);
int gq_xml_parser_next_element(GqXmlCursor *cursor, const char *element_name,
                               const char **content, size_t *content_length);
int gq_xml_parser_next_cdata(GqXmlCursor *cursor, const char **text,
                             size_t *text_length);
