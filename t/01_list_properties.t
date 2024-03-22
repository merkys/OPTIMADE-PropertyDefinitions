#!/usr/bin/perl

use strict;
use warnings;

use OPTIMADE::PropertyDefinitions;
use Test::More;

plan tests => 1;

my $pd = OPTIMADE::PropertyDefinitions->new( 'externals/OPTIMADE/schemas/src/defs/v1.2/' );
my @properties = map { $_->properties } $pd->entry_types;

ok 1;
