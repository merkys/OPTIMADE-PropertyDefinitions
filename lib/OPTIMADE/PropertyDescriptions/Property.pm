package OPTIMADE::PropertyDescriptions::Property;

use strict;
use warnings;

use YAML qw( LoadFile );

sub new
{
    my( $class, $parent, $name ) = @_;
    return bless { parent => $parent, name => $name }, $class;
}

sub name() { $_[0]->{name} }
sub parent() { $_[0]->{parent} }

sub description() { $self->_get( 'description' ) }
sub type() { @{$self->_get( 'type' )} }
sub unit() { $self->_get( 'x-optimade-unit ') }

1;
