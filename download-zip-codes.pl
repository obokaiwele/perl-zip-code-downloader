#!/usr/bin/perl
use strict;      # forces variable declaration
use warnings;    # uses more verbose output from program

use autodie;     # die if problem reading or writing a file
use LWP::Simple; # enables access to internet content

$| = 1;          # prevent output buffering. Output is shown immediately

my $url = 'http://www.allareacodes.com/area-code-list.htm';
my $outputFile = 'area-codes.txt';

###############################################################
# get web file and cache its contents locally
###############################################################
print "Downloading zip codes...";
my $file = get($url);
print "done\n";

###############################################################
# parse web file and find all zip codes
###############################################################
print "Parsing zip codes...";
my $regex = '<a href="/[0-9]{3}">([0-9]{3})</a>';
my @zipCodes = $file =~ m/$regex/g;
print "done\n";

###############################################################
# create new output file. Overwrite existing output file if any
###############################################################
open(OUTPUT, '>' . $outputFile) or 
    die 'Unable to create output file - ' . $outputFile;

###############################################################
# save zip codes to output file
###############################################################
print "Saving zip codes...";
print OUTPUT join("\n", @zipCodes);
close (OUTPUT);
print "done\n";
