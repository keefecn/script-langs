#include <string.h>
#include <libxml/encoding.h>

unsigned char* ConvertInput(const char *in, const char *encoding)
{
    unsigned char *out;
    int ret;
    int size;
    int out_size;
    int temp;
    xmlCharEncodingHandlerPtr handler;
 
    if (in == 0)
        return 0;
 
    handler = xmlFindCharEncodingHandler(encoding);
 
    if (!handler) {
        printf("ConvertInput: no encoding handler found for '%s'\n",
               encoding ? encoding : "");
        return 0;
    }
 
    size = (int) strlen(in) + 1;
    out_size = size * 2 - 1;
    out = (unsigned char *) xmlMalloc((size_t) out_size);
 
    if (out != 0) {
        temp = size - 1;
        ret = handler->input(out, &out_size, (const unsigned char *) in, &temp);
        if ((ret < 0) || (temp - size + 1)) {
            if (ret < 0) {
                printf("ConvertInput: conversion wasn't successful.\n");
            } else {
                printf
                    ("ConvertInput: conversion wasn't successful. converted: %i octets.\n",
                     temp);
            }
 
            xmlFree(out);
            out = 0;
        } else {
            out = (unsigned char *) xmlRealloc(out, out_size + 1);
            out[out_size] = 0; /*null terminating out */
        }
    } else {
        printf("ConvertInput: no mem\n");
    }
 
    return out;
}
 
int main(int argc, char **argv)
{
	unsigned char *content, *out;
	xmlDocPtr doc;
	xmlNodePtr rootnode;
	// char *encoding = "ISO-8859-1";   //utf-8, ISO-8859-1
	char *encoding = "iso-8859-1";   //utf-8, ISO-8859-1
	if (argc <= 1) {
		  printf("Usage: %s content\n", argv[0]);
		  return(0);
	}
	content = argv[1];

	out = ConvertInput(content, encoding);
	printf( "%s:%s\n", encoding, out );
	doc = xmlNewDoc ("1.0");
	rootnode = xmlNewDocNode(doc, NULL, (const xmlChar*)"root", out);
	xmlDocSetRootElement(doc, rootnode);
	xmlSaveFormatFileEnc("-", doc, encoding, 1);

	return 0;
}

