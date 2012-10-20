use strict;
use warnings;
use utf8;
use Test::More;
use t::Util;

{
    package sandbox;
    use Hok::Spec;
    describe("Simple", sub {
        expect({ a => 'b' })->to->have->key('a');
        expect({ a => 'b', c => 'd' })->to->only->have->keys('a', 'c');
        expect({ a => 'b', c => 'd' })->to->not->only->have->key('a');
    });
    runtests;
}
test_results(qw/
    1
    1
    0
/);

done_testing;

