#!/usr/bin/perl
use warnings;
use strict;

#use File::Basename qw(dirname);
#use Cwd qw(abs_path);
#use lib dirname(dirname abs_path $0);
#use My::AoC::Helper qw(coordValid getDirOffsetCoord);

my $debug = 0;
my $total = 0;

$/ = "\n\n";
my @rules = split '\n', <>;

my %lessThan;
while (@rules) {
	my ($left, $right) = split /\|/, (shift @rules);
	print "L:$left, R:$right\n" if ($debug > 1);
	push @{$lessThan{$right}}, $left;
}

if ($debug > 1) {
	print "$_ $lessThan{$_}\n" for (keys %lessThan);
}

$/ = "\n";
while (<>) {
	chomp;
	my @orig = split /,/;

	if ($debug > 0) {
		print "Pre-sort\n";
		print "@orig\n";
	}

	my @sorted = sort compare @orig;

	if ($debug > 0) {
		print "Post-sort\n";
		print "@orig\n";
		print "@sorted\n";
		print "The lists are identical.\n" if ( @orig ~~ @sorted );
		print "\n";
	}

	if ( @orig ~~ @sorted ) {
		$total += $orig[((@orig-1)/2)];
	}
}

# Print solution
print "Solution: $total\n";

sub compare {
	#if ($a < $b) { return -1; }
	#elsif ($a == $b) { return 0; }
	#else { return 1; }
	if ( $a == $b ) { return 0; }
	elsif ( $a ~~ @{$lessThan{$b}} ) { return -1; }
	elsif ( $b ~~ @{$lessThan{$a}} ) { return 1; }
	else {
		print "Rule for values $a and $b not found.\n";
		return 0;
	}
}


