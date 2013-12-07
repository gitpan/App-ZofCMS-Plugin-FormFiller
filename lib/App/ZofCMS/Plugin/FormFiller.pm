package App::ZofCMS::Plugin::FormFiller;

use warnings;
use strict;

our $VERSION = '0.0103';

sub new { bless {}, shift }

sub process {
    my ( $self, $template, $query, $config ) = @_;

    return
        unless $template->{plug_form_filler}
            or $config->conf->{plug_form_filler};

    my %conf = (
        %{ delete $config->conf->{plug_form_filler} || {} },
        %{ delete $template->{plug_form_filler}     || {} },
    );

    if ( ref $conf{params} eq 'ARRAY' ) {
        $conf{params} = {
            map +( $_ => $_ ), @{ $conf{params} }
        };
    }

    keys %{ $conf{params} };
    while ( my ( $t, $q ) = each %{ $conf{params} } ) {
        next
            unless defined $query->{$q}
                and length $query->{$q}
                and $query->{$q} ne $template->{t}{$t};

        $template->{t}{$t} = $query->{$q};
    }
}

1;
__END__

=encoding utf8

=head1 NAME

App::ZofCMS::Plugin::FormFiller - fill HTML form elements' values.

=head1 SYNOPSIS

In Main Config file or ZofCMS Template:

    plugins => [ qw/FormFiller/ ],
    plug_form_filler => {
        params => [ qw/nu_login nu_name nu_email nu_admin nu_aa nu_mm user/ ],
    },

=head1 DESCRIPTION

The module provides filling of form elements from C<{t}> ZofCMS Template special key or query
parameters if those are specified.

This documentation assumes you've read L<App::ZofCMS>, L<App::ZofCMS::Config> and
L<App::ZofCMS::Template>

=head1 MAIN CONFIG FILE AND ZofCMS TEMPLATE FIRST-LEVEL KEYS

=head2 C<plugins>

    plugins => [ qw/FormFiller/ ],

Your obviously need to specify the name of the plugin in C<plugins> arrayref for ZofCMS
to execute the plugin. However, you'll probably be using another plugin, such as
L<App::ZofCMS::Plugin::DBI> to fill the C<{t}> key first, thus don't forget to set
right priorities.

=head2 C<plug_form_filler>

    plug_form_filler => {
        params => [ qw/login name email/ ],
    },

    plug_form_filler => {
        params => {
             t_login    => 'query_login',
             t_name     => 'query_name',
             t_email    => 'query_email',
        },
    },

The C<plug_form_filler> takes a hashref as a value. The possible keys/values of that
hashref are as follows:

=head3 C<params>

    params => {
            t_login    => query_login,
            t_name     => query_name,
            t_email    => query_email,
    },

    params => [ qw/login name email/ ],
    # same as
    params => {
        login => 'login',
        name  => 'name',
        email => 'email',
    },

B<Mandatory>. The C<params> key takes either a hashref or an arrayref as a value. If the
value is an arrayref it will be converted to a hashref where keys and values are the same.
The keys of the hashref will be interpreted as keys in the C<{t}> ZofCMS Template special
key and values will be interpreted as names of query parameters.

The idea of the plugin is that if query parameter (one of the specified in the C<params>
hashref/arrayref) has some value that is different from the corresponding value
in the C<{t}> hashref, the plugin will put that value into the C<{t}> ZofCMS
Template hashref. This allows you to do, for example, the following: fetch preset values
from the database (using L<App::ZofCMS::Plugin::DBI> perhaps) and present them to the user,
if the user edits some fields you have have the preset values along with those changes made
by the user.

=head1 AUTHOR

'Zoffix, C<< <'zoffix at cpan.org'> >>
(L<http://zoffix.com/>, L<http://haslayout.net/>, L<http://zofdesign.com/>)

=head1 BUGS

Please report any bugs or feature requests to C<bug-app-zofcms-plugin-formfiller at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=App-ZofCMS-Plugin-FormFiller>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc App::ZofCMS::Plugin::FormFiller

You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=App-ZofCMS-Plugin-FormFiller>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/App-ZofCMS-Plugin-FormFiller>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/App-ZofCMS-Plugin-FormFiller>

=item * Search CPAN

L<http://search.cpan.org/dist/App-ZofCMS-Plugin-FormFiller>

=back

=head1 COPYRIGHT & LICENSE

Copyright 2008 'Zoffix, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.


=cut

