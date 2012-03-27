use 5.006;
use strict;
use warnings;
use Test::More 0.96;
use File::Temp;

{
  package Foo;
  use Moose;
  use MooseX::Types::Path::Class::MoreCoercions qw/Dir File/;
  
  has temp_file => ( is => 'ro', isa => File, coerce => 1 );
  has temp_dir  => ( is => 'ro', isa => Dir,  coerce => 1 );
}

my $tf = File::Temp->new;
my $td = File::Temp->newdir;

my $obj = eval {
  Foo->new(
    temp_file => $tf,
    temp_dir  => $td,
  )
};

is( $@, '', "object created without exception" );

isa_ok( $obj->temp_file, "Path::Class::File", "temp_file" );
isa_ok( $obj->temp_dir, "Path::Class::Dir", "temp_dir" );
is( $obj->temp_file, $tf, "temp_file set correctly" );
is( $obj->temp_dir,  $td, "temp_dir set correctly" );

done_testing;
#
# This file is part of MooseX-Types-Path-Class-MoreCoercions
#
# This software is Copyright (c) 2012 by David Golden.
#
# This is free software, licensed under:
#
#   The Apache License, Version 2.0, January 2004
#
