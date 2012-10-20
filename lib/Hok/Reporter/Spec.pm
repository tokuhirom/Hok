package Hok::Reporter::Spec;
use strict;
use warnings;
use utf8;

use Term::ANSIColor;
use parent qw/Hok::Reporter::Base/;
use Hok::Util;

sub init {
    my $self = shift;
    $self->print("\n");
}

# failures highlight in red
# pending in blue
sub ok {
    my ($self, $ok, $msg) = @_;
    $msg ||= Hok::Util::test_line() || 'Unknown';

    my $depth = Hok->context->depth + 1;

    $self->print("  " x $depth);

    if ($ok) {
        $self->print(colored(['green'], "\x{2713} "));
    } else {
        # not ok.
        $self->print(colored(['red'], "\x{2716} "));
    }
    $self->print(colored(["BRIGHT_BLACK"], $msg));
    $self->print("\n");
}

sub before_subtest {
    my ($self, $name) = @_;
    my $depth = Hok->context->depth + 1;
    $self->print("\n" . ("  " x $depth) . $name . "\n\n");
}

sub after_subtest {
    my ($self, $name) = @_;
    $self->print("\n\n");
}

# final report.
sub finalize {
    my $self = shift;
    return if $self->{finished}++;

    $self->print("\n\n");
    if ($self->context->fail_count) {
        $self->print(colored(['red bold'], sprintf("  \x{2716} %s fails\n", $self->context->fail_count)));
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

