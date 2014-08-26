use strict;
use warnings;

use Test::More tests => 2;
use Data::Dumper;

use_ok 'Transformer';

my $t = Transformer->new({ name => 'abc' });
isa_ok $t, 'Transformer';

done_testing;
