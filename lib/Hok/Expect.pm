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
    my $expect = shift;

    Hok->context->is($self->[0], $expect);
}

1;

