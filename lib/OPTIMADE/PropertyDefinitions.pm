package OPTIMADE::PropertyDefinitions;

use strict;
use warnings;

use OPTIMADE::PropertyDefinitions::EntryType;

sub new
{
    my( $class, $path ) = @_;
    return bless { path => $path }, $class;
}

sub entry_types()
{
    my( $self ) = @_;
    opendir my $dir, $self->path . '/entrytypes/optimade/';
    my @files = sort map { s/\.yaml$//; $_ } grep { /\.yaml$/ } readdir $dir;
    close $dir;
    return map { OPTIMADE::PropertyDefinitions::EntryType->new( $self, $_ ) } @files;
}

sub path() { $_[0]->{path} }

1;
