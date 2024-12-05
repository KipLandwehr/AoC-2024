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
		next unless ($input[$row][$col] eq 'A');
		$total += xmasCount($row,$col);
	}
}

# Print solution
print "Solution: $total\n";

sub xmasCount {
	my ($row, $col) = @_;
	my $count = 0;

	my @dirs = qw(nw se ne sw);

	# Think slopes on a graph ;)
	my $neg = "";
	my $pos = "";

	print "R:$row, C:$col\n" if ($debug > 1);
	DIR: foreach my $i (0..@dirs-1) {
		my @check = getDirOffsetCoord([$row,$col], $dirs[$i], 1);
		print "@check\n" if ($debug > 2);

		return 0 unless (coordValid(\@check, \@input));

		my $cRow = $check[0];
		my $cCol = $check[1];
		if ($input[$cRow][$cCol] eq 'M' || $input[$cRow][$cCol] eq 'S') {
			$neg .= $input[$cRow][$cCol] if ($i <= 1);
			$pos .= $input[$cRow][$cCol] if ($i >= 2);
		}
		else { return 0; }
	}
	return 1 if ( ($pos eq "MS" || $pos eq "SM") && ($neg eq "MS" || $neg eq "SM") );
}
