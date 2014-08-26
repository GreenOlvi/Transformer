use strict;
use warnings;

use Test::More tests => 4;
use Test::Deep;

use Data::Dumper;

use_ok 'Transformer::Supply';


subtest 'new' => sub {
   my $s = Transformer::Supply->new;
   isa_ok $s, 'Transformer::Supply';
};


subtest 'tap & more' => sub {
   my @test_values = (10, 20, 0, undef, 'a', [4, 'c'], { hello => 'world' });

   my $s = Transformer::Supply->new;

   my $i;
   $s->tap(sub {
      my $value = shift;
      cmp_deeply $value, $test_values[$i++];
   });

   subtest 'One value at a time' => sub {
      $i = 0;
      $s->more($_) foreach @test_values;
      is $i, scalar @test_values, 'All values passed';
   };

   subtest 'All values at once' => sub {
      $i = 0;
      $s->more(@test_values);
      is $i, scalar @test_values, 'All values passed';
   };
};


subtest 'grep' => sub {
   my $s = Transformer::Supply->new;

   my @tests = ([0, 0], [10, 1], [-5, 0], [23, 1]);

   my $i = 0;
   $s->grep(sub { $_->[0] > 5 })->tap(sub {
      my $val = shift;
      is $val->[1], 1;
      $i++
   });

   $s->more($_) foreach (@tests);

   is $i, scalar(grep { $_->[1] } @tests), 'All values found';
};


done_testing;
