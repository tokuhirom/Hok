use strict;
use warnings;
use utf8;
use Test::More;
use t::Util;

{
    package sandbox;
    use Hok::Spec;
    describe("Simple", sub {
        expect([])->to->be->an('ARRAY');
        expect([])->to->be->a('ARRAY');
        expect([])->is_a('ARRAY');
        expect([])->is_a('HASH');

        expect(bless [], 'Foo')->to->be->an('Foo');
        expect(bless [], 'Foo')->to->be->an('Bar');
    });
    runtests;
}
is(result()->[0]->[0]->{result}, 1);
is(result()->[0]->[1]->{result}, 1);
is(result()->[0]->[2]->{result}, 1);
is(result()->[0]->[3]->{result}, 0);
is(result()->[0]->[4]->{result}, 1);
is(result()->[0]->[5]->{result}, 0);

done_testing;

