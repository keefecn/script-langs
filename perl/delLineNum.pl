#!/usr/bin/perl                                                      
# delLineNum.pl
# usage: 

 open (FILE,"$ARGV[0]") || die "Cannot open file $ARGV[0]";
 open(OUTFILE,">>$ARGV[1]") || die "cannot create file $ARGV[1]";
 while( $line=<FILE> ) {
       $line=~s/^( {0,}|\d)\d{0,}\.//g;
       print OUTFILE ("$line");
 }
 close (FILE);
 close (OUTFILE)
