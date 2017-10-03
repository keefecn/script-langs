#include <stdio.h>
#include <arpa/inet.h>

// tcp/ip network is big-endian
int isLitter()
{
  int a =1;
  return *(char*)&a;
}

int main()
{
	if (isLitter()) printf("litter");
	else printf("big");
	printf("\n1=%d\n", htonl(1));
	printf("%d\n", htonl(2));
	printf("%d\n", htonl(3));
	printf("%d\n", htonl(4));
	printf("5=%d\n", htons(5));
	printf("5=%d\n", htonl(5));
	printf("5=%d\n", ntohl(5));
	printf("5=%d\n", ntohs(5));
	printf("6 = %d\n", ntohl(6));
	printf("%d\n", ntohl(808464439));
	printf("%d\n", ntohl(808464439));
	printf("%d\n", htonl(808464439));
	int i;
	for( i=0; i<70; i++)
		printf("%d ntohl = %d\n", i, ntohl(i));
	return 0;
}
