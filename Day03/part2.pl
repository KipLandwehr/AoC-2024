#!/usr/bin/perl
use warnings;
use strict;

my $debug = 0;

my $total = 0;
my @muls;
my $input;

INPUT: while (<>) {
	chomp;
	$input .= $_;
}

$input =~ s/don't\(\).*?do\(\)/do\(\)/g;
$input =~ s/don't\(\).*$//;
print "$input\n" if ($debug > 0);

push @muls, ($input =~ /mul\(\d{1,3},\d{1,3}\)/g);
print "@muls\n" if ($debug > 1);

while (@muls) {
	my $instr = shift @muls;
	print "$instr\n" if ($debug > 1);
	my ($oper1, $oper2) = $instr =~ /(\d{1,3}),(\d{1,3})/;
	$total += $oper1*$oper2;
}

# Print solution
print "Solution: $total\n";
