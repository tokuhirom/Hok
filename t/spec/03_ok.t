use strict;
use warnings;
use utf8;
use Test::More;
use t::Util;

{
    package sandbox;
    use Hok::Spec;
    describe("Simple", sub {
        expect(1)->ok();
        expect({})->ok();
        expect(0)->ok();

        expect(0)->to->not->be->ok();
        expect(0)->not_ok();
        expect(1)->not_ok();
    });
    runtests;
}
is_deeply(
    result(),
    make_results(qw/
        1 1 0
        1 1 0
        /),
) or report();

done_testing;

