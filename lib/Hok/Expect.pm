package Hok::Expect;
use strict;
use warnings;
use utf8;

use Hok;

sub new {
    my $class = shift;
    bless [@_], $class;
}

sub equal {
    my $self = shift;
    my $got = $self->[0];
    my $expect = shift;
    my $msg;

    # see Test::Builder::is_eq
    if (!defined $got || !defined $expect) {
        # undef only matches undef and nothing else
        my $test = !defined $got && !defined $expect;

        Hok->context->reporter->ok($test, $msg);
        return $test;
    } else {
        my $test = $got eq $expect;
        Hok->context->reporter->ok($test, $msg);
        return $test;
    }
}

1;

