package OPTIMADE::PropertyDefinitions::EntryType;

use strict;
use warnings;

use OPTIMADE::PropertyDefinitions::Property;

sub new
{
    my( $class, $parent, $name ) = @_;
    return bless { parent => $parent, name => $name }, $class;
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
