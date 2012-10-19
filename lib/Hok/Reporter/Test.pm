package Hok::Reporter::Test;
use strict;
use warnings;
use utf8;

use parent qw/Hok::Reporter::Base/;

sub init {
    my $self = shift;
    @{$self->{stack}} = ([]);
}

sub ok {
    my ($self, $ok, $msg) = @_;
    push @{$self->{stack}->[-1]}, +{
        result => $ok ? 1 : 0,
        message => $msg,
    };
}

sub before_subtest {
    my ($self, $name) = @_;
    push @{$self->{stack}}, [];
}

sub after_subtest {
    my $self = shift;
    push @{$self->{result}}, pop @{$self->{stack}};
}

sub finalize {
    my $self = shift;
    push @{$self->{result}}, pop @{$self->{stack}};
}

sub diag :method {
    my $self = shift;
    push @{$self->{stack}->[-1]}, +{
        diag => $_[0],
    };
}

sub result {
    my $self = shift;
    $self->{result};
}

1;
__END__

=head1 NAME

Hok::Reporter::Test - Test hok itself

=head1 DESCRIPTION

    [
        ['hoge',
            ['fuga',
                ['L8'],
                ['L9']
            ]
        ]
    ]

