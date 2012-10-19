use strict;
use warnings;
use utf8;
use Hok::Spec;

describe 'hoge' => sub {
    expect('hoge')->equal('hoge');
    expect('hige')->equal('hige');
};
expect('hige')->equal('hage');

