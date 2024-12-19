#!/usr/bin/perl
use warnings;
use strict;

my $debug = 0;
my $total = 0;
my $blinks = 25;

my @working = split(" ", <>);
my @next;

foreach my $i (1..$blinks) {
	if ($debug) {
		print "Round $i\n";
		print "@working\n";
	}

	while (@working) {
		my $s = shift @working;
		if ($s == 0) {
			$s = 1;
			push @next, $s;
		} elsif ((length $s)%2 == 0) {	# Even number of digits
			my $len = length $s;
			my $half = $len/2;
			my $left = int(substr($s, 0, $half));
			my $right = int(substr($s, $half));
			push @next, $left, $right;
		} else {			# Odd number of digits
			$s *= 2024;
			push @next, $s;
		}
	}
	@working = @next;
	@next = ();
}

$total = @working;

# Print solution
print "Solution: $total\n";
