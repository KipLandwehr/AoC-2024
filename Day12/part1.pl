#!/usr/bin/perl
use warnings;
use strict;

use File::Basename qw(dirname);
use Cwd qw(abs_path);
use lib dirname(dirname abs_path $0);
use My::AoC::Helper qw(coordValid getNeighbors);

# example input
# RRRRIICCFF
# RRRRIICCCF
# VVRRRCCFFF
# VVRCCCJFFF
# VVVVCJJCFE
# VVIVCCJJEE
# VVIIICJJEE
# MIIIIIJJEE
# MIIISIJEEE
# MMMISSJEEE

my $debug = 0;
my $total = 0;
my @input;

# Input separator
# $/ = "\n";
while (<>) {
	chomp;
	my @line = split //, $_;
	push @input, \@line;
}

my %visited;
my %regions;
my $rID = 0;

foreach my $r (0..@input-1) {
	foreach my $c (0..@{$input[$r]}-1) {
		next if ($visited{$r}{$c});
		$regions{$rID} = {};
		findRegion($r, $c, $regions{$rID}, \@input);
		foreach my $row (keys %{$regions{$rID}}) {
			foreach my $col (keys %{$regions{$rID}{$row}}) {
				$visited{$row}{$col} = 1;
			}
		}
		$rID++;
	}
}

foreach my $reg (sort { $a <=> $b } keys %regions) {
	my $area = 0;
	my $perimeter = 0;
	foreach my $r (keys %{$regions{$reg}}) {
		foreach my $c (keys %{$regions{$reg}{$r}}) {
			$area++;
			my @neighbors = getNeighbors($r, $c);
			foreach my $coordRef (@neighbors) {
				my ($nr, $nc) = @{$coordRef};
				$perimeter++ unless ($regions{$reg}{$nr}{$nc});
			}
		}
	}
	print "Reg $reg: A=$area, P=$perimeter\n" if ($debug);
	$total += $area * $perimeter;
}


# Print solution
print "Solution: $total\n";

sub findRegion {
	my ($r, $c, $hRef, $aRef) = @_;

	# Do nothing further on this branch if we've already visited the current node
	return if ($$hRef{$r}{$c});

	$$hRef{$r}{$c} = 1;
	my @neighbors = getNeighbors($r, $c);
	foreach my $coordRef (@neighbors) {
		if (coordValid($coordRef, $aRef)) {
			my ($nR, $nC) = @{$coordRef};
			next if ($$aRef[$r][$c] ne $$aRef[$nR][$nC]);
			findRegion($nR, $nC, $hRef, $aRef);
		}
	}
}

