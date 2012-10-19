package Hok::Reporter::TAP;
use strict;
use warnings;
use utf8;
use parent qw/Class::Accessor::Fast/;

__PACKAGE__->mk_accessors(qw/outfh errfh/);

sub new {
    my $class = shift;
    my %args = @_==1 ? %{$_[0]} : @_;
    my $self = bless {
        outfh => *STDOUT,
        errfh => *STDOUT,
        tests => 0,
        %args
    }, $class;

    binmode $self->{outfh}, ':utf8';
    binmode $self->{errfh}, ':utf8';

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

sub ok {
    my ($self, $ok, $msg) = @_;

    my $cnt = ++$self->{tests};
    my $out  = $ok ? "ok" : "not ok";
       $out .= " " . $cnt;
       $out .= $msg ? " - $msg" : '';
       $out .= "\n";
    $self->print($out);

    if ($ok) {
        $self->{success}++;
    } else {
        $self->{fail}++;
    }
}

sub DESTROY {
    my $self = shift;
    $self->finalize();
}

# final report.
sub finalize {
    my $self = shift;
    return if $self->{finished}++;

    $self->print("1..$self->{tests}\n");
    if ($self->{fail}) {
        $self->diag("");
        $self->diag("   Succeed: $self->{success}");
        $self->diag("   Failed:  $self->{fail}");
    }
}

1;
