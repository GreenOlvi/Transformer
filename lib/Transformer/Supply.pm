package Transformer::Supply;

use strict;
use warnings;

use Moose;

has _taps => (is => 'ro', isa => 'ArrayRef[CodeRef]', default => sub { [] });

sub tap {
   my $self = shift;
   my $code = shift;

   push @{$self->_taps}, $code;

   return $self;
}

sub more {
   my $self  = shift;
   my @values = @_;

   foreach my $value (@values) {
      $_->($value) foreach (@{$self->_taps});
   }

   return $self;
}

sub grep {
   my $self      = shift;
   my $condition = shift;

   my $t = __PACKAGE__->new;

   $self->tap(sub {
      my $val = shift;

      my $cond;
      {
         local $_ = $val;
         $cond = $condition->();
      }

      $t->more($val) if $cond;
   });

   return $t;
}

1;
