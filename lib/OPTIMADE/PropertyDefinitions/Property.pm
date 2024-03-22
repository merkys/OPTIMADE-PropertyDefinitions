package OPTIMADE::PropertyDefinitions::Property;

use strict;
use warnings;

use OPTIMADE::PropertyDefinitions::Property::Nested;

sub new
{
    my( $class, $parent, $name ) = @_;
    return bless { parent => $parent, name => $name }, $class;
}

sub name() { $_[0]->{name} }
sub parent() { $_[0]->{parent} }

sub description() { $self->yaml->{description} }
sub optimade_type() { $self->yaml->{'x-optimade-type'} }

sub properties()
{
    my( $self ) = @_;
    return my @empty unless exists $self->yaml->{properties};
    return map { OPTIMADE::PropertyDefinitions::Property::Nested->new( $self, $_ ) }
               sort keys %{$self->yaml->{properties}};
}

sub query_support() { $self->parent->yaml->{'query-support'} }
sub required() { exists $self->yaml->{required} ? @{$self->yaml->{required}} : my @empty }
sub response_level() { $self->parent->yaml->{'response-level'} }
sub sortable() { $self->parent->yaml->{sortable} }
sub support() { $self->parent->yaml->{support} }
sub type() { @{$self->yaml->{type}} }
sub unit() { $self->yaml->{'x-optimade-unit'} }

sub yaml()
{
    my( $self ) = @_;
    return $self->{yaml} if exists $self->{yaml};

    $self->{yaml} = $self->parent->parent->yaml( 'properties/optimade/' . $self->parent->name . '/' . $self->name . '.yaml' );
    return $self->{yaml};
}

1;
