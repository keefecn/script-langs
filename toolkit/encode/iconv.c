/*
compile:  gcc -I/usr/include/libxml2/ -lxml2 iconv.c
input:
    test.xml
<?xml version="1.0" encoding="gb2312"?>
<parent>测试</parent>
output:
    测试
1)     iconv
*/
#include <libxml/xmlmemory.h>
#include <libxml/parser.h>
#include <arpa/inet.h>
#include <iconv.h>
#include <string.h>

char * Convert( char *encFrom, char *encTo, const char * in)
{

    static char bufin[1024], bufout[1024], *sin, *sout;
    int mode, lenin, lenout, ret, nline;
    iconv_t c_pt;

    if ((c_pt = iconv_open(encTo, encFrom)) == (iconv_t)-1)
    {
        printf("iconv_open false: %s ==> %s\n", encFrom, encTo);
        return NULL;
    }
    iconv(c_pt, NULL, NULL, NULL, NULL);

    lenin = strlen(in) + 1;
    lenout = 1024;
    sin    = (char *)in;
    sout   = bufout;
    ret = iconv(c_pt, &sin, (size_t *)&lenin, &sout, (size_t *)&lenout);

    if (ret == -1)
    {
        return NULL;
    }

    iconv_close(c_pt);
    return bufout;
}

int main(void)
{
    xmlDocPtr doc = NULL;
    xmlNodePtr cur = NULL;

    doc = xmlParseFile("utf.xml");
    cur = xmlDocGetRootElement(doc);
    printf("orign = %s\n", (char *)xmlNodeGetContent(cur));
    printf("%s\n", Convert("utf-8", "gb2312", (char *)xmlNodeGetContent(cur)));
}

