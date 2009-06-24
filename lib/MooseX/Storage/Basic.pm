package MooseX::Storage::Basic;
use Moose::Role;

use MooseX::Storage::Engine;

our $VERSION   = '0.18';
our $AUTHORITY = 'cpan:STEVAN';

sub pack {
    my ( $self, @args ) = @_;
    my $e = $self->_storage_get_engine( object => $self );
    $e->collapse_object(@args);
}

sub unpack {
    my ($class, $data, %args) = @_;
    my $e = $class->_storage_get_engine(class => $class);
    
    $class->_storage_construct_instance( 
        $e->expand_object($data, %args), 
        \%args 
    );
}

sub _storage_get_engine {
    my $self = shift;
    MooseX::Storage::Engine->new( @_ );
}

sub _storage_construct_instance {
    my ($class, $args, $opts) = @_;
    my %i = defined $opts->{'inject'} ? %{ $opts->{'inject'} } : ();
 
    $class->new( %$args, %i );
}

1;

__END__

=pod

=head1 NAME

MooseX::Storage::Basic - The simplest level of serialization

=head1 SYNOPSIS

  package Point;
  use Moose;
  use MooseX::Storage;
  
  our $VERSION = '0.01';
  
  with Storage;
  
  has 'x' => (is => 'rw', isa => 'Int');
  has 'y' => (is => 'rw', isa => 'Int');
  
  1;
  
  my $p = Point->new(x => 10, y => 10);
  
  ## methods to pack/unpack an 
  ## object in perl data structures
  
  # pack the class into a hash
  $p->pack(); # { __CLASS__ => 'Point-0.01', x => 10, y => 10 }
  
  # unpack the hash into a class
  my $p2 = Point->unpack({ __CLASS__ => 'Point-0.01', x => 10, y => 10 });
  
  # unpack the hash, with insertion of paramaters
  my $p3 = Point->unpack( $p->pack, inject => { x => 11 } );

=head1 DESCRIPTION

This is the most basic form of serialization. This is used by default 
but the exported C<Storage> function.

=head1 METHODS

=over 4

=item B<pack>

=item B<unpack ($data [, insert => { key => val, ... } ] )>

Providing the C<insert> argument let's you supply additional arguments to
the class' C<new> function, or override ones from the serialized data.

=back

=head2 Introspection

=over 4

=item B<meta>

=back

=head1 BUGS

All complex software has bugs lurking in it, and this module is no 
exception. If you find a bug please either email me, or add the bug
to cpan-RT.

=head1 AUTHOR

Chris Prather E<lt>chris.prather@iinteractive.comE<gt>

Stevan Little E<lt>stevan.little@iinteractive.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright 2007-2008 by Infinity Interactive, Inc.

L<http://www.iinteractive.com>

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
