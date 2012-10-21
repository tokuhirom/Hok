package Hok::More;
use strict;
use warnings;
use utf8;

use Test::Builder;
use Hok;
use Class::Load ();
use Try::Tiny;

use parent qw/Exporter/;

our @EXPORT = qw/subtest ok done_testing p is use_ok like unlike cmp_ok note diag/;

# TODO:
# difflet

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
    try {
        Hok->context->run_subtest($name, $code);
    } catch {
        Hok->context->fail("Exception caused: $_");
    };
}

sub use_ok {
    for my $klass (@_) {
        my ($ok, $err) = Class::Load::try_load_class($klass);
        Hok->context->ok($ok, "use $klass");
        Hok->context->diag($err) if $err;
    }
}

sub diag { Hok->context->diag(@_) }
sub note { Hok->context->note(@_) }

sub ok {
    my ($stuff, $reason) = @_;
    Hok->context->ok($stuff, $reason);
}

sub is($$;$) {
    my ($got, $expect, $name) = @_;
    Hok->context->is($got, $expect, $name);
}

sub like($$;$) {
    my ($got, $expect, $name) = @_;
    Hok->context->like($got, $expect, $name);
}

sub unlike($$;$) {
    my ($got, $expect, $name) = @_;
    Hok->context->unlike($got, $expect, $name);
}

sub cmp_ok($$$;$) {
    my ($a, $op, $b, $msg) = @_;
    Hok->context->cmp_ok($a, $op, $b, $msg);
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

=head1 DESCRIPTION

L<Test::More>-ish interface from Hok.

