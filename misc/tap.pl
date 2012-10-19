#!/usr/bin/env perl
use strict;
use warnings;
use utf8;
use 5.010000;
use autodie;

use Test::More 0.96;

subtest 'hoge' => sub {
    subtest 'fuga' => sub {
        is 1, 3;
    };
    is 2, 3;
};

is 3,4;

done_testing;
