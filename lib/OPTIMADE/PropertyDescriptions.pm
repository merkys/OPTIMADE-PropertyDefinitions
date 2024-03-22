package OPTIMADE::PropertyDescriptions;

use strict;
use warnings;

use OPTIMADE::PropertyDescriptions::EntryType;

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
    return map { OPTIMADE::PropertyDescriptions::EntryType->new( $self, $_ ) } @files;
}

sub path() { $_[0]->{path} }

1;
