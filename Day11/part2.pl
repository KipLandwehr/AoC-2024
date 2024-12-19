#!/usr/bin/perl
use warnings;
use strict;

my $debug = 1;
my $total = 0;
my $blinks = 75;

my @input = split(" ", <>);
my %cache;

foreach my $s (@input) {
	$total += getValue($s, $blinks);
}

sub getValue {
	my $s = shift;
	my $br = shift;

	if (defined $cache{$br}{$s}) {
		return $cache{$br}{$s};
	}
	if ($br == 0) {
		return 1;
	}

	my @next;

	if ($s == 0) {
		push @next, 1;
	}
	elsif ((length $s)%2 == 0) {	# Even number of digits
		my $len = length $s;
		my $half = $len/2;
		my $left = int(substr($s, 0, $half));
		my $right = int(substr($s, $half));
		push @next, ($left, $right);
	}
	else {				# Odd number of digits
		push @next, ($s*2024);
	}

	my $val = 0;
	foreach my $n (@next) {
		$val += getValue($n, $br-1);
	}
	$cache{$br}{$s} = $val;
	return $val;
}

# Print solution
print "Solution: $total\n";
