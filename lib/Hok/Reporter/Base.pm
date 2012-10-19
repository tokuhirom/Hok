package Hok::Reporter::Base;
use strict;
use warnings;
use utf8;

use Class::Accessor::Lite (
    rw => [qw/outfh errfh/],
);

sub new {
    my $class = shift;
    my %args = @_==1 ? %{$_[0]} : @_;
    my $self = bless {
        outfh => *STDOUT,
        errfh => *STDERR,
        outfh_mode => ':utf8',
        errfh_mode => ':utf8',
        %args
    }, $class;

    $self->init();

    binmode $self->{outfh}, $self->{outfh_mode};
    binmode $self->{errfh}, $self->{errfh_mode};

    return $self;
}

sub print :method {
    my $self = shift;
    CORE::print {$self->{outfh}} @_;
}

sub diag :method {
    my $self = shift;
    CORE::print {$self->{errfh}} "# " . $_[0] . "\n";
}

sub init { } # implement in child class
sub before_subtest { } # implement in child class
sub after_subtest { } # implement in child class

sub DESTROY {
    my $self = shift;
    $self->finalize();
}

1;

