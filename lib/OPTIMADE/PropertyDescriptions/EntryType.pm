package OPTIMADE::PropertyDescriptions::EntryType;

use strict;
use warnings;

sub new
{
    my( $parent, $name ) = @_;
    return bless { parent => $parent, name => $name }, $class;
}

1;
