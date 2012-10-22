use strict;
use warnings;
use utf8;
use Hok::Spec;

describe 'hoge' => sub {
    describe 'fuga' => sub {
        expect('hoge')->is('hoge');
        expect('hige')->is('hige');
    };
};

