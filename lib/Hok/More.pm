package Hok::More;
use strict;
use warnings;
use utf8;

use Test::Builder;
use Hok;

use parent qw/Exporter/;

our @EXPORT = qw/subtest ok done_testing/;

sub subtest {
    my ($name, $code) = @_;
    Hok->context->run_subtest($name, $code);
}

sub ok {
    my ($stuff, $reason) = @_;
    Hok->context->reporter->ok($stuff, $reason);
}

1;
