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
    } else {
        # not ok.
        $self->print(colored(['red'], "."));
    }
}

# final report.
sub finalize {
    my $self = shift;
    return if $self->{finished}++;

    $self->print("\n\n");
    if ($self->context->fail_count) {
        $self->print(
            colored(
                ['red bold'],
                sprintf( "  \x{2716} %s fails\n", $self->context->fail_count )
            )
        );
    }
    $self->print(
        colored(
            ['green bold'],
            sprintf( "  \x{2713} %s tests completed",
                $self->context->success_count )
        )
    );
    $self->print("\n\n");
}

1;
