package Hok::Reporter::TAP;
use strict;
use warnings;
use utf8;
use parent qw/Hok::Reporter::Base/;
use Hok::Util;

sub ok {
    my ($self, $ok, $msg) = @_;
    $msg ||= Hok::Util::test_line() || '';

    my $cnt = ++$self->{tests};
    my $out  = $ok ? "ok" : "not ok";
       $out .= " " . $cnt;
       $out .= $msg ? " - $msg" : '';
       $out .= "\n";
    $self->print($out);
}

# final report.
sub finalize {
    my $self = shift;
    return if $self->{finished}++;

    $self->print("1..$self->{tests}\n");
    if ($self->context->fail_count) {
        $self->diag("");
        $self->diag(sprintf("   Succeed: %d", $self->context->success_count));
        $self->diag(sprintf("   Failed:  %d", $self->context->fail_count));
    }
}

1;
