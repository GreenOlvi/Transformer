use strict;
use warnings;

use Test::More tests => 2;

use_ok 'Transformer::Component';

my $c = Transformer::Component->new;
isa_ok $c, 'Transformer::Component';

done_testing;
