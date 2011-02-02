#!/usr/bin/perl -w

use strict;
use warnings;

my ($w0, $h0) = (480, 272);

my ($w1, $h1) = (320, 136);

my $a = -$h1;
my $b = $w1;
my $c = ($h0 * $w1 - $w0 * $h1);

my ($x, $y) = (-0.5, -1);
$x = ($c - $b * ++$y) / $a until ($y > abs(($c - $a) / $b) || ((int $x == $x && !($x & 1)) && ($y > 0 && !($y & 1))));

print 'scale: ' . ($w0 - $x) . ':' . ($h0 - $y) . "\n";
print 'top and bottom fields: ' . ($y / 2) . "\n" if ($y > 0);
print 'left and right fields: ' . ($x / 2) . "\n" if ($x > 0);

