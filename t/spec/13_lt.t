use strict;
use warnings;
use utf8;
use Test::More;
use t::Util;

{
    package sandbox;
    use Hok::Spec;
    describe("Simple", sub {
        expect(4)->to_be_less_than(1);
        expect(4)->to_be_less_than(4);
        expect(4)->to_be_less_than(5);
    });
    runtests;
}
test_results(qw/
    0 0 1
/);

done_testing;

