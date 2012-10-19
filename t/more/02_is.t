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
    is 1, 0;
    is 1, 1;
    is 'hoge', 'hoge';
    is 'hige', 'hoge';
    is undef, 'hoge';
    is 'hoge', undef;
    is undef, undef;
    done_testing;
}
Test::More::is_deeply(
    $hok->reporter->result,
    [
        [
            map {
                +{
                    'message' => undef,
                    'result'  => $_
                }
            } qw/ 0 1 1 0 0 0 1/
        ]
    ]
) or Test::More::note(Dumper($hok->reporter->result));

Test::More::done_testing;

