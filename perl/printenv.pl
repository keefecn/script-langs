#!/usr/bin/perl
##
##  printenv -- demo CGI program which just prints its environment
##
##  $ express variable
##  @ express scalar array
##  % express hash array
## mofity: my, our, local 

print "Content-type: text/plain; charset=iso-8859-1\n\n";
foreach $var (sort(keys(%ENV))) {
    $val = $ENV{$var};
    $val =~ s|\n|\\n|g;
    $val =~ s|"|\\"|g;
    print "${var}=\"${val}\"\n";
}

