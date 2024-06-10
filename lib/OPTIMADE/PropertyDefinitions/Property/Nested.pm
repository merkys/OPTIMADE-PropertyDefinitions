package OPTIMADE::PropertyDefinitions::Property::Nested;

# ABSTRACT: OPTIMADE Nested property
# VERSION

use strict;
use warnings;

use parent OPTIMADE::PropertyDefinitions::Property::;

sub yaml()
{
    my( $self ) = @_;
    if( $self->parent->optimade_type eq 'list' ) {
        return $self->parent->yaml->{items}{properties}{$self->name};
    } else {
        return $self->parent->yaml->{properties}{$self->name};
    }
}

1;
