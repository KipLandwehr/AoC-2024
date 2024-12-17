#!/usr/bin/perl
use warnings;
use strict;

use File::Basename qw(dirname);
use Cwd qw(abs_path);
use lib dirname(dirname abs_path $0);
use My::AoC::Helper qw(coordValid getDirOffsetCoord);

my $debug = 0;
my $total = 0;

my @input;

while (<>) {
	chomp;
	my @row = split '';
	push @input, [@row];
}

my @coord;
my @dirs = qw(n e s w);
my $dir = 0;

FSTART: foreach my $r(0..@input-1) {
	foreach my $c(0..@{$input[$r]}-1) {
		if ($input[$r][$c] eq '^') {
			@coord = ($r, $c);
			last FSTART;
		}
	}
}

my %visited;

while (1) {
	$visited{"$coord[0],$coord[1]"}++;
	my @nextCoord = getDirOffsetCoord(\@coord, $dirs[$dir], 1);
	print "@coord\n" if ($debug > 0);
	if (coordValid(\@nextCoord, \@input)) {
		if ($input[$nextCoord[0]][$nextCoord[1]] eq '#') {
			$dir = ($dir+1)%4;
		}
		else { @coord = @nextCoord; }
	}
	else { last; }
}

$total = keys %visited;

# Print solution
print "Solution: $total\n";

