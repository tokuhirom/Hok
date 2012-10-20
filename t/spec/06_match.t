use strict;
use warnings;
use utf8;
use Test::More;
use t::Util;

{
    package sandbox;
    use Hok::Spec;
    describe("Simple", sub {
        expect('1.1.2')->to->match(qr/^[0-9]+\.[0-9]+\.[0-9]+$/);
        expect('hoge11.2')->to->match(qr/^[0-9]+\.[0-9]+\.[0-9]+$/);
        expect('1.1.2')->to->not->match(qr/^[0-9]+\.[0-9]+\.[0-9]+$/);
        expect('hoge11.2')->to->not->match(qr/^[0-9]+\.[0-9]+\.[0-9]+$/);
        expect('1.1.2')->not_match(qr/^[0-9]+\.[0-9]+\.[0-9]+$/);
        expect('hoge11.2')->not_match(qr/^[0-9]+\.[0-9]+\.[0-9]+$/);
    });
    runtests;
}
is_deeply(
    result(),
    make_results(qw/
        1 0
        0 1
        0 1
        /),
) or report();

done_testing;

