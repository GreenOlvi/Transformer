use strict;
use warnings;

use Test::Deep;
use Test::More tests => 4;

use Transformer::Supply;


use_ok 'Transformer::Component';

subtest 'new' => sub {
   my $c = Transformer::Component->new;
   isa_ok $c, 'Transformer::Component';
};

subtest 'Simple process' => sub {
   my $input = Transformer::Supply->new;

   my @test_values = ('a', 2, [4, 'c'], { a => 'd' });
   my @result;

   my $output = Transformer::Supply->new;
   $output->tap(sub { push @result, $_[0] });

   my $c = Transformer::Component->new(input => $input, output => $output);

   $input->more(@test_values);

   is_deeply(\@result, \@test_values);
};

subtest 'Add one to each value' => sub {
   my @test_values = (1, 15, 1.4, -10);
   my @results = map { $_ + 1 } @test_values;

   my $c = Transformer::Component->new(process => sub {
      my $self = shift;
      $self->output->more($_[0] + 1);
   });

   my @output = ();
   $c->output->tap(sub { push @output, $_[0] });

   $c->input->more(@test_values);

   cmp_deeply(\@output, \@results);
};


done_testing;
