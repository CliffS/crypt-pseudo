package Crypt::Pseudo;

use strict;
use warnings;
use 5.14.0;

=head1 NAME

Crypt::Pseudo - The great new Crypt::Pseudo!

=head1 VERSION

Version 0.9.0

=cut

use version; our $VERSION = qv(0.9.0);

# http://blog.kevburnsjr.com/php-unique-hash

use bigint;
use Tie::IxHash;
use Math::Base::Convert qw(dec b62);
use Data::Dumper;
use Carp;

use constant b36 => [ '0'..'9', 'a'..'z' ];

sub hash
{
    my $self = shift;
    my $num = shift;
    my $len = shift || 5;
    my $ceil = $self->{bits} ** $len;
    my @primes = keys %{$self->{golden}};
    my $prime = $primes[$len];
    my $dec = ($num * $prime) % $ceil;
    #say "ceil = $ceil, dec = $dec"; exit;
    my $hash = $self->{base}->cnv($dec);
    #return sprintf '%0.*s', $len, $hash;
    return substr '0' x $len . $hash, -$len;
}

sub unhash($)
{
    my $self = shift;
    my $hash = shift;
    my $len = length $hash;
    my $ceil = $self->{bits} ** $len;
    #say $ceil; exit;
    my @mmiprimes = values %{$self->{golden}};
    my $mmi = $mmiprimes[$len];
    my $num = $self->{unbase}->cnv($hash);
    my $dec = ($num * $mmi) % $ceil;
    return $dec->numify;
}

sub new
{
    my $class = shift;
    my $bits = shift || 62;
    my $base;
    if ($bits == 36)
    {
	$base = b36;
    }
    elsif ($bits == 62)
    {
	$base = b62;
    }
    else {
	croak "Bits must be 62 or 36";
    }
    my @golden_primes = (
	1,
	41,
	2377,
	147299,
	9132313,
	566201239,
	35104476161,
	2176477521929,
	134941606358731,
	8366379594239857,
	518715534842869223,
    );
    tie my %golden_primes, 'Tie::IxHash', ('0' => 1);
    foreach (1 .. $#golden_primes)
    {
	my $prime = $golden_primes[$_];
	my $val = $prime->copy->bmodinv($bits ** $_);
	$golden_primes{$prime} = $val;
    }
#	1                  => 1,
#	41                 => 59,
#	2377               => 1677,
#	147299             => 187507,
#	9132313            => 5952585,
#	566201239          => 643566407,
#	35104476161        => 22071637057,
#	2176477521929      => 294289236153,
#	134941606358731    => 88879354792675,
#	8366379594239857   => 7275288500431249,
#	518715534842869223 => 280042546585394647
    my $self = {
	bits	=> $bits,
	base	=> new Math::Base::Convert(dec, $base),
	unbase	=> new Math::Base::Convert($base, dec),
	golden	=> \%golden_primes,
    };
    bless $self, $class;
}

1;

# package main;
# 
# my %x;
# my $ps = new Crypt::Pseudo(36);
# foreach my $n (0000 .. 99999)
# {
#     printf "%2d - ", $n;
#     my $hash = $ps->hash($n, 4);
#     print "$hash - ";
#     say $ps->unhash($hash);
#     $x{$hash} = $hash;
# }
# 
# say scalar keys %x;

