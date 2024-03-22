package OPTIMADE::PropertyDescriptions::EntryType;

use strict;
use warnings;

use OPTIMADE::PropertyDescriptions::Property;
use YAML qw( LoadFile );

sub new
{
    my( $class, $parent, $name ) = @_;
    return bless { parent => $parent, name => $name }, $class;
}

sub properties()
{
    my( $self ) = @_;
    my $yaml = LoadFile $self->parent->path . '/entrytypes/optimade/' . $self->name . '.yaml';
    return map { OPTIMADE::PropertyDescriptions::Property->new( $self, $_ ) }
               sort keys %{$yaml->{properties}};
}

sub name() { $_[0]->{name} }
sub parent() { $_[0]->{parent} }

1;
