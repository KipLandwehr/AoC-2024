#!/usr/bin/perl
use warnings;
use strict;

my $debug = 0;

my $total = 0;

INPUT: while (<>) {
	chomp;
	my @report = split(/\s+/);
	my $increasing;
	foreach my $index ( 1..@report-1 ) {
		my $diff = $report[$index-1] - $report[$index];

		# Check if all "levels" are increasing or decreasing
		if ($diff == 0) { next INPUT; }
		elsif ($diff < 0) { next INPUT if ($increasing); }
		else {
			$increasing = 1 if ($index == 1);
			next INPUT unless ($increasing);
		}

		# Check if level changes are within range
		$diff = abs($diff);
		next INPUT if ($diff > 3);
	}
	$total++;
}

# Print solution
print "Solution: $total\n";
