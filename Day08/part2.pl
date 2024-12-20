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
my %radios;

while (<>) {
	chomp;

	my @line = split //;
	push @input, \@line;

	foreach my $i (0..@line-1) {
		my $char = $line[$i];
		push (@{$radios{$char}}, [($.-1), $i]) if ($char ne '.');
	}
}

my %antiNodes;

foreach my $freq (keys %radios) {
	foreach my $i (0..@{$radios{$freq}}-2) {
		foreach my $j ($i+1..@{$radios{$freq}}-1) {
			my ($x1, $y1) = @{$radios{$freq}[$i]};
			my ($x2, $y2) = @{$radios{$freq}[$j]};

			$antiNodes{$x1}{$y1}++;
			$antiNodes{$x2}{$y2}++;

			my $xd = $x2 - $x1;
			my $yd = $y2 - $y1;
			
			my $tx = $x2+$xd;
			my $ty = $y2+$yd;
			while (coordValid([$ty,$tx], \@input)) {
				$antiNodes{$tx}{$ty}++;
				$tx += $xd;
				$ty += $yd;
			}

			$tx = $x1-$xd;
			$ty = $y1-$yd;
			while (coordValid([$ty,$tx], \@input)) {
				$antiNodes{$tx}{$ty}++;
				$tx -= $xd;
				$ty -= $yd;
			}
		}
	}
}

foreach my $x (keys %antiNodes) {
	foreach my $y (keys %{$antiNodes{$x}}) {
		$total++;
	}
}

# Print solution
print "Solution: $total\n";
