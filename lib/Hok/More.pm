package Hok::More;
use strict;
use warnings;
use utf8;

use Test::Builder;
use Hok;

use parent qw/Exporter/;

our @EXPORT = qw/subtest ok done_testing p/;

# TODO:
# use_ok
# difflet
# is
# note

# Test::More functions:
#   ok use_ok require_ok
#   is isnt like unlike is_deeply
#   cmp_ok
#   skip todo todo_skip
#   pass fail
#   eq_array eq_hash eq_set
#   $TODO
#   plan
#   done_testing
#   can_ok isa_ok new_ok
#   diag note explain
#   subtest
#   BAIL_OUT
#
# Test::Exceptions functions:
#    dies_ok lives_ok throws_ok lives_and

sub subtest {
    my ($name, $code) = @_;
    Hok->context->run_subtest($name, $code);
}

sub ok {
    my ($stuff, $reason) = @_;
    Hok->context->reporter->ok($stuff, $reason);
}

sub done_testing() {
    Hok->context->done_testing;
}

sub p($) {
    goto &Hok::Util::p;
}

1;
__END__

=head1 NAME

Hok::More - hok for Test::More lovers

