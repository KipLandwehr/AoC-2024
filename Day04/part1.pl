#!/usr/bin/perl
use warnings;
use strict;

use File::Basename qw(dirname);
use Cwd qw(abs_path);
use lib dirname(dirname abs_path $0);
use My::AoC::Helper qw(coordValid getDirOffsetCoord);

my $debug = 0;
my $total = 0;

my @input;

while (<>) {
	chomp;
	my @row = split '';
	push @input, [@row];
}

foreach my $row (0..@input-1) {
	foreach my $col (0..@{$input[$row]}-1) {
		next unless ($input[$row][$col] eq 'X');
		$total += xmasCount($row,$col);
	}
}

# Print solution
print "Solution: $total\n";

sub xmasCount {
	my ($row, $col) = @_;
	my $count = 0;

	my %dirs = (
		nw => [-1, -1],
		n => [-1, 0],
		ne => [-1, 1],
		e => [0, 1],
		se => [1, 1],
		s => [1, 0],
		sw => [1, -1],
		w => [0, -1]
	);
	my @letters = qw(X M A S);

	print "R:$row, C:$col\n" if ($debug > 1);
	DIR: foreach my $dir (keys %dirs) {
		foreach my $dist (1..@letters-1) {
			my @check = getDirOffsetCoord([$row,$col], $dir, $dist);
			print "@check\n" if ($debug > 2);
			if (coordValid(\@check, \@input)) {
				my $cRow = $check[0];
				my $cCol = $check[1];
				next DIR unless ($input[$cRow][$cCol] eq $letters[$dist]);
			}
			else { next DIR; }
		}
		$count++;
	}
	print "Count: $count\n\n" if ($debug > 1);
	return $count;
}
