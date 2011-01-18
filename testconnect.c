/*
*filename: simple-socket.c
*/
#include <stdio.h>
#include <string.h>
#include <errno.h>
#include <sys/socket.h>
#include <resolv.h>
#include <stdlib.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <unistd.h>

#define MAXBUF 1024

int main(int argc, char **argv)
{
	int sockfd;
	struct sockaddr_in dest;
	char buffer[MAXBUF];

	if (argc != 3) {
		printf("useage: %s [ip] [port]\n", argv[0]);
		exit(0);
	}
	/* TCP socket*/
	if ((sockfd = socket(AF_INET, SOCK_STREAM, 0)) < 0) {
		perror("Socket");
		exit(errno);
	}
	printf("socket ok\n");    

    //set sockopt


	// init server
	bzero(&dest, sizeof(dest));
	dest.sin_family = AF_INET;
	dest.sin_port = htons(atoi(argv[2]));
	if (inet_aton(argv[1], (struct in_addr *) &dest.sin_addr.s_addr) == 0) {
		perror(argv[1]);
		exit(errno);
	}


	// connect to server
	if (connect(sockfd, (struct sockaddr *) &dest, sizeof(dest)) != 0) {
		perror("Connect ");
		exit(errno);
	}
	printf("connect to %s:%s ok\n", argv[1], argv[2]);

	//send  or recv data and process it
	bzero(buffer, MAXBUF);
	send(sockfd, buffer, sizeof(buffer),0);
	recv(sockfd, buffer, sizeof(buffer), 0);
	printf("recv: %s", buffer);

	//close
	close(sockfd);

	return 0;
}
