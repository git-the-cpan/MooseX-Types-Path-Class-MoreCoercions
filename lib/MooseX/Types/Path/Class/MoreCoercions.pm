use 5.008001;
use strict;
use warnings;

package MooseX::Types::Path::Class::MoreCoercions;
# ABSTRACT: Coerce stringable objects to work with MooseX::Types::Path::Class
our $VERSION = '0.001'; # VERSION

use Moose;
use MooseX::Types::Stringlike qw/Stringable/;
use MooseX::Types::Path::Class ();
use Path::Class ();
use MooseX::Types -declare => [qw( Dir File )];

subtype Dir,
  as MooseX::Types::Path::Class::Dir;

subtype File,
  as MooseX::Types::Path::Class::File;

coerce Dir,
  from Stringable, via { Path::Class::Dir->new("$_") };

coerce File,
  from Stringable, via { Path::Class::File->new("$_") };

1;


# vim: ts=2 sts=2 sw=2 et:

__END__
=pod

=head1 NAME

MooseX::Types::Path::Class::MoreCoercions - Coerce stringable objects to work with MooseX::Types::Path::Class

=head1 VERSION

version 0.001

=head1 SYNOPSIS

  ### specification of type constraint with coercion

  package Foo;

  use Moose;
  use MooseX::Types::Path::Class::MoreCoercions qw/File/;

  has filename => (
    is => 'ro',
    isa => 'File',
    coerce => 1,
  );

  ### usage in code

  my $tmp = File::Temp->new;

  Foo->new( filename => $tmp ); # coerced to Path::Class::File

=head1 DESCRIPTION

This module extends L<MooseX::Types::Path::Class> to allow objects
that have overloaded stringification to be coerced into L<Path::Class>
objects.

=for Pod::Coverage method_names_here

=head1 SUBTYPES

This module uses L<MooseX::Types> to define the following subtypes.

=head2 Dir

C<Dir> is a subtype of C<MooseX::Types::Path::Class::Dir>.  Objects with
overloaded stringification are coerced as strings if coercion is enabled.

=head2 File

C<File> is a subtype of C<MooseX::Types::Path::Class::File>.  Objects with
overloaded stringification are coerced as strings if coercion is enabled.

=head1 CAVEATS

=head2 Usage with File::Temp

Because an argument is stringified and then coerced into a Path::Class object,
no reference to the original File::Temp argument is held.  Be sure to hold an
external reference to it to avoid immediate cleanup of the object at the end
of the enclosing scope.

=head1 SEE ALSO

=over 4

=item *

L<Moose::Manual::Types>

=item *

L<MooseX::Types::Path::Class>

=back

=for :stopwords cpan testmatrix url annocpan anno bugtracker rt cpants kwalitee diff irc mailto metadata placeholders metacpan

=head1 SUPPORT

=head2 Bugs / Feature Requests

Please report any bugs or feature requests through the issue tracker
at L<http://rt.cpan.org/Public/Dist/Display.html?Name=MooseX-Types-Path-Class-MoreCoercions>.
You will be notified automatically of any progress on your issue.

=head2 Source Code

This is open source software.  The code repository is available for
public review and contribution under the terms of the license.

L<https://github.com/dagolden/moosex-types-path-class-morecoercions>

  git clone https://github.com/dagolden/moosex-types-path-class-morecoercions.git

=head1 AUTHOR

David Golden <dagolden@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2012 by David Golden.

This is free software, licensed under:

  The Apache License, Version 2.0, January 2004

=cut
