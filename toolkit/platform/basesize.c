#if defined(__STDC_VERSION__) && __STDC_VERSION__ >= 199901L
    #define  __C99__
#endif

#if defined(__C99__) && !defined(__cplusplus)
    #include <stdbool.h>
#endif

#include <stdio.h>

int main()
{
    printf( "\n" );

#ifdef __STDC__
    printf( "Standard C Compiler!\n" );
#endif
#ifdef __cplusplus
    printf( "C++ Compiler!\n" );
#endif
#ifdef __STDC_VERSION__
    printf( "Standard C Version: %ld\n", __STDC_VERSION__ );
#endif

    printf( "\n" );
    printf( "size of char: %d\n", sizeof(char) );
    printf( "size of unsigned char: %d\n", sizeof(unsigned char) );
    printf( "size of short int: %d\n", sizeof(short int) );
    printf( "size of unsigned short int: %d\n", sizeof(unsigned short int) );
    printf( "size of int: %d\n", sizeof(int) );
    printf( "size of unsigned int: %d\n", sizeof(unsigned int) );
    printf( "size of long int: %d\n", sizeof(long int) );
    printf( "size of unsigned long int: %d\n", sizeof(unsigned long int) );

#if defined(__C99__) || defined(__cplusplus)
    printf( "size of bool: %d\n", sizeof(bool) );
#endif

#ifdef __C99__
    printf( "size of long long int: %d\n", sizeof(long long int) );
    printf( "size of unsigned long long int: %d\n", sizeof(unsigned long long int) );
#endif

    printf( "size of float: %d\n", sizeof(float) );
    printf( "size of double: %d\n", sizeof(double) );
    printf( "size of long double: %d\n", sizeof(long double) );
    printf( "size of void*: %d\n", sizeof(void*) );

    printf( "\npress any key to exit!\n" );
    getchar();
    return 0;
}

