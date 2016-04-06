#!/usr/bin/env perl

# This function takes a set of files as an argument, and renames them using padding zeros
#  (This assumes there is only one number in each file name and that this is the index you 
#  want to pad.  If this is not the case then modify the regex line below

use File::Copy;
my @files = @ARGV;

my $maxind = 0;

for $f (@files) {
    # grab the index
    (my $ind) = $f =~ m/([0-9]+)/;  # regex line
    if ($ind > $maxind) {
	$maxind = $ind;
    }
}

# get the target number of digits
my $nd = length($maxind);

for $f (@files) {
    (my $ind) = $f =~ m/([0-9]+)/;  # regex line
    if (defined $ind && $ind >= 0) {
	if (length($ind) < $nd) {
	    my $n = $nd - length($ind);
	    my $zstr = '0' x $n;
	    my $ind2 = "$zstr$ind";
	    my $fnew = $f;
	    $fnew =~ s/$ind/$ind2/;
	    move($f,$fnew);
	}
    }
}
    
