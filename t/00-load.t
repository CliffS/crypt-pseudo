#!perl -T

use Test::More tests => 1;

BEGIN {
    use_ok( 'Crypt::Pseudo' ) || print "Bail out!\n";
}

diag( "Testing Crypt::Pseudo $Crypt::Pseudo::VERSION, Perl $], $^X" );
