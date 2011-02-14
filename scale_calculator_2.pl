#!/usr/bin/perl -w

# Scale calculator
# varsion 1.0 alpha 1

use strict;
use warnings;

use Pod::Usage;
use Getopt::Std;

my %options;
getopt 'or', \%options;

pod2usage() unless exists $options{'o'} && $options{'o'} && $options{'o'} =~ /\d{2,5}[:x]\d{2,5}/;

my ($w0, $h0) = exists $options{'r'} && $options{'r'} ? split /[:x]/, $options{'r'} : (480, 272);
my ($w1, $h1) = split /[:x]/, $options{'o'};
my ($w2, $h2);

pod2usage("Wrong values combination, sorry.") if $w0 gt $w1 && $h0 gt $h1; 

my ($d0, $d1) = ($w0 / $h0, $w1 / $h1);

($w2, $h2) = ($w0, $h0) if ($d0 eq $d1);
($w2, $h2) = (int($w1 * $h0 / $h1 + 0.99), $h0) if ($d0 gt $d1);
($w2, $h2) = ($w0, int($w0 * $h1 / $w1 + 0.99)) if ($d0 lt $d1);

$w2++ if $w2 % 2;
$h2++ if $h2 % 2;

print 'scale: ' . ($w2) . ':' . ($h2) . "\n";
print 'top and bottom fields: ' . (($w0 - $w2) / 2) . "\n" if ($w2 ne $w0);
print 'left and right fields: ' . (($h0 - $h2) / 2) . "\n" if ($h2 ne $h0);

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

