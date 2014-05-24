Crypt-Pseudo
============

Short, reversable, alphanumeric pseudohash with hard-to-guess sequence.

This is the initial import.  The code was ported from the PHP
at <http://blog.kevburnsjr.com/php-unique-hash>.

Using the defaults of 62 bits and a string length of 5,
the maximum number that can be encrypted is 916,132,831.

With 32 bits (lower case only) the maximum for 5 characters 
is 60,466,175.

With 32 bits and a 6 character string, the maximum is 2,176,782,335.

    my $pseudo = new Crypt::Pseudo([$bits]);

Bits can be 36 (lower case) or 62 (upper and lower case).  Default
is 62.

    my $crypt = $pseudo->hash($value [, $length]);

Length is the length of the returned string. Defaults to 5.

    my $decrypted = $pseudo->unhash($crypt);

