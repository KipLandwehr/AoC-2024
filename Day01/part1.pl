#!/usr/bin/perl
use warnings;
use strict;

my $debug = 0;

my $total = 0;
my @llist;
my @rlist;

while (<>) {
	chomp;
	my ($left, $right) = split(/\s+/);
	push (@llist, $left);
	push (@rlist, $right);
}

@llist = sort @llist;
@rlist = sort @rlist;

if ($debug > 0) {
	print "Sorted left:\n";
	foreach my $elem (@llist) { print "$elem\n"; }
	print "\nSorted right:\n";
	foreach my $elem (@rlist) { print "$elem\n"; }
}

while (my $left = shift @llist) {
	my $right = shift @rlist;

	$total += abs($left-$right);
}

# Print solution
print "Solution: $total\n";
