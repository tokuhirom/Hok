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
    my $STATE;
    describe("Simple", sub {
        before {
            $STATE .= "A";
        };
        before_each {
            $STATE .= "B";
        };
        describe 'hoge' => sub {
            Test::More::is('AB', $STATE);
        };
        describe 'hoge' => sub {
            Test::More::is('ABB', $STATE);
        };
    });
    runtests;
}

Test::More::done_testing;

