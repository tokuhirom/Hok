package Hok;
use strict;
use warnings;
use 5.010001;
our $VERSION = '0.01';

use Module::Load ();
use Carp ();

our @CARP_NOT = qw(Hok::Spec Hok::More Hok::Expect);

# plagger-ish context
our $CONTEXT;
sub context { $CONTEXT ||= Hok->new() }

sub new {
    my $class = shift;
    my %args = @_==1 ? %{$_[0]} : @_;

    my $self = bless {
        blocks => [],
        %args,
    }, $class;

    # setup reporter
    $self->{reporter} ||= do {
        if ($ENV{HARNESS_ACTIVE}) { # in prove
            require Hok::Reporter::TAP;
            Hok::Reporter::TAP->new;
        } else {
            my $reporter = $ENV{HOK_REPORTER} || 'Dot';
               $reporter = $reporter =~ s/^\+// ? $reporter : "Hok::Reporter::$reporter";
            Module::Load::load($reporter);
            $reporter->new();
        }
    };

    return $self;
}

sub bootstrap {
    my $class = shift;
    my $self = $class->new(@_);
    $CONTEXT = $self;
    $self;
}

sub reporter { shift->{reporter} }

sub run_subtest {
    my ($self, $name, $code) = @_;
    local $self->{blocks} = [@{$self->{blocks}}];
    $self->reporter->before_subtest($name);
    push @{$self->{blocks}}, $name;
    $code->();
    $self->reporter->after_subtest($name);
}

sub depth {
    my $self = shift;
    0+@{$self->{blocks}};
}

sub ok {
    my $self = shift;
    $self->reporter->ok(@_);
}

sub is {
    my ($self, $got, $expect, $msg) = @_;

    # see Test::Builder::is_eq
    if (!defined $got || !defined $expect) {
        # undef only matches undef and nothing else
        my $test = !defined $got && !defined $expect;

        Hok->context->reporter->ok($test, $msg);
    # TODO: diag it
        return $test;
    } else {
        my $test = $got eq $expect;
        Hok->context->reporter->ok($test, $msg);
    # TODO: diag it
        return $test;
    }
}

sub like {
    my ($self, $got, $expect, $msg) = @_;
    my $test = $got =~ $expect;
    Hok->context->reporter->ok($test, $msg);
    # TODO: diag it
    return $test;
}

sub unlike {
    my ($self, $got, $expect, $msg) = @_;
    my $test = $got !~ $expect;
    Hok->context->reporter->ok($test, $msg);
    # TODO: diag it
    return $test;
}

sub diag {
    my $self = shift;
    $self->reporter->diag(@_);
}

sub note {
    my $self = shift;
    $self->reporter->note(@_);
}

sub isa_ok {
    my ($self, $obj, $type) = @_;
    my $test = UNIVERSAL::isa($obj, $type);
    $self->reporter->ok($test, "$obj is-a $type");
    return $test;
}

sub cmp_ok {
    my ($self, $a, $op, $b, $msg) = @_;

    my $code = +{
        '<'  => sub { $a < $b },
        '>'  => sub { $a > $b },
        '>'  => sub { $a > $b },
        '==' => sub { $a == $b },
    }->{$op} || do {
        ## no critic
        local $@;
        my $c = eval "sub { \$a $op \$b }";
        Carp::croak $@ if $@;
        $c;
    };
    my $test = $code->();

    $self->reporter->ok($test, $msg);
    # TODO: diag it
    return $test;
}

sub done_testing {
    my $self = shift;
    $self->reporter->finalize();
}

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
