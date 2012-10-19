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
    use_ok 'Hok';
    use_ok 'Unknown::Module::Name';
    done_testing;
}
Test::More::is_deeply(
    $hok->reporter->result->[0]->[0],
    {
        'message' => 'use Hok',
        'result'  => 1,
    },
);
Test::More::is_deeply(
    $hok->reporter->result->[0]->[1],
    {
        'message' => 'use Unknown::Module::Name',
        'result'  => 0
    },
);
Test::More::ok($hok->reporter->result->[0]->[2]->{diag});

Test::More::done_testing;

