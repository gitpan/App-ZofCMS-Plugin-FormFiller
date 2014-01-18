use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'App::ZofCMS::Plugin::FormFiller',
    license             => 'perl',
    dist_author         => q|Zoffix <'zoffix@cpan.org'>|,
    dist_version_from   => 'lib/App/ZofCMS/Plugin/FormFiller.pm',
    build_recommends => {
        'App::ZofCMS::Test::Plugin' => 0.0104,
    },
    build_requires => {
        'Test::More' => 0,
    },
    requires => {
        'perl' => '5.006',
    },
    configure_requires => { 'Module::Build' => 0 },
    add_to_cleanup      => [ 'App-ZofCMS-Plugin-FormFiller-*' ],
    create_makefile_pl => 'traditional',
);
if ( $ENV{RELEASE_TESTING} ) {
    system('pod2text lib/App/ZofCMS/Plugin/FormFiller.pm > README');
}

$builder->create_build_script();
