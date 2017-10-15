/*
@author: keefe
@date: 2017/10/15
@note: getopt
       #include <unistd.h>
       int getopt(int argc, char * const argv[],
                  const char *optstring);
       extern char *optarg;
       extern int optind, opterr, optopt;

       int getopt_long_only(int argc, char * const argv[],
                  const char *optstring,
                  const struct option *longopts, int *longindex);
*/
#include <stdio.h>  
#include <unistd.h>  
 
void usage()
{
	char* str = "Usage: cmdline.py [options]  \
Options:  \
  -h, --help            show this help message and exit   \
  -v, --verbose         silent output   \
  -o, --output          output file \
";
	printf("Usage: cmdline.py [options]\n%s\n\t%s\n\t%s\n\t%s\n", 
		"Options:", 
		"-h, --help            show this help message and exit",
		"-v, --verbose         silent output ",
		"-o, --output          output file"
		);
}

int get_opt_long()
{
//	static struct option long_options[] = {
//	   {"add",     required_argument, 0,  0 },
//	   {"append",  no_argument,       0,  0 },
//	   {"delete",  required_argument, 0,  0 },
//	   {"verbose", no_argument,       0,  0 },
//	   {"create",  required_argument, 0, 'c'},
//	   {"file",    required_argument, 0,  0 },
//	   {0,         0,                 0,  0 }
//	};
	return 0;
}

int main(int argc, int *argv[])  
{  
	// usage();
	int opt;  
	int opterr = 0;  
	char *output;
	while ((opt = getopt(argc, argv, "ho:v"))!=-1)  
	{	
		printf("%c %s", opt, optarg);
		switch(opt)  
		{	
			case 'o':  
				output = optarg;
				printf("option o-output:'%s'\n", output);  
				break;  
			case 'h':  
				printf("option h-help\n");  
				break;  
			case 'v':  
				printf("option v-verbose\n");  
				break;  
			default:  
				printf("other option :%c\n", opt);  
		}  
	}  
}  