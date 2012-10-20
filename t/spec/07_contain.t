use strict;
use warnings;
use utf8;
use Test::More;
use t::Util;

{
    package sandbox;
    use Hok::Spec;
    describe("Simple", sub {
        expect([1, 2])->to->contain(1);
        expect([1, 2])->to->contain(0);
        expect('hello world')->to->contain('world');
        expect('hello world')->to->contain('kan');
    });
    runtests;
}
test_results(qw/
    1 0
    1 0
/);

done_testing;

