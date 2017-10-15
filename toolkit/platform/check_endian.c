#include <stdio.h>
#include <arpa/inet.h>

// tcp/ip network is big-endian
int isLitter()
{
    int a =1;
    int ret;
    ret = *(char*)&a;
    if(ret)
        printf("litter\n");
    else printf("big\n");
    return ret;
}

void convert_num(int num)
{
    printf("htons(%d) = %d\n", num, htons(num));
    printf("htonl(%d) = %d\n", num, htonl(num));
    printf("ntohs(%d) = %d\n", num, ntohs(num));
    printf("ntohl(%d) = %d\n", num, ntohl(num));
}

int main()
{
    // check litter-endian
    isLitter();

    // convert_num
    convert_num(5);
    convert_num(83886080);

    int i;
    for( i=0; i<20; i++)
        printf("htonl(%d) = %d\n", i, htonl(i));

    for( i=0; i<20; i++)
        printf("ntohl(%d)  = %d\n", i, ntohl(i));
    return 0;
}
