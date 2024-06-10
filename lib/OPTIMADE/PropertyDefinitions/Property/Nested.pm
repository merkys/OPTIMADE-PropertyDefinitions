package OPTIMADE::PropertyDefinitions::Property::Nested;

# ABSTRACT: OPTIMADE Nested property
# VERSION

use strict;
use warnings;

use parent OPTIMADE::PropertyDefinitions::Property::;

sub raw()
{
    my( $self ) = @_;
    if( $self->parent->optimade_type eq 'list' ) {
        return $self->parent->raw->{items}{properties}{$self->name};
    } else {
        return $self->parent->raw->{properties}{$self->name};
    }
}

1;
