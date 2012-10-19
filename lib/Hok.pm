package Hok;
use strict;
use warnings;
use 5.010001;
our $VERSION = '0.01';

# plagger-ish context
our $CONTEXT;
sub context { $CONTEXT }
$CONTEXT = Hok->new();

sub new {
    my $class = shift;
    my %args = @_==1 ? %{$_[0]} : @_;

    my $self = bless {
        %args,
    }, $class;

    # setup reporter
    $self->{reporter} ||= do {
        if ($ENV{HARNESS_ACTIVE}) { # in prove
            require Hok::Reporter::TAP;
            Hok::Reporter::TAP->new;
        } else {
            require Hok::Reporter::Dot;
            Hok::Reporter::Dot->new;
        }
    };

    return $self;
}

sub reporter { shift->{reporter} }

1;
__END__

=encoding utf8

=head1 NAME

Hok - A module for you

=head1 SYNOPSIS

  use Hok;

=head1 DESCRIPTION

Hok is

=head1 AUTHOR

Tokuhiro Matsuno E<lt>tokuhirom AAJKLFJEF@ GMAIL COME<gt>

=head1 SEE ALSO

=head1 LICENSE

Copyright (C) Tokuhiro Matsuno

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
