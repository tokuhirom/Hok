use strict;
use warnings;
use utf8;
use Test::More;
use t::Util;

{
    package sandbox;
    use Hok::Spec;
    describe("Simple", sub {
        expect([])->to->have->length(0);
        expect([])->to->have->length(1);
        expect([1,2,3])->to->have->length(3);
        expect([1,2,3])->to->have->length(4);
    });
    runtests;
}
test_results(qw/
    1 0
    1 0
/);

done_testing;

