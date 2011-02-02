#!/usr/bin/perl -w

# Scale calculator
# varsion 0.1 alpha 2

use strict;
use warnings;

use Pod::Usage;
use Getopt::Std;

my %options;
getopt 'or', \%options;

pod2usage() unless (exists $options{'o'} && $options{'o'}) && $options{'o'} =~ /\d{2,5}:\d{2,5}/;

my ($w0, $h0) = exists $options{'r'} && $options{'r'} ? split /:/, $options{'r'} : (480, 272);
my ($w1, $h1) = split /:/, $options{'o'};

pod2usage("Wrong values combination, sorry.") if $w0 > $w1 && $h0 > $h1; 

# w1 / h1 = (w0 - x) / (h0 - y)
# 
# equation :
# a * x + b * y = c
# x, y = ?

# coefficients for the equation
my $a = -$h1;
my $b = $w1;
my $c = ($h0 * $w1 - $w0 * $h1);

my ($x, $y) = (0, 0);

unless ($w0 == $w1 && $h0 == $h1) {
    # minimum even integer roots
    ($x, $y) = (-0.5, -1);
    $x = ($c - $b * ++$y) / $a until
        ($y > abs(($c - $a) / $b) || ((int $x == $x && !($x & 1)) && ($y > 0 && !($y & 1))));
}

print 'scale: ' . ($w0 - $x) . ':' . ($h0 - $y) . "\n";
print 'top and bottom fields: ' . ($y / 2) . "\n" if ($y > 0);
print 'left and right fields: ' . ($x / 2) . "\n" if ($x > 0);

################################################################################
__END__

=head1 NAME

scale calculator - Calculate scale anf fields for ffmpeg

=head1 SYNOPSIS

scale_calculator.pl [options]

    Options:
        -o XXXX:XXXX          original frame size
        -r XXXX:XXXX          result frame size (optional, defalur 480:272)

