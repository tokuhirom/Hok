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

sub note :method {
    my $self = shift;
    $self->_print_comment($self->outfh, @_);
}

sub diag :method {
    my $self = shift;
    $self->_print_comment($self->errfh, @_);
}

# ref. Test::Builder::_print_comment
sub _print_comment {
    my ($self, $fh, @msgs) = @_;
    return unless @msgs;

    # Prevent printing headers when compiling (i.e. -c)
    return if $^C;

    # Smash args together like print does.
    # Convert undef to 'undef' so its readable.
    my $msg = join '', map { defined($_) ? $_ : 'undef' } @msgs;

    # Escape the beginning, _print will take care of the rest.
    $msg =~ s/^/# /;

    CORE::print {$fh} $msg . "\n";
}

sub init { } # implement in child class
sub before_subtest { } # implement in child class
sub after_subtest { } # implement in child class

sub DESTROY {
    my $self = shift;
    $self->finalize();
}

sub context { Hok->context }

1;

