use strict;
use warnings;
use utf8;
use Hok::Spec;

describe 'hoge' => sub {
    describe 'fuga' => sub {
        expect('hoge')->equal('hoge');
        expect('hige')->equal('hige');
        expect('hoge')->to_be('hoge');
    };
};

