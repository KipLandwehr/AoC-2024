#!/usr/bin/perl
use warnings;
use strict;

#use File::Basename qw(dirname);
#use Cwd qw(abs_path);
#use lib dirname(dirname abs_path $0);
#use My::AoC::Helper qw(coordValid getDirOffsetCoord);

my $debug = 0;
my $total = 0;

my $count = 0;
my $fileid = 0;
my @disc;

my $input = <>;
chomp $input;
my @in = split(//, $input);

foreach my $i (0..@in-1) {
	if ($i%2 == 0) {	# file
		push (@disc, ($fileid) x $in[$i]);
		$fileid++;
	}
	else {		# free space
		push (@disc, ('.') x $in[$i]);
	}
	$count++;
}

print @disc, "\n" if ($debug);

my $l = 0;
my $r = @disc - 1;

while ($l < $r) {
	while ($disc[$l] ne '.') {
		$l++;
	}
	while ($disc[$r] eq '.') {
		$r--;
	}
	last if ($l >= $r);

	$disc[$l] = $disc[$r];
	$disc[$r] = '.';
}

for my $i (0..@disc-1) {
	last if ($disc[$i] eq '.');
	$total += $i * $disc[$i];
}

# Print solution
print "Solution: $total\n";
