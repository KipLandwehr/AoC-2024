#!/usr/bin/perl
use warnings;
use strict;

#use File::Basename qw(dirname);
#use Cwd qw(abs_path);
#use lib dirname(dirname abs_path $0);
#use My::AoC::Helper qw(coordValid getDirOffsetCoord);

my $debug = 0;
my $total = 0;

my $fileid = 0;
my @disc;

my $input = <>;
chomp $input;
my @in = split(//, $input);

my $block = 0;
my %files;	# file{ID} = [start_block, length]

foreach my $i (0..@in-1) {
	if ($i%2 == 0) {	# file
		push (@disc, ($fileid) x $in[$i]);
		push (@{$files{$fileid}}, $block, $in[$i]);
		$fileid++;
	}
	else {		# free space
		push (@disc, ('.') x $in[$i]);
	}
	$block += $in[$i];
}

# scan disc for contiguous free spaces
my %free;		# free{start} = length
my $len = 0;
my $pos = 0;
for my $i (0..@disc-1) {
	if ($disc[$i] eq '.') {
		$len++;
		if ($len == 1) {
			$pos = $i;
		}
	}
	else {
		if ($len > 0) {
			$free{$pos} = $len;
			$len = 0;
		}
	}
}

if ($debug > 1) {
	print "File Start Length\n";
	foreach my $id (sort { $a <=> $b } keys %files) {
		print "$id $files{$id}[0] $files{$id}[1]\n";
	}
	print "Free spaces: Start Length\n";
	foreach my $fs (sort { $a <=> $b } keys %free) {
		print "$fs $free{$fs}\n";
	}
}

foreach my $id (reverse sort { $a <=> $b } keys %files) {
	my $len = $files{$id}[1];
	foreach my $fs (sort { $a <=> $b } keys %free) {
		last if ($fs > $files{$id}[0]);
		if ($free{$fs} >= $len) {
			$files{$id}[0] = $fs;
			if ($free{$fs} == $len) {
				delete $free{$fs};
			}
			else {
				$free{$fs+$len} = $free{$fs} - $len;
				delete $free{$fs};
			}
			last;
		}
	}
}

print "File Start Length\n" if ($debug);
foreach my $id (sort { $a <=> $b } keys %files) {
	my $start = $files{$id}[0];
	my $end = $start + $files{$id}[1] - 1;

	print "$id $start $end\n" if ($debug);

	foreach my $i ($start..$end) {
		$total += $id * $i;
	}
}

# Print solution
print "Solution: $total\n";
