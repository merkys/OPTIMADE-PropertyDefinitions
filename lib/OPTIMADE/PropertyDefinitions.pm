package OPTIMADE::PropertyDefinitions;

# ABSTRACT: Top-level Property Definition class
# VERSION

use strict;
use warnings;

use OPTIMADE::PropertyDefinitions::EntryType;
use YAML qw( LoadFile );

sub new
{
    my( $class, $path ) = @_;
    $path .= '/' unless $path =~ /\/$/;
    return bless { path => $path }, $class;
}

sub entry_type($)
{
    my( $self, $entry_type ) = @_;
    die "no such entry type '$entry_type'\n" unless -e $self->path . 'entrytypes/optimade/' . $entry_type . '.yaml';
    return OPTIMADE::PropertyDefinitions::EntryType->new( $self, $entry_type );
}

sub entry_types()
{
    my( $self ) = @_;
    opendir my $dir, $self->path . 'entrytypes/optimade/';
    my @files = sort map { s/\.yaml$//; $_ } grep { /\.yaml$/ } readdir $dir;
    close $dir;
    return map { OPTIMADE::PropertyDefinitions::EntryType->new( $self, $_ ) } @files;
}

sub path() { $_[0]->{path} }

sub raw($)
{
    my( $self, $path ) = @_;
    return $self->_resolve_inherits( LoadFile( $self->path . $path . '.yaml' ) );
}

sub _resolve_inherits($$)
{
    my( $self, $yaml ) = @_;

    if( exists $yaml->{'$$inherit'} ) {
        my $parent = $self->raw( '..' . $yaml->{'$$inherit'} );
        $yaml = { %$parent, %$yaml };
    }

    for my $key (keys %$yaml) {
        next unless ref $yaml->{$key} eq 'HASH';
        $yaml->{$key} = $self->_resolve_inherits( $yaml->{$key} );
    }

    return $yaml;
}

1;
