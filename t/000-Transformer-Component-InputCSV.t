use strict;
use warnings;

use Test::More tests => 2;

use_ok 'Transformer::Component::InputCSV';

my $c = Transformer::Component::InputCSV->new;
isa_ok $c, 'Transformer::Component::InputCSV';

done_testing;
