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


package RSBX::Util::PseudoRandomSequenceGenerator v0.0.0.0;


use RSBX::Util::Math::isInteger qw( isInteger );
use RSBX::Util::Math::isCoprime qw( isCoprime );
use List::Util;


use Exporter;
our @ISA = qw(Exporter);
our %EXPORT_TAGS = ( );
our @EXPORT_OK = qw( );
our @EXPORT = qw( );


######
## OO Interface
######

sub __Init
	{
	my ($self, $digits, $base, %options) = @_;

	return undef if !isInteger($digits) || $digits < 1 || !isInteger($base) || $base < 2;

	$self->{'B'} = $base;
	$self->{'N'} = $digits;
	$self->{'I'} = [(0) x $digits];
	$self->{'C'} = [(0) x $digits];
	$self->{'m'} = exists($options{'NoShuffle'}) ? [0 .. $digits-1] : [List::Util::shuffle 0 .. $digits-1];

	if (exists($options{'CisOne'}))
		{
		$self->{'C'}->[0] = 1;
		}
	else
		{
		for (my $i=0; $i<$self->{'N'}; $i++)
			{
			$self->{'C'}->[$i] = int(rand($self->{'B'}));
			}
		while (!isCoprime($self->{'C'}->[0], $self->{'B'}))
			{
			$self->{'C'}->[0]++;
			}
		}

	if (exists($options{'ZeroFirst'}))
		{
		for (my $i=0; $i<$self->{'N'}; $i++)
			{
			$self->{'I'}->[$i] = $self->{'B'} - $self->{'C'}->[$i] - 1;
			}
		$self->{'I'}->[0]++;
		}
	else
		{
		for (my $i=0; $i<$self->{'N'}; $i++)
			{
			$self->{'I'}->[$i] = int(rand($self->{'B'}));
			}
		}

	return $self;
	}


sub NewArrayGenerator
	{
	my ($package, $digits, $base, %options) = @_;
	$package = ref($package) || $package;

	return undef if !isInteger($digits) || $digits < 1 || !isInteger($base) || $base < 2;

	my $self = {};

	return __Init(bless($self, $package), $digits, $base, %options);
	}


sub NewStringGenerator
	{
	my ($package, $digits, $string_array_ref, %options) = @_;
	$package = ref($package) || $package;

	my $self = {};

	$self->{'DigitsMap'} = $string_array_ref;

	return __Init(bless($self, $package), $digits, @{$string_array_ref}-2, %options);
	}


sub Next
	{
	my ($self) = @_;

	my $carry = 0;
	for (my $i=0; $i<$self->{'N'}; $i++)
		{
		$self->{'I'}->[$i] += $self->{'C'}->[$i] + $carry;
		$carry = 0;
		if ($self->{'I'}->[$i] >= $self->{'B'})
			{
			$self->{'I'}->[$i] -= $self->{'B'};
			$carry = 1;
			}
		}

	my @resultarray = map { $self->{'I'}->[$_] } @{$self->{'m'}};

	return @resultarray if !exists($self->{'DigitsMap'});

	return $self->{'DigitsMap'}->[$self->{'B'}] . join('', map { $self->{'DigitsMap'}->[$_] } @resultarray) . $self->{'DigitsMap'}->[$self->{'B'}+1];
	}


######
## One Time Initializations
######


1;


__END__


=pod

=head1 NAME

RSBX::Util::PseudoRandomSequenceGenerator - Produces sequences of pseudo-random values.

=head1 SYNOPSIS

 use RSBX::Util::PseudoRandomSequenceGenerator;
 ...
 $Agen = RSBX::Util::PseudoRandomSequenceGenerator->NewStringGenerator(
         8,    # "digits"
         16,   # base
         );
 ...
 $Sgen = RSBX::Util::PseudoRandomSequenceGenerator->NewStringGenerator(
         8,
         [split('', '0123456789ABCDEF'), 'Pre-', '-Post'],
         );
 ...
 @array = $Agen->Next();
 ...
 $string = $Sgen->Next();
 ...

=head1 DESCRIPTION

Produces sequences of pseudo-random values.

=head1 CONSTRUCTORS

=over 4

=item NewArrayGenerator ( I<digits> , I<base> [, OPTIONS ] )

Create a pseudo-random array sequence generator.

=over 4

=item PARAMETERS

=over 4

=over 4

=item I<digits>

The size of each generated array.  Each array value being the corresponding I<digit>.

=item I<base>

The numeric base.  Each generated I<digit> will have a value constrained to: C<0 E<lt>= > I<digit> C<E<lt> > I<base>.

=back

=back

=item OPTIONS

=over 4

=over 4

=item C<'ZeroFirst'> =E<gt> C<1>

The first pseudo-random array sequence value generated will be an array of C<0>s.

=item C<'CisOne'> =E<gt> C<1>

Generate sequence values in counter mode.  Sequence values will be I<much>
easier to predict if this option is given.

=item C<'NoShuffle'> =E<gt> C<1>

This option disables the use of a fixed random mapping of internal generator
state to generated "digit" order.

=back

=back

=item RETURNS

An initialized pseudo-random array sequence generator object if there were no errors. Or C<undef> if there was an error.

=back

=item NewStringGenerator ( I<digits> , I<digits2string_array_ref> [, OPTIONS ] )

Create a pseudo-random string sequence generator.

=over 4

=item PARAMETERS

=over 4

=over 4

=item I<digits>

The number of "digits" each generated string will contain.

=item I<digits_2_string_array_ref>

Reference to an array containing the mapping from "digit" values to the
corresponding string representation, and string prefix and postfix values.

The I<base> for the pseudo-random string sequence generator is the array
length minus 2.  The first I<base> values in the array being the string
representation of the corresponding "digit" value.  The last 2 array values
are the output string prefix and postfix string values.

=back

=back

=item OPTIONS

=over 4

=over 4

=item C<'ZeroFirst'> =E<gt> C<1>

The first pseudo-random string sequence value generated will correspond to
all "digits" having the value C<0>.

=item C<'CisOne'> =E<gt> C<1>

Generate sequence values in counter mode.  Sequence values will be I<much>
easier to predict if this option is given.

=item C<'NoShuffle'> =E<gt> C<1>

This option disables the use of a fixed random mapping of internal generator
state to generated "digit" order.

=back

=back

=item RETURNS

An initialized pseudo-random string sequence generator object if there were no errors. Or C<undef> if there was an error.

=back

=back

=head1 METHODS

=over 4

=item Next ( )

Returns the next array or string pseudo-random sequence value;

=back

=head1 DIAGNOSTICS

None.

=head1 DEPENDENCIES

=over 4

=item RSBX::Util::Math::isCoprime

=item RSBX::Util::Math::isInteger

=back

=head1 BUGS AND LIMITATIONS

None known.

Please report problems to Raymond S Brand E<lt>rsbx@acm.orgE<gt>.

Problem reports without included demonstration code and/or tests will be ignored.

Patches are welcome.

=head1 THEORY OF OPERATION

Internally, it is a linear congruential generator with:

=over 4

=item *

The I<multiplier> set to C<1>

=item *

The I<initial state> chosen randomly, unless the C<'ZeroFirst'> option was
given to the constructor.

=item *

The I<increment> chosen randomly but contrained to be coprime to the
I<modulus>. Unless the C<'CisOne'> option was given to the constructor, in
which case the I<increment> is C<1>.

=back

To further increase the perception of sequence randomness, there is also a
fixed random shuffling of the digit positions on output, unless the
C<'NoShuffle'> option was given to the constructor.

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



