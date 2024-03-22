package OPTIMADE::PropertyDescriptions::EntryType;

use strict;
use warnings;

sub new
{
    my( $parent, $name ) = @_;
    return bless { parent => $parent, name => $name }, $class;
}

sub name() { $_[0]->{name} }
sub parent() { $_[0]->{parent} }

1;
