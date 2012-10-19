package Hok::Spec;
use strict;
use warnings;
use utf8;
use parent qw/Exporter/;
use Hok::Should;

our @EXPORT = qw/expect describe/;

sub describe {
    my ($name, $code) = @_;
    $code->();
}

sub expect {
    my $stuff = shift;
    Hok::Should->new($stuff);
}


1;
