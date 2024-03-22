package OPTIMADE::PropertyDefinitions::Property::Nested;

use strict;
use warnings;

use parent OPTIMADE::PropertyDefinitions::Property;

sub yaml()
{
    my( $self ) = @_;
    return $self->parent->yaml->{properties}{$self->name};    
}

1;
