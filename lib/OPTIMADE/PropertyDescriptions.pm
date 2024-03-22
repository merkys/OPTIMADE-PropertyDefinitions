package OPTIMADE::PropertyDescriptions;

use strict;
use warnings;

sub new
{
    my( $class, $path ) = @_;
    return bless { path => $path }, $class;
}

sub entry_types()
{
    my( $self ) = @_;
}

1;
