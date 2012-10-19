use strict;
use warnings;
use utf8;
use Test::More ();
use Hok::Reporter::Test;
use Hok;

my $hok = Hok->bootstrap(
    reporter => Hok::Reporter::Test->new(),
);
{
    package sandbox;
    use Hok::More;
    ok 1, "Good";
    ok 0, "Bad";
    done_testing;
}
Test::More::is_deeply(
    $hok->reporter->result,
    [
        [
            {
                'message' => 'Good',
                'result'  => 1
            },
            {
                'message' => 'Bad',
                'result'  => 0
            }
        ]
    ]
);

Test::More::done_testing;

