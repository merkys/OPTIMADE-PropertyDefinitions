package OPTIMADE::PropertyDescriptions::Property;

use strict;
use warnings;

use YAML;

sub new
{
    my( $parent, $name ) = @_;
    return bless { parent => $parent, name => $name }, $class;
}

sub name() { $_[0]->{name} }
sub parent() { $_[0]->{parent} }

1;
