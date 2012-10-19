package Hok::Expect;
use strict;
use warnings;
use utf8;

use Hok;

sub new {
    my $class = shift;
    bless [@_], $class;
}

sub equal {
    my $self = shift;
    my $expect = shift;

    Hok->context->is($self->[0], $expect);
}

# expect(1).to.be.ok();
# expect(true).to.be.ok();
# expect({}).to.be.ok();
# expect(0).to.not.be.ok();
sub ok {
    my $self = shift;
    Hok->context->ok($self->[0]);
}

sub not_ok {
    my $self = shift;
    Hok->context->ok(!$self->[0]);
}

sub to {
    my $self = shift;
    $self;
}

sub be {
    my $self = shift;
    if (@_) {
        $self->equal(@_);
    } else {
        $self;
    }
}

sub have {
    my $self = shift;
    $self;
}

sub not {
    my $self = shift;
    return Hok::Expect::Not->new($self->[0]);
}

sub length :method {
    my ($self, $len) = @_;
    Hok->context->is(CORE::length($self->[0]), $len);
}

# expect(5).to.be.a('number');
# expect(5).is_a('number');
sub a {
    my ($self, $type) = @_;
    Hok->context->isa_ok($self->[0], $type);
}
*is_a = *a;
*an = *a;

sub match {
    my ($self, $regexp) = @_;
    Hok->context->like($self->[0], $regexp);
}

package # hide from pause
    Hok::Expect::Not;

sub new {
    my $class = shift;
    bless [@_], $class;
}

sub be {
    my $self = shift;
    if (@_) {
        $self->equal(@_);
    } else {
        $self;
    }
}

sub have {
    my $self = shift;
    $self;
}

sub to {
    my $self = shift;
    $self;
}

sub ok {
    my $self = shift;
    Hok->context->ok(!$self->[0]);
}

sub equal {
    my $self = shift;
    my $expect = shift;

    Hok->context->isnt($self->[0], $expect);
}

1;

__END__

=head1 SEE ALSO

L<https://github.com/LearnBoost/expect.js>

