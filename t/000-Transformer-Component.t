use strict;
use warnings;

use Test::More tests => 3;

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


done_testing;
