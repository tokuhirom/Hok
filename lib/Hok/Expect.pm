package Hok::Expect;
use strict;
use warnings;
use utf8;

use Hok;
use Carp ();
use Try::Tiny;

use constant {
    ONLY => 1,
};

sub new {
    my $class = shift;
    @_==1 or Carp::croak("Too much args");
    bless [$_[0]], $class;
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

sub fail {
    Hok->context->fail();
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

sub not: method {
    my $self = shift;
    return Hok::Expect::Not->new($self->[0]);
}

sub empty {
    my $self = shift;
    if (ref $self->[0] eq 'ARRAY') {
        Hok->context->is(0+@{$self->[0]}, 0);
    } elsif (ref $self->[0] eq 'HASH') {
        Hok->context->is(0+keys(%{$self->[0]}), 0);
    } else {
        Carp::croak("You cannot check 'empty' with this type...");
    }
}

sub length :method {
    my ($self, $len) = @_;
    if (ref $self->[0] eq 'ARRAY') {
        Hok->context->is(0+@{$self->[0]}, $len);
    } else {
        Hok->context->is(CORE::length($self->[0]), $len);
    }
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
    Carp::croak("Missing regexp for match. You man passed // instead of qr//?") unless defined $regexp;
    Hok->context->like($self->[0], $regexp);
}

sub only {
    my $self = shift;
    @_==0 or Carp::croak();

    $self->[ONLY()]++;
    $self;
}

sub key {
    my ($self, $key) = (shift, shift);
    Carp::croak("Invalid arguments for key") if @_;
    Carp::croak("Invalid arguments for key") if not defined $key;

    if (ref $self->[0] eq 'HASH') {
        Hok->context->ok(!!exists($self->[0]->{$key}));
    } else {
        Hok->context->fail();
        Hok->context->diag("This is not a hash.");
    }
}

sub keys {
    my ($self, @key) = (shift, @_);
    Carp::croak("You may forgot 'only'?") unless $self->[ONLY];

    if (ref $self->[0] eq 'HASH') {
        my %copy = %{$self->[0]};
        for (@key) {
            delete $copy{$_};
        }
        Hok->context->ok(keys %copy == 0);
    } else {
        Hok->context->fail();
        Hok->context->diag("This is not a hash.");
    }
}

# expect([1, 2]).to.contain(1);
# expect('hello world').to.contain('world');
sub contain {
    my ($self, $stuff) = @_;
    if (ref $self->[0] eq 'ARRAY') {
        my $test = sub {
            for my $m (@{$self->[0]}) {
                return 1 if $m eq $stuff;
            }
            return 0;
        }->();
        Hok->context->ok($test);
    } else {
        Hok->context->ok(index($self->[0], $stuff)>=0);
    }
}

sub throw_exception {
    my $self = shift;
    if (@_) {
        if (ref $_[0] eq 'Regexp') {
            my $re = shift;
            my $err;
            try {
                $self->[0]->();
            } catch {
                $err++;
                Hok->context->like($_, $re);
            };
            unless ($err) {
                Hok->context->fail("Don't throws");
            }
        } elsif (ref $_[0] eq 'CODE') {
            my $code = shift;
            my $err;
            try {
                $self->[0]->();
            } catch {
                $err++;
                $code->($_);
            };
            unless ($err) {
                Hok->context->fail("Don't throws");
            }
        } else {
            Carp::croak "Unknown : " . ref $_[0];
        }
    } else {
        my $err;
        try {
            $self->[0]->();
        } catch {
            $err++;
        };
        Hok->context->ok($err);
    }
}

our $AUTOLOAD;
sub AUTOLOAD {
    my $self = shift;
    $AUTOLOAD =~ s/.*:://g;
    if ($AUTOLOAD =~ s/^(to|have|be|not|only)_//) {
        my $meth = $1;
        my $auto = $AUTOLOAD;
        $self->$meth->$auto(@_);
    } else {
        Carp::croak("Unknown method: $AUTOLOAD");
    }
}

sub DESTROY { }

package # hide from pause
    Hok::Expect::Not;

use Try::Tiny;

sub ONLY() { Hok::Expect::ONLY }

sub new {
    my $class = shift;
    bless [@_], $class;
}

sub DESTROY { }

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

sub only {
    my $self = shift;
    @_==0 or Carp::croak();

    $self->[ONLY()]++;
    $self;
}

sub equal {
    my $self = shift;
    my $expect = shift;

    Hok->context->isnt($self->[0], $expect);
}

sub match {
    my ($self, $regexp) = @_;
    Carp::croak("Missing regexp for match. You man passed // instead of qr//?") unless defined $regexp;
    Hok->context->unlike($self->[0], $regexp);
}

sub empty {
    my $self = shift;
    if (ref $self->[0] eq 'ARRAY') {
        Hok->context->isnt(0+@{$self->[0]}, 0);
    } elsif (ref $self->[0] eq 'HASH') {
        Hok->context->isnt(0+keys(%{$self->[0]}), 0);
    } else {
        Carp::croak("You cannot check 'empty' with this type...");
    }
}

sub key {
    my ($self, $key) = (shift, shift);
    Carp::croak("You may forgot 'only'?") unless $self->[ONLY];

    if (ref $self->[0] eq 'HASH') {
        Hok->context->ok(not exists $self->[0]->{$key});
    } else {
        Hok->context->fail();
        Hok->context->diag("This is not a hash.");
    }
}

sub throw_exception {
    my $self = shift;
    if (@_) {
        Carp::croak("Invalid method calling. You cannot call not->throw_exception with arguments");
    } else {
        my $err;
        try {
            $self->[0]->();
        } catch {
            $err++;
        };
        Hok->context->ok(!$err);
    }
}

1;

__END__

=head1 SEE ALSO

L<https://github.com/LearnBoost/expect.js>

