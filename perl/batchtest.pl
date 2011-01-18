#! /usr/bin/perl
# method1: system()
# method2: prove [options] [files/directories]

use lib qw(./blib/lib ./blib/arch);
use strict;
use warnings;
use Test::More qw(no_plan);
use TokyoCabinet;
$TokyoCabinet::DEBUG = 1;

my @commands = (
                "tchtest.pl write casket 10000",
                "tchtest.pl read casket",
                "tchtest.pl remove casket",
                "tchtest.pl misc casket 1000",
                );

foreach my $command (@commands){
    my $rv = system("$^X $command >/dev/null");
    ok($rv == 0, $command);
}

system("rm -rf casket*");
