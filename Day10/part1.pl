#!/usr/bin/perl
use warnings;
use strict;

use File::Basename qw(dirname);
use Cwd qw(abs_path);
use lib dirname(dirname abs_path $0);
use My::AoC::Helper qw(coordValid getNeighbors);

my $debug = 0;
my $total = 0;
my @input;

while (<>) {
	chomp;
	my @line = split //, $_;
	push @input, \@line;
}

foreach my $r (0..@input-1) {
	foreach my $c (0..(@{$input[$r]}-1)) {
		next if ($input[$r][$c] != 0);
		print "0 found at $r, $c\n" if ($debug);
		my @nines = walk(1, $r, $c, \@input);
		my @uNines = uniq(@nines);
		$total += @uNines;
	}
}

# Print solution
print "Solution: $total\n";

sub walk {
	my ($val, $r, $c, $map) = @_;
	my @neighbors = getNeighbors($r, $c);

	if ($val == 10) { 	# Indicates that we're looking for 10, sitting on a 9
		print "$val found at $r, $c\n" if ($debug);
		return [$r, $c];
	}
	my @ends;
	foreach my $n (@neighbors) {
		if (coordValid($n, \@input)) {
			my ($nr, $nc) = @{$n};
			if ($map->[$nr][$nc] == $val) {
				print "$val found at $nr, $nc\n" if ($debug);
				push @ends, walk($val+1, $nr, $nc, $map);
			}
		}
	}
	return @ends;
}
sub uniq {
	my %seen;
	while (@_) {
		my $loc_ref = shift @_;
		my ($r, $c) = @{$loc_ref};
		$seen{$r}{$c}++;
	}
	my @retVal;
	foreach my $r (keys %seen) {
		foreach my $c (keys %{$seen{$r}}) {
			push @retVal, [$r, $c];
		}
	}
	return @retVal;
}
