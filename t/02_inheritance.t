#!/usr/bin/perl

use strict;
use warnings;

use OPTIMADE::PropertyDefinitions;
use Test::More;

plan tests => 1;

my $pd = OPTIMADE::PropertyDefinitions->new( 'externals/OPTIMADE/schemas/src/defs/v1.2/' );
my $id = $pd->entry_type( 'structures' )->property( 'id' );

is $id->optimade_type, 'string';
