package t::Util;
use strict;
use warnings;
use utf8;
use parent qw/Exporter/;

use Hok::Reporter::Test;
use Hok;
use Test::More;
use Data::Dumper;

our @EXPORT = qw/result report make_results test_results/;

Hok->bootstrap(
    reporter => Hok::Reporter::Test->new(),
);

sub result() {
    Hok->context->reporter->result;
}

sub report {
    note(Dumper(result()));
}

sub make_results {
    [
        [
            map {
                +{
                    'message' => undef,
                    'result'  => $_
                }
            } @_
        ]
    ]
}

sub test_results {
    is_deeply(
        result(),
        make_results(@_),
    ) or report();
}

1;

