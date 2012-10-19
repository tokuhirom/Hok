package Hok::Reporter::Dot;
use strict;
use warnings;
use utf8;
use Term::ANSIColor;

use parent qw/Hok::Reporter::Base/;

sub init {
    my $self = shift;
    $self->print("\n");
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
