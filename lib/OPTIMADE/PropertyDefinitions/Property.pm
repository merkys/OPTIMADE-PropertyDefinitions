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

sub description() { $_[0]->yaml->{description} }
sub optimade_type() { $_[0]->yaml->{'x-optimade-type'} }

sub properties()
{
    my( $self ) = @_;
    return my @empty unless exists $self->yaml->{properties};
    return map { OPTIMADE::PropertyDefinitions::Property::Nested->new( $self, $_ ) }
               sort keys %{$self->yaml->{properties}};
}

sub query_support() { $_[0]->parent->yaml->{'query-support'} }
sub required() { exists $_[0]->yaml->{required} ? @{$_[0]->yaml->{required}} : my @empty }
sub response_level() { $_[0]->parent->yaml->{'response-level'} }
sub sortable() { $_[0]->parent->yaml->{sortable} }
sub support() { $_[0]->parent->yaml->{support} }
sub type() { @{$_[0]->yaml->{type}} }
sub unit() { $_[0]->yaml->{'x-optimade-unit'} }

sub yaml()
{
    my( $self ) = @_;
    return $self->{yaml} if exists $self->{yaml};

    $self->{yaml} = $self->parent->parent->yaml( 'properties/optimade/' . $self->parent->name . '/' . $self->name . '.yaml' );
    return $self->{yaml};
}

1;
