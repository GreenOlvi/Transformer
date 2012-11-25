package Transformer::Component::InputCSV;

use strict;
use warnings;

use base 'Transformer::Component';

use Parse::CSV;

sub new {
   my $class = shift;
   my $args  = shift;

   my $self = class->SUPER::new();

   bless $self, $class;
}


1;
