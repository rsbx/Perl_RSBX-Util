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


package RSBX::Util::Math::isCoprime v0.0.0.0;


use Exporter;
our @ISA = qw(Exporter);
our %EXPORT_TAGS = ( );
our @EXPORT_OK = qw( isCoprime );
our @EXPORT = qw( );


sub isCoprime
	{
	#
	# Based on the Binary GCD algorithm
	#
	my ($u, $v) = @_;

	return 0 if $u <= 0 || $v <= 0 || $u == $v || (($u | $v) & 1) == 0;

	while (!($u & 1))
		{
		$u >>= 1;
		}

	do
		{
		while (!($v & 1))
			{
			$v >>= 1;
			}

		if ($u > $v)
			{
			my $t = $u;
			$u = $v;
			$v = $t;
			}

		$v -= $u;
		} while $v;

	return $u == 1;
	}


######
## One Time Initializations
######


1;


__END__


=pod

=head1 NAME

RSBX::Util::Math::isCoprime - Tests if 2 positive inntegers are coprime.

=head1 SYNOPSIS

 use RSBX::Util::Math::isCoprime qw( isCoprime );
 ...
 if (isCoprime($u, $v))
     {
     ...
     }
 else
     {
     ...
     }

=head1 DESCRIPTION

Tests if 2 positive inntegers are coprime.

=head1 FUNCTIONS

=over 4

=item isCoprime( I<value1>, I<value2> )

Tests if 2 positive inntegers are coprime.

=over 4

=item PARAMETERS

=over 4

=over 4

=item I<value1>

One of the values to test.

=item I<value2>

The other value to test.

=back

=back

=item RETURNS

=over 4

=over 4

=item C<True> If the values are coprime.

=item C<False> If the values are not coprime.

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



