#!/usr/bin/perl

#  Copyright (c) 2016, Raymond S Brand
#  All rights reserved.
#
#  Redistribution and use in source and binary forms, with or without
#  modification, are permitted provided that the following conditions
#  are met:
#
#   * Redistributions of source code must retain the above copyright
#     notice, this list of conditions and the following disclaimer.
#
#   * Redistributions in binary form must reproduce the above copyright
#     notice, this list of conditions and the following disclaimer in
#     the documentation and/or other materials provided with the
#     distribution.
#
#   * Redistributions in source or binary form must carry prominent
#     notices of any modifications.
#
#   * Neither the name of Raymond S Brand nor the names of its other
#     contributors may be used to endorse or promote products derived
#     from this software without specific prior written permission.
#
#  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
#  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
#  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
#  FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
#  COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
#  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
#  BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
#  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
#  CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
#  LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
#  ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
#  POSSIBILITY OF SUCH DAMAGE.


use strict;
use warnings;


package RSBX::Util::Math::isInteger v0.0.0.0;


use Exporter;
our @ISA = qw(Exporter);
our %EXPORT_TAGS = ( );
our @EXPORT_OK = qw( isInteger );
our @EXPORT = qw( );


sub isInteger
	{
	my $qnum = shift;

	no warnings 'numeric';

	return defined($qnum)					# eliminate undef
				&& ref($qnum) eq ''		# eliminate refs
				&& ($qnum != 0 || $qnum eq '0')	# eliminate strings
				&& $qnum == $qnum		# eliminate NaN
				&& $qnum+1 != $qnum		# eliminate INF and -INF
				&& int($qnum) == $qnum		# eliminate non-integers
			? 1
			: 0
			;
	}


######
## One Time Initializations
######


1;


__END__


=pod

=head1 NAME

RSBX::Util::Math::isInteger - Determine if a value is an integer.

=head1 SYNOPSIS

 use RSBX::Util::Math::isInteger qw( isInteger );
 ...
 if (isInteger($v))
     {
     ...
     }
 else
     {
     ...
     }

=head1 DESCRIPTION

Tests if a value is an integer.

=head1 FUNCTIONS

=over 4

=item isInteger( I<value> )

Tests if a value is an integer.

=over 4

=item PARAMETERS

=over 4

=over 4

=item I<value>

The value to test.

=back

=back

=item RETURNS

=over 4

=over 4

=item C<True> If the value is an integer.

=item C<False> If the value is not an integer.

=back

=back

=back

=back

=head1 DIAGNOSTICS

None.

=head1 BUGS AND LIMITATIONS

None known.

Please report problems to Raymond S Brand E<lt>rsbx@acm.orgE<gt>.

Problem reports without included demonstration code and/or tests will be ignored.

Patches are welcome.

=head1 AUTHOR

Raymond S Brand E<lt>rsbx@acm.orgE<gt>

=head1 COPYRIGHT

Copyright (c) 2016 Raymond S Brand. All rights reserved.

=head1 LICENSE

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions
are met:

=over 4

=item *

Redistributions of source code must retain the above copyright
notice, this list of conditions and the following disclaimer.

=item *

Redistributions in binary form must reproduce the above copyright
notice, this list of conditions and the following disclaimer in
the documentation and/or other materials provided with the
distribution.

=item *

Redistributions in source or binary form must carry prominent
notices of any modifications.

=item *

Neither the name of Raymond S Brand nor the names of its other
contributors may be used to endorse or promote products derived
from this software without specific prior written permission.

=back

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
"AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
POSSIBILITY OF SUCH DAMAGE.

=cut

