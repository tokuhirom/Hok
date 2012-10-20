use strict;
use warnings;
use utf8;
use Test::More;
use t::Util;

{
    package sandbox;
    use Hok::Spec;
    describe("Simple", sub {
        # no arg
        expect(sub { die })->to->throw_exception;
        expect(sub { 1 })->to->throw_exception;
        # code arg
        expect(sub { die bless [], 'Foo' })->to->throw_exception(sub {
            expect($_)->to_be_a('Foo');
        });
        expect(sub { die bless [], 'Foo' })->to->throw_exception(sub {
            expect($_)->to_be_a('Bar');
        });
        # regexp arg
        expect(sub { die })->to->throw_exception(qr/hoge/);
        expect(sub { die 'hoge' })->to->throw_exception(qr/hoge/);

        # NOT ---------------------------------
        # no arg
        expect(sub { die })->to->not->throw_exception;
        expect(sub { 1 })->to->not->throw_exception;
    });
    runtests;
}
test_results(qw/
    1 0
    1 0
    0 1

    0 1
/);

done_testing;

