
package MooseX::Storage::Engine::IO::File;
use Moose;

use IO::File;

our $VERSION = '0.01';

has 'file' => (
	is       => 'ro',
	isa      => 'Str',	
	required => 1,
);

sub load { 
	my ($self) = @_;
	my $fh = IO::File->new($self->file, 'r');
	return do { local $/; <$fh>; };
}

sub store {
	my ($self, $data) = @_;
	my $fh = IO::File->new($self->file, 'w');
	print $fh $data;
}

1;

__END__

=pod

=head1 NAME

MooseX::Storage::Engine::IO::File - The actually file storage mechanism.

=head1 DESCRIPTION

This provides the actual means to store data to a file.

=head1 METHODS

=over 4

=item B<file>

=item B<load>

=item B<store ($data)>

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

Copyright 2007 by Infinity Interactive, Inc.

L<http://www.iinteractive.com>

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut