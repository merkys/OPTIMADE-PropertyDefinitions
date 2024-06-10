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
    die "no such property '$property'\n" unless exists $self->raw->{properties}{$property};
    return OPTIMADE::PropertyDefinitions::Property->new( $self, $property );
}

sub properties()
{
    my( $self ) = @_;
    return map { OPTIMADE::PropertyDefinitions::Property->new( $self, $_ ) }
               sort keys %{$self->raw->{properties}};
}

sub name() { $_[0]->{name} }
sub parent() { $_[0]->{parent} }

sub raw()
{
    my( $self ) = @_;
    return $self->{raw} if exists $self->{raw};

    $self->{raw} = $self->parent->raw( 'entrytypes/optimade/' . $self->name );
    return $self->{raw};
}

1;
