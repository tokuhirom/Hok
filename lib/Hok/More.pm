package Hok::More;
use strict;
use warnings;
use utf8;

use Test::Builder;

use parent qw/Exporter/;

our @EXPORT = qw/subtest ok done_testing/;

sub subtest {
    my $self = shift;
}

sub ok {
    my ($stuff, $reason) = @_;
}

sub done_testing {
}

1;

