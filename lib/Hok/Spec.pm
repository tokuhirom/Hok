package Hok::Spec;
use strict;
use warnings;
use utf8;
use parent qw/Exporter/;
use Hok;
use Hok::Expect;
use Carp ();

our @EXPORT = qw/expect describe runtests/;
our $EXECUTING;

my @blocks;

sub describe {
    my ($name, $code) = @_;
    if ($EXECUTING) {
        Hok->context->run_subtest($name, $code);
    } else {
        push @blocks, [$name, $code];
    }
}

sub expect {
    my $stuff = shift;
    Carp::croak "Do not call 'expect' function in out of describe" unless $EXECUTING;
    Hok::Expect->new($stuff);
}

sub runtests {
    local $EXECUTING = 1;
    while (my $block = shift @blocks) {
        my ($name, $code) = @$block;
        Hok->context->run_subtest($name, $code);
    }
    Hok->context->done_testing;
}

END {
    if (@blocks) {
        runtests();
    }
}

1;

