package OPTIMADE::PropertyDescriptions::EntryType;

use strict;
use warnings;

use OPTIMADE::PropertyDescriptions::Property;
use YAML;

sub new
{
    my( $parent, $name ) = @_;
    return bless { parent => $parent, name => $name }, $class;
}

sub properties()
{
    my( $self ) = @_;
    my $yaml = LoadFile $self->parent . '/' . $self->name . '.yaml';
    return map { OPTIMADE::PropertyDescriptions::Property->new( $self, $_ ) }
               @{$yaml->{properties}};
}

sub name() { $_[0]->{name} }
sub parent() { $_[0]->{parent} }

1;
