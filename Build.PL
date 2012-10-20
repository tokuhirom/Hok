use strict;
use warnings;
use Module::Build;

my $build = Module::Build->new(
    license              => 'perl',
    dynamic_config       => 0,

    build_requires       => {
        'Test::More' => '0.98',
        'Test::Requires' => 0,
    },
    configure_requires   => { 'Module::Build' => '0.38' },
    requires             => {
        perl => '5.010001',
        'Exporter'                      => '0',
        'parent'                        => '0',
        'Term::ANSIColor' => 0,
        'TAP::Harness' => '2.03',
        'Class::Accessor::Lite' => 0,
        'Module::Load' => 0,
        'Class::Load' => 0,
        'Try::Tiny' => 0,
        'Data::Difflet' => 0,
    },

    no_index    => { 'directory' => [ 'inc' ] },
    name        => 'Hok',
    module_name => 'Hok',

    # script_files => [''],

    test_files => (-d '.git' || $ENV{RELEASE_TESTING}) ? 't/ xt/' : 't/',
    recursive_test_files => 1,
   
    create_readme  => 1,
    create_license => 1,
);
$build->create_build_script();
