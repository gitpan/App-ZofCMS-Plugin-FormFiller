#!/usr/bin/env perl

use Test::More tests => 1;

BEGIN {
	use_ok( 'App::ZofCMS::Plugin::FormFiller' );
}

diag( "Testing App::ZofCMS::Plugin::FormFiller $App::ZofCMS::Plugin::FormFiller::VERSION, Perl $], $^X" );
