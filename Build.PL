#!/usr/bin/env perl

use strict;
use warnings;

use Module::Build;

Module::Build->new(
   module_name   => 'Transformer',
   license       => 'perl',
   dist_author   => 'Piotr Szulc <szulo123@gmail.com>',
   dist_abstract => 'Module for transforming data',
   requires      => {
      'Moose'      => 0,
      'Parse::CSV' => '2.00',
   },
)->create_build_script();
