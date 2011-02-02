#!/usr/bin/perl -w

# Scale calculator
# varsion 0.1 alpha 3

use strict;
use warnings;

use Pod::Usage;
use Getopt::Std;

my %options;
getopt 'or', \%options;

pod2usage() unless (exists $options{'o'} && $options{'o'}) && $options{'o'} =~ /\d{2,5}[:x]\d{2,5}/;

my ($w0, $h0) = exists $options{'r'} && $options{'r'} ? split /[:x]/, $options{'r'} : (480, 272);
my ($w1, $h1) = split /[:x]/, $options{'o'};

pod2usage("Wrong values combination, sorry.") if $w0 > $w1 && $h0 > $h1; 

# w1 / h1 = (w0 - x) / (h0 - y)
# 
# equation :
# a * x + b * y = c
# x, y = ?

# coefficients for the equation
my ($a, $b, $c) = (-$h1, $w1, $h0 * $w1 - $w0 * $h1);
my ($x, $y) = (0, 0);
my ($x1, $y1) = (-1, -1);

unless ($w0 == $w1 && $h0 == $h1) {
    # minimum even integer roots
    ($x, $y) = (-0.5, -1);
    until ($y > $h0) {
        $x = abs( ($c - $b * ++$y) / $a );
        last if ($x1 > 0 && $y1 > 0 && $x1 < $x && $y1 < $y);
        ($x1, $y1) = ($x, $y) if ((int $x == $x && !($x & 1)) && (($y > 0 && !($y & 1)) || $y == 0));
        last if (($x1 == 0 && $y1 > 0 && !($y1 & 1)) || ($y1 == 0 && int $x1 == $x1 && !($x1 & 1))); 
    }
}

pod2usage('Sorry, we can\'t calculate correct value') if (int $x1 != $x1 || $x1 < 0 || $y1 < 0);

print 'scale: ' . ($w0 - $x1) . ':' . ($h0 - $y1) . "\n";
print 'top and bottom fields: ' . ($y1 / 2) . "\n" if ($y1 > 0);
print 'left and right fields: ' . ($x1 / 2) . "\n" if ($x1 > 0);

################################################################################
__END__

=head1 NAME

scale calculator - Calculate scale anf fields for ffmpeg

=head1 SYNOPSIS

scale_calculator.pl [options]

    Options:
        -o DDDD:DDDD          original frame size
        -o DDDDxDDDD

        -r DDDD:DDDD          result frame size (optional, defalut 480:272)
        -r DDDDxDDDD

