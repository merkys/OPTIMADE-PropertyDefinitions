package OPTIMADE::PropertyDefinitions::Property;

# ABSTRACT: OPTIMADE Property
# VERSION

use strict;
use warnings;

use List::Util qw( any );
use OPTIMADE::PropertyDefinitions::Property::Nested;

sub new
{
    my( $class, $parent, $name ) = @_;
    return bless { parent => $parent, name => $name }, $class;
}

sub name() { $_[0]->{name} }
sub parent() { $_[0]->{parent} }

sub property($)
{
    my( $self, $property ) = @_;

    if( !exists $self->yaml->{properties} ||
        !exists $self->yaml->{properties}{$property} ) {
        die "no such property '$property'\n";
    }

    return OPTIMADE::PropertyDefinitions::Property::Nested->new( $self, $property );
}

sub properties()
{
    my( $self ) = @_;
    return my @empty unless exists $self->yaml->{properties};
    return map { OPTIMADE::PropertyDefinitions::Property::Nested->new( $self, $_ ) }
               sort keys %{$self->yaml->{properties}};
}

sub description() { $_[0]->yaml->{description} }
sub format() { $_[0]->yaml->{format} }
sub optimade_type() { $_[0]->yaml->{'x-optimade-type'} }
sub query_support() { $_[0]->parent->yaml->{'query-support'} }
sub required() { exists $_[0]->yaml->{required} ? @{$_[0]->yaml->{required}} : my @empty }
sub response_level() { $_[0]->parent->yaml->{'response-level'} }
sub sortable() { $_[0]->parent->yaml->{sortable} }
sub support() { $_[0]->parent->yaml->{support} }
sub type() { @{$_[0]->yaml->{type}} }
sub unit() { $_[0]->yaml->{'x-optimade-unit'} }
sub version() { $_[0]->yaml->{version} }

sub is_nullable() { any { $_ eq 'null' } $_[0]->type }

sub yaml()
{
    my( $self ) = @_;
    return $self->{yaml} if exists $self->{yaml};

    $self->{yaml} = $self->parent->parent->yaml( 'properties/optimade/' . $self->parent->name . '/' . $self->name );
    return $self->{yaml};
}

1;
