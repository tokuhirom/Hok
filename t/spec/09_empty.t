use strict;
use warnings;
use utf8;
use Test::More;
use t::Util;

{
    package sandbox;
    use Hok::Spec;
    describe("Simple", sub {
        expect([])->to->be->empty();
        expect([])->to->not->be->empty();
        expect({})->to->be->empty();
        expect({})->to->not->be->empty();
        expect({ length => 0, duck => 'typing' })->to->be->empty();
        expect({ my => 'object' })->to->not->be->empty();
        expect([1,2,3])->to->not->be->empty();
        expect([1,2,3])->to->be->empty();
    });
    runtests;
}
test_results(qw/
    1 0
    1 0
    0 1
    1 0
/);

done_testing;

