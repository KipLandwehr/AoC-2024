#!/usr/bin/perl
use warnings;
use strict;

my $debug = 0;

my $total = 0;
my %llist;
my %rlist;

while (<>) {
	chomp;
	my ($left, $right) = split(/\s+/);
	$llist{$left}++;
	$rlist{$right}++;
}

foreach my $val (keys %llist) {
	$total += $val*$rlist{$val}*$llist{$val} if ($rlist{$val});
}

# Print solution
print "Solution: $total\n";
