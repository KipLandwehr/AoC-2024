#!/usr/bin/perl
use warnings;
use strict;

my $debug = 0;
my $total = 0;

while (<>) {
	chomp;

	my ($target, $vals) = split ": ";
	my @values = split " ", $vals;

	my $start = shift @values;

	if (isValid($target, $start, @values)) {
		$total += $target;
	}
}

# Print solution
print "Solution: $total\n";

sub isValid {
	my ($target, $runningTotal, @values) = @_;

	if (@values == 0) {
		return 1 if ($runningTotal == $target);
		return 0;
	}
	if ($runningTotal > $target) {
		return 0;
	}

	my $value = shift @values;

	if (isValid($target, $runningTotal*$value, @values)) {
		return 1;
	}
	elsif (isValid($target, $runningTotal+$value, @values)) {
		return 1;
	}
	else {
		return 0;
	}
}
