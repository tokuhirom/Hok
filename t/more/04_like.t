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
    use Hok::More;
    like 'hoge', qr/h.ge/;
    like 'poge', qr/h.ge/;
    unlike 'hige', qr/h.ge/;
    unlike 'pige', qr/h.ge/;
    done_testing;
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
                'result'  => 0
            },
            {
                'message' => undef,
                'result'  => 1
            },
        ]
    ]
) or Test::More::note(Dumper($hok->reporter->result));

Test::More::done_testing;

