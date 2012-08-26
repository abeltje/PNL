use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'PNL',
    AUTHOR              => q{Henk van Oers <hvo.pm@xs4all.nl>},
    VERSION_FROM        => 'lib/PNL.pm',
    ABSTRACT            => 'PERL.NL site',
    ($ExtUtils::MakeMaker::VERSION >= 6.3002
      ? ('LICENSE'=> 'perl')
      : ()),
    PL_FILES            => {},
    PREREQ_PM => {
        'Test::More' => 0,
        'YAML'       => 0,
        'Dancer'     => 1.3091,
        'Template'   => 2.23,
        'DBIx::Class::Schema::Loader' => 0.07022,
        'Dancer::Plugin::DBIC'        => 0.1504,
        'Dancer::Plugin::Passphrase'  => 1,
        'Data::Peek'                  => 0.38,
        'Dancer::Debug'               => 0.03,
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'PNL-*' },
);
