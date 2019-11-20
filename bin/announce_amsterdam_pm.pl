#! /usr/bin/perl
use warnings;
use strict;

use FindBin;
use lib "$FindBin::Bin/../lib";
use Amsterdam::Meeting ':all';
use MIME::Lite;
use Getopt::Long;
my %opt = (
    production => 0,
    force => 0,
    place => 'mintlab',
    from_sender => 'abeltje@test-smoke.org',
    email_from  => 'Perl NL <abeltje@test-smoke.org>',
);
GetOptions \%opt => qw/
    production|p
    force|f
    place=s
    from_sender|from-sender=s
    email_from|email-from=s
/;

my %amsterdam_place = (
    linghong => {
        name   => 'Restaurant Ling Hong',
        street => 'Ouddiemerlaan 15',
        place  => 'Diemen',
        url    => 'http://www.eet.nu/diemen/ling-hong',
    },
    techinc => {
        name   => 'Technologia Incognita',
        street => 'Louwesweg 1',
        place  => 'Amsterdam',
        url    => 'http://www.techinc.nl',
    },
    mintlab => {
        name   => 'Mintlab',
        street => 'HJE Wenkenbachweg 90',
        place  => 'Amsterdam-Duivendrecht',
        url    => 'https://www.mintlab.nl',
    },
);

if (not exists $amsterdam_place{ $opt{place} }) {
    die "Onbekende plaats voor bijeenkomst: $opt{place}\n";
}

if ( $opt{force} || is_amsterdam_announce() ) {
    send_email( $amsterdam_place{$opt{place}} )
}


sub send_email {
    my ($place) = @_;
    my @args = (
        next_amsterdam_meeting(),
        $place->{name},
        $place->{street},
        $place->{place},
        $place->{url},
        $place->{name},
        next_amsterdam_meeting(),
        $place->{name},
        $place->{street},
        $place->{place},
        $place->{url},
        $place->{name},
    );
    my $body = sprintf(<<'    EOM', @args);
[English version follows the dutch text]

Amsterdam.pm staat voor de "Amsterdamse Perl Mongers", een groep van
gebruikers van Perl. In tegenstelling tot wat de naam suggereert is
Amsterdam.pm niet beperkt tot alleen Amsterdam, maar functioneert ook
als de algemene Nederlandse gebruikersgroep. Iedereen die gelegenheid
heeft is welkom, ook al bent u al bij Alphen.pm, Nijmegen.pm,
Rotterdam.pm, Echt.pm, Exloo.pm, Groningen.pm of Wageningen.pm op
bezoek geweest.

Amsterdam.pm organiseert informele bijeenkomsten waar Perl gebruikers
kunnen samenkomen en informatie en gebruikservaringen met betrekking
tot Perl kunnen uitwisselen.

De bijeenkomsten vinden normaliter plaats op elke eerste dinsdag van
de maand. Zoals gebruikelijk voor dit soort bijeenkomsten is er ook
hier gelegenheid tot CAcert certificering en het uitwisselen van PGP
keys. De voertaal binnen Amsterdam.pm is in principe Nederlands, maar
indien nodig zal Engels worden gebruikt, b.v. om te communiceren met
niet-Nederlandssprekende aanwezigen.

De eerstvolgende bijeenkomst vindt plaats op dinsdag %s van
20:00 tot 22:30 uur bij %s, %s, %s.
Zie %s voor details.

Liefhebbers van een etentje vooraf kunnen reeds tussen 18:00 en 18:30
naar %s komen om een hapje te eten.

Bezoek onze Web site http://perl.nl/amsterdam voor meer details.

[English version]

Amsterdam.pm stands for the Amsterdam Perl Mongers. We're basically a
Perl user group. Despite its name, it is not local to the Amsterdam
environment, but it welcomes Perl mongers from all over the
Netherlands.

Amsterdam.pm organises informal meetings where Perl users can meet,
and exchange information and experiences with regard to using Perl.

The meetings are normally held every first Tuesday of the month. As
conventional for these kind of meetings, there is also an opportunity
to get CAcert certified, and to exchange PGP keys. Although the
preferred language for communication is Dutch, English will be spoken
if necessary.

Our next meeting is Tuesday, %s, from 20:00 till 22:30 at the
%s, %s, %s.
See %s for a description.

If you want to join some of us for dinner, please gather between 18:00
and 18:30 at %s.

See http://perl.nl/amsterdam for more details.
-- 
    EOM

    my %address = (
        To => 'abe.timmerman@xs4all.nl',
        Cc => [
            'abeltje@gmail.com',
        ],
    );
    if ($opt{production}) {
        %address = (
            To => 'nl-pm@amsterdam.pm.org',
#            Cc => [
#                'groningen-pm@pm.org',
#            ],
        );
    }
    MIME::Lite->send('sendmail', FromSender => $opt{from_sender});
    my $msg = MIME::Lite->new(
        Subject => 'Bijeenkomst Amsterdam Perl Mongers, dinsdag '
            . next_amsterdam_meeting(),
        From => $opt{email_from},
        %address,
        Data => $body,
    );

    $msg->send();
}
