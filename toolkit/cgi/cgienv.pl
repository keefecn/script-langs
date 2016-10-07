#! /usr/bin/perl -wT

use strict;

print "Content-type: text/html\n\n";

#print '<center>';
print '<table border="1" cellspacing="0" cellpadding="0">';
print '<caption>CGI Environment Variables</caption>';
print '<tr><td>Name</td><td>Value</td></tr>';


my $var_name;
foreach $var_name ( sort keys %ENV ){
    print "<tr><td>$var_name</td>";
    print "<td>$ENV{$var_name}</td></tr>";
    #print $ENV{$var_name};
}

print '</table>';
#print '</center>';
