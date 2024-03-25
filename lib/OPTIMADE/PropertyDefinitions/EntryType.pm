package OPTIMADE::PropertyDefinitions::EntryType;

# ABSTRACT: OPTIMADE Entry Type
# VERSION

use strict;
use warnings;

use OPTIMADE::PropertyDefinitions::Property;

sub new
{
    my( $class, $parent, $name ) = @_;
    return bless { parent => $parent, name => $name }, $class;
}

sub property($)
{
    my( $self, $property ) = @_;
    die "no such property '$property'\n" unless exists $self->yaml->{properties}{$property};
    return OPTIMADE::PropertyDefinitions::Property->new( $self, $property );
}

sub properties()
{
    my( $self ) = @_;
    return map { OPTIMADE::PropertyDefinitions::Property->new( $self, $_ ) }
               sort keys %{$self->yaml->{properties}};
}

sub name() { $_[0]->{name} }
sub parent() { $_[0]->{parent} }

sub yaml()
{
    my( $self ) = @_;
    return $self->{yaml} if exists $self->{yaml};

    $self->{yaml} = $self->parent->yaml( 'entrytypes/optimade/' . $self->name . '.yaml' );
    return $self->{yaml};
}

1;
