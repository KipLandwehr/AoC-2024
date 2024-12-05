#!/usr/bin/perl
use warnings;
use strict;

my $debug = 0;

my $total = 0;

INPUT: while (<>) {
	chomp;
	my @report = split(/\s+/);
	if (checkReport(@report)) {
		$total++;
		next INPUT;
	}
	print "@report\n" if ($debug > 0);
	foreach my $i (0..@report-1) {
		my @reportCopy = @report;
		splice @reportCopy, $i, 1;
		print "Index $i: @reportCopy\n" if ($debug > 1);
		if (checkReport(@reportCopy)) {
			$total++;
			next INPUT;
		}
	}
}

# Print solution
print "Solution: $total\n";

sub checkReport {
	my @report = @_;
	my $increasing;
	foreach my $index ( 1..@report-1 ) {
		my $diff = $report[$index-1] - $report[$index];

		# Check if all "levels" are increasing or decreasing
		if ($diff == 0) { return 0; }
		elsif ($diff < 0) { return 0 if ($increasing); }
		else {
			$increasing = 1 if ($index == 1);
			return 0 unless ($increasing);
		}

		# Check if level changes are within range
		$diff = abs($diff);
		return 0 if ($diff > 3);
	}
	return 1;
}
