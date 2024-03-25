#!/usr/bin/perl

use strict;
use warnings;

use OPTIMADE::PropertyDefinitions;
use Test::More;

plan tests => 1;

my $pd = OPTIMADE::PropertyDefinitions->new( 'externals/OPTIMADE/schemas/src/defs/v1.2/' );

my $id = $pd->entry_type( 'structures' )->property( 'id' );
is $id->optimade_type, 'string', 'simple one-step resolution';

# my $ref_editor_name = $pd->entry_type( 'references' )->property( 'editors' )->property( 'name' );
# is $ref_editor_name->unit, 'inapplicable';
