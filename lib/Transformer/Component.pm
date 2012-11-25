package Transformer::Component;

use strict;
use warnings;

sub new {
   my $class = shift;
   my $args  = shift;

   my $self = {};

   bless $self, $class;
}

sub process {
   my (@input) = @_;
   return @input;
}

1;
