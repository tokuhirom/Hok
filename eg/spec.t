use strict;
use warnings;
use utf8;
use Hok::Spec;

{
    package MessageFilter;
    sub new {
        my ($class, $word) = @_;
        bless \$word, $class;
    }
    sub detect {
        my ($self, $str) = @_;
        return index($str, $$self) >= 0;
    }
}

describe 'MessageFilter' => sub {
    my $filter;
    before_each {
        $filter = MessageFilter->new('foo');
    };

    it 'should detect message with NG word' => sub {
        expect($filter->detect('hello from foo'))->ok;
    };
    it 'should not detect message without NG word' => sub {
        expect($filter->detect('hello world!'))->not_ok;
    };
};

