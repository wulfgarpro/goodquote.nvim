#include "gq_rss.h"
#include "gq_xml.h"

void gq_rss_parser_init(GqRssParser *parser, const char *xml) {
  gq_xml_parser_init(&parser->cursor, xml);
}

int gq_rss_parser_next_quote(GqRssParser *parser, const char **text,
                             size_t *text_length) {
  if (!text || !text_length)
    return 0;

  const char *item_content;
  size_t item_length;
  const char *desc_content;
  size_t desc_length;

  if (!gq_xml_parser_next_element(&parser->cursor, "item", &item_content,
                                  &item_length))
    return 0;

  GqXmlCursor item_cursor = {item_content, item_length, 0};
  if (!gq_xml_parser_next_element(&item_cursor, "description", &desc_content,
                                  &desc_length))
    return 0;

  GqXmlCursor desc_cursor = {desc_content, desc_length, 0};
  if (!gq_xml_parser_next_cdata(&desc_cursor, text, text_length))
    return 0;

  return 1;
}
