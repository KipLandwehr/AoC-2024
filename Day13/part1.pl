#!/usr/bin/perl
use warnings;
use strict;

my $debug = 0;
my $total = 0;

$/ = "\n\n";
while (<>) {
	chomp;
	my @lines = split(/\n/, $_);

	print "Lines: @lines\n" if ($debug > 1);

	my ($ax, $ay) = $lines[0] =~ /X\+(\d+), Y\+(\d+)/;
	my ($bx, $by) = $lines[1] =~ /X\+(\d+), Y\+(\d+)/;
	my ($px, $py) = $lines[2] =~ /X=(\d+), Y=(\d+)/; 

	if ($debug > 1) {
		print "ax: $ax, ay: $ay\n";
		print "bx: $bx, by: $by\n";
		print "px: $px, py: $py\n";
	}

	my $b = ($ay*$px - $ax*$py) / ($ay*$bx - $ax*$by);
	unless ($b == int($b)) {
		print "Record $.: $b is not an integer\n" if ($debug > 0);
		next;
	}

	my $a = ($py - $b*$by) / $ay;
	unless ($a == int($a)) {
		print "Record $.: $a is not an integer\n" if ($debug > 0);
		next;
	}

	$total += 3*$a + $b;
}

# Print solution
print "Solution: $total\n";
