#!/usr/bin/perl
use warnings;
use strict;

# Real values
my $width = 101;
my $height = 103;

# Test values
#my $width = 11;
#my $height = 7;

my $iterations = 100;
my $debug = 0;
my $total = 0;

# Test input
# p=0,4 v=3,-3
# p=6,3 v=-1,-3
# p=10,3 v=-1,2
# p=2,0 v=2,-1
# p=0,0 v=1,3
# p=3,0 v=-2,-2
# p=7,6 v=-1,-3
# p=3,0 v=-1,-2
# p=9,3 v=2,3
# p=7,3 v=-1,2
# p=2,4 v=2,-3
# p=9,5 v=-3,-3

my %robots;

while (<>) {
	chomp;
	print "$_\n" if ($debug > 0);

	my ($px, $py, $vx, $vy) = $_ =~ m/p=([0-9]+),([0-9]+) v=(-?[0-9]+),(-?[0-9]+)/;
	print "$px $py $vx $vy\n" if ($debug > 0);

	$px = ($px + ($vx * $iterations)) % $width;
	$py = ($py + ($vy * $iterations)) % $height;
	$robots{$px}{$py}++;
}

my $q1;
my $q2;
my $q3;
my $q4;

foreach my $x (keys %robots) {
	foreach my $y (keys %{$robots{$x}}) {
		if ($debug > 0) {
			print "$x $y $robots{$x}{$y}\n";
		}
		if ($x > (($width-1)/2) && $y > (($height-1)/2)) {
			$q1 += $robots{$x}{$y};
		}
		elsif ($x < (($width-1)/2) && $y > (($height-1)/2)) {
			$q2 += $robots{$x}{$y};
		}
		elsif ($x < (($width-1)/2) && $y < (($height-1)/2)) {
			$q3 += $robots{$x}{$y};
		}
		elsif ($x > (($width-1)/2) && $y < (($height-1)/2)) {
			$q4 += $robots{$x}{$y};
		}
		else {
			print "^Ignored\n" if ($debug > 0);
		}
	}
}

print "$q1 $q2 $q3 $q4\n" if ($debug > 0);

$total = $q1 * $q2 * $q3 * $q4;

# Print solution
print "Solution: $total\n";
