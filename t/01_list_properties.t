#!/usr/bin/perl

use strict;
use warnings;

use OPTIMADE::PropertyDefinitions;
use Test::More;

plan tests => 1;

my( $pd_yaml, $pd_json );
my( @properties_yaml, @properties_json );

$pd_yaml = OPTIMADE::PropertyDefinitions->new( 'externals/OPTIMADE/schemas/src/defs/v1.2/' );
@properties_yaml = map { $_->properties } $pd_yaml->entry_types;

if( -d 'externals/OPTIMADE/schemas/output' ) {
    $pd_json = OPTIMADE::PropertyDefinitions->new( 'externals/OPTIMADE/schemas/output/defs/v1.2/', 'json' );
    @properties_json = map { $_->properties } $pd_json->entry_types;
}

if( -d 'externals/OPTIMADE/schemas/output' ) {
    is join( '', sort map { $_->name } @properties_yaml ),
       join( '', sort map { $_->name } @properties_json );
} else {
    ok 1;
}
