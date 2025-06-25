#include "gq_xml.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void gq_xml_parser_init(GqXmlCursor *cursor, const char *xml) {
  cursor->buffer = xml;
  cursor->length = strlen(xml);
  cursor->offset = 0;
}

static int
_gq_xml_parser_next_section(GqXmlCursor *cursor, const char *open_marker,
                            size_t open_marker_len, const char *close_marker,
                            size_t close_marker_len, const char **out_start,
                            size_t *out_len) {
  const char *open_ptr, *close_ptr;

  open_ptr =
      memmem(cursor->buffer + cursor->offset, cursor->length - cursor->offset,
             open_marker, open_marker_len);
  if (!open_ptr)
    return 0;

  *out_start = open_ptr + open_marker_len;

  close_ptr =
      memmem(*out_start,
             cursor->length - (open_ptr - cursor->buffer) - open_marker_len,
             close_marker, close_marker_len);
  if (!close_ptr)
    return 0;

  *out_len = close_ptr - *out_start;

  cursor->offset = (close_ptr - cursor->buffer) + close_marker_len;

  return 1;
}

int gq_xml_parser_next_element(GqXmlCursor *cursor, const char *element_name,
                               const char **content, size_t *content_length) {
  if (!element_name || !*element_name)
    return 0;

  char open_marker[32], close_marker[32];
  size_t open_marker_len, close_marker_len;

  open_marker_len =
      snprintf(open_marker, sizeof(open_marker), "<%s>", element_name);
  if (open_marker_len >= sizeof(open_marker))
    return 0;
  close_marker_len =
      snprintf(close_marker, sizeof(close_marker), "</%s>", element_name);
  if (close_marker_len >= sizeof(close_marker))
    return 0;

  return _gq_xml_parser_next_section(cursor, open_marker, open_marker_len,
                                     close_marker, close_marker_len, content,
                                     content_length);
}

int gq_xml_parser_next_cdata(GqXmlCursor *cursor, const char **text,
                             size_t *text_length) {
  const char *open_marker = "<![CDATA[";
  const char *close_marker = "]]>";
  size_t open_marker_len = strlen(open_marker);
  size_t close_marker_len = strlen(close_marker);

  return _gq_xml_parser_next_section(cursor, open_marker, open_marker_len,
                                     close_marker, close_marker_len, text,
                                     text_length);
}
