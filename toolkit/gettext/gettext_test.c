/*
@usage: gettext
@step
gcc -o gettext_test gettext_test.c
*/
#include <stdio.h>
#include <locale.h>
#include <libintl.h>

#define _(string) gettext(string)

int main ()
{
	setlocale (LC_ALL, "");
	bindtextdomain ("gettext_test", "language");
	textdomain ("gettext_test");
	printf (_("Hello world!\n"));
	return 0;
}
