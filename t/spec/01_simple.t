use strict;
use warnings;
use utf8;
use Test::More ();
use Hok::Reporter::Test;
use Hok;
use Data::Dumper;

my $hok = Hok->bootstrap(
    reporter => Hok::Reporter::Test->new(),
);
{
    package sandbox;
    use Hok::Spec;
    describe("Simple", sub {
        expect(5963)->equals(5963);
        expect(4649)->equals(5963);
        expect(4649)->to_be(4649);
        expect(4649)->is(4649);
    });
    runtests;
}
Test::More::is_deeply(
    $hok->reporter->result,
    [
        [
            {
                'message' => undef,
                'result'  => 1
            },
            {
                'message' => undef,
                'result'  => 0
            },
            {
                'message' => undef,
                'result'  => 1
            },
            {
                'message' => undef,
                'result'  => 1
            },
        ],
    ]
) or Test::More::note Dumper($hok->reporter->result);

Test::More::done_testing;

