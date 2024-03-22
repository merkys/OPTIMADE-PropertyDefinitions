package OPTIMADE::PropertyDefinitions::Property;

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

sub description() { $self->yaml->{description} }
sub query_support() { $self->parent->yaml->{'query-support'} }
sub response_level() { $self->parent->yaml->{'response-level'} }
sub sortable() { $self->parent->yaml->{sortable} }
sub support() { $self->parent->yaml->{support} }
sub type() { @{$self->yaml->{type}} }
sub unit() { $self->yaml->{'x-optimade-unit'} }

sub yaml()
{
    my( $self ) = @_;
    return $self->{yaml} if exists $self->{yaml};

    $self->{yaml} = LoadFile $self->parent->parent->path . '/properties/optimade/' . $self->parent->name . '/' . $self->name . '.yaml';
    return $self->{yaml};
}

1;
