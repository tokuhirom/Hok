package Hok::Reporter::Dot;
use strict;
use warnings;
use utf8;
use Term::ANSIColor;
use parent qw/Class::Accessor::Fast/;

__PACKAGE__->mk_accessors(qw/outfh/);

sub new {
    my $class = shift;
    my %args = @_==1 ? %{$_[0]} : @_;
    my $self = bless {
        outfh => *STDOUT,
        errfh => *STDERR,
        %args
    }, $class;

    binmode $self->{outfh}, ':utf8';
    binmode $self->{errfh}, ':utf8';

    $self->print("\n");

    return $self;
}

sub print {
    my $self = shift;
    CORE::print {$self->{outfh}} @_;
}

# failures highlight in red
# pending in blue
sub ok {
    my ($self, $ok, $msg) = @_;
    if ($ok) {
        $self->print(colored(['CYAN'], "."));
        $self->{success}++;
    } else {
        # not ok.
        $self->print(colored(['red'], "."));
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

    $self->print("\n\n");
    if ($self->{fail}) {
        $self->print(colored(['red bold'], "  \x{2716} $self->{fail} fails\n"));
    }
    $self->print(colored(['green bold'], "  \x{2713} $self->{success} tests completed"));
    $self->print("\n\n");
}

1;
