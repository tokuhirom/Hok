use strict;
use warnings;
use utf8;
use Test::More ();
use Hok::More;
use Hok::Reporter::Test;

my $reporter = Hok::Reporter::Test->new();
my $hok = Hok->bootstrap(
    reporter => $reporter,
);
$hok->ok("YAY", "OK");
$hok->done_testing;

Test::More::is_deeply(
    $hok->reporter->result,
    [
        [
            {
                'message' => 'OK',
                'result'  => 1
            }
        ]
    ]
);

Test::More::done_testing;

