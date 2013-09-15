use 5.006;
use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'Crypt::Pseudo',
    AUTHOR              => q{Cliff Stanford <cpan@may.be>},
    VERSION_FROM        => 'lib/Crypt/Pseudo.pm',
    ABSTRACT_FROM       => 'lib/Crypt/Pseudo.pm',
    ($ExtUtils::MakeMaker::VERSION >= 6.3002
      ? ('LICENSE'=> 'perl')
      : ()),
    PL_FILES            => {},
    PREREQ_PM => {
        'Test::More' => 0,
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'Crypt-Pseudo-*' },
);
