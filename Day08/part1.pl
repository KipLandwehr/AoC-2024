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

	if ($debug > 0) {
		print "Line $.: $_\n";
	}

	my @line = split //;
	push @input, \@line;

	foreach my $i (0..@line-1) {
		my $char = $line[$i];
		push (@{$radios{$char}}, [($.-1), $i]) if ($char ne '.');
	}
}

if ($debug > 1) {
	print "Input:\n";
	foreach my $i (0..@input-1) {
		foreach my $j (0..@{$input[$i]}-1) {
			print $input[$i][$j];
		}
		print "\n";
	}
}

my %antiNodes;

foreach my $freq (keys %radios) {
	if ($debug > 2) {
		print "Freq: $freq\n";
		foreach my $i (0..@{$radios{$freq}}-1) {
			print "@{$radios{$freq}[$i]}\n";
		}
	}

	foreach my $i (0..@{$radios{$freq}}-2) {
		foreach my $j ($i+1..@{$radios{$freq}}-1) {
			my ($x1, $y1) = @{$radios{$freq}[$i]};
			my ($x2, $y2) = @{$radios{$freq}[$j]};
			my $xd = $x2 - $x1;
			my $yd = $y2 - $y1;
			
			my $t1x = $x2+$xd;
			my $t1y = $y2+$yd;
			my $t2x = $x1-$xd;
			my $t2y = $y1-$yd;

			$antiNodes{$t1x}{$t1y}++ if (coordValid([$t1y,$t1x], \@input));
			$antiNodes{$t2x}{$t2y}++ if (coordValid([$t2y,$t2x], \@input));
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
