package Transformer::Component;

use strict;
use warnings;

use Moose;

has input  => (is => 'ro', isa => 'Transformer::Supply', lazy => 1,
   default => sub { Transformer::Supply->new });
has output => (is => 'ro', isa => 'Transformer::Supply', lazy => 1,
   default => sub { Transformer::Supply->new });

has process => (is => 'ro', isa => 'CodeRef', lazy => 1,
   default => sub { \&_process });


sub BUILD {
   my $self = shift;
   $self->input->tap(sub { $self->process->($self, @_) });
   return;
}

sub _process {
   my $self = shift;
   $self->output->more(@_);
}

1;
