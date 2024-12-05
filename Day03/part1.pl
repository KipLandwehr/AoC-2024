#!/usr/bin/perl
use warnings;
use strict;

my $debug = 0;

my $total = 0;
my @muls;

INPUT: while (<>) {
	chomp;
	push @muls, ($_ =~ /mul\(\d{1,3},\d{1,3}\)/g);
}

print "@muls\n" if ($debug > 0);

while (@muls) {
	my $instr = shift @muls;
	print "$instr\n" if ($debug > 0);
	my ($oper1, $oper2) = $instr =~ /(\d{1,3}),(\d{1,3})/;
	$total += $oper1*$oper2;
}

# Print solution
print "Solution: $total\n";
