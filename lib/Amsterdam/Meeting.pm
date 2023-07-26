package Amsterdam::Meeting;
use 5.01000;
use warnings;
use strict;

=head1 NAME

Amsterdam::Meeting - Bereken de datum van de volgende Amsterdam.pm meeting

=head1 SYNOPSIS

    use Amsterdam::Meeting ':all';
    printf "Volgende meeting in Amsterdam: %s\n", next_amsterdam_meeting();

=head1 DESCRIPTION

Meetings worden gehouden op de eerste dinsdag van de maand, met uitzondering
van:

=over

=item B<1 januari> wordt 8 januari

=item B<5 mei> wordt 12 mei

=item B<5 december> wordt 12 december

=back

Daarnaast zullen er jaarlijks uitzonderingen zijn:

=over

=item 1 mei 2012 => 8 mei 2012

=back

=cut

use Exporter 'import';
our @EXPORT_OK = qw/
    next_amsterdam_meeting
    amsterdam_meeting_time
    is_amsterdam_announce
/;
our %EXPORT_TAGS = (all => [@EXPORT_OK]);

use Time::Local;
use POSIX qw< setlocale LC_TIME strftime >;

=head2 my $datumstring = next_amsterdam_meeting()

=head3 Argumenten

Geen.

=head3 Retour

Een datumstring met de maand in het Nederlands (strftime "%e %B %Y").

=cut

sub next_amsterdam_meeting {
    my ($lang) = @_;
    $lang //= 'nl';

    my $next_amsterdam_meeting = next_amsterdam_meeting_time();
    return $lang eq 'en'
        ? date_en($next_amsterdam_meeting)
        : date_nl($next_amsterdam_meeting);
}

=head2 my $stamp = next_amsterdam_meeting_time()

=head3 Argumenten

Geen.

=head3 Retour

Een timestamp.

=cut

sub next_amsterdam_meeting_time {
    my $now = time();
    my @now = localtime($now);

    my $month = $now[4]; # 0..11
    my $year  = $now[5] + 1900;

    my $meeting = amsterdam_meeting_time($month, $year);
    if ($meeting < $now) {
        $month++;
        if ($month > 11) {
            $month = 0;
            $year++;
        }
        $meeting = amsterdam_meeting_time($month, $year);
    }

    return $meeting;
}

=head2 my $stamp = amsterdam_meeting_time(@argumenten)

=head3 Argumenten

Positioneel.

=over

=item $maand <0..11>

=item $jaar

=back

=head3 Retour

Een timestamp.

=cut

sub amsterdam_meeting_time {
    my ($month, $year) = @_;

    $month //= (localtime time())[4];
    $year  //= (localtime time())[5] + 1900;

    # get the weekday of the first of the month
    my $wday = (localtime timelocal 0, 0, 0, 1, $month, $year)[6];
    my $mday = ( (9 - $wday) % 7 ) + 1;

    # not on 1 jan, 1 or 5 may, 5 dec;
    if (   ($month == 0 && $mday == 1)
        or ($month == 4 && $mday == 1 && $year == 2012)
        or ($month == 4 && $mday == 5)
        or ($month == 11 && $mday == 5)
        or ($year == 2019 && $month == 2) # German Perl Workshop 2019
        or ($year == 2019 && $month == 7) # PerlCon 7-9 aug 2019
        or ($year == 2019 && $month == 8) # Uitzondering ???
    )
    {
        $mday += 7;
    }

    return timelocal(0, 0, 20, $mday, $month, $year);
}

=head2 my $boolean = is_amsterdam_announce()

=cut

sub is_amsterdam_announce {
    my $week_before = next_amsterdam_meeting_time() - 7 * 24 * 60 * 60;
    return $week_before == timelocal(0, 0, 20, (localtime time())[3, 4, 5]);
}

=head2 my $datum = date_nl($stamp)

=head3 Argumenten

Positioneel.

=over

=item $timestamp

=back

=head3 Retour

Een datumstring met de maand in het Nederlands.

=cut

sub date_nl {
    my ($stamp) = @_;

    my $old_locale = setlocale(LC_TIME, 'nl_NL');
    my $date_string = strftime("%e %B %Y", localtime($stamp));
    setlocale(LC_TIME, $old_locale);

    $date_string =~ s{^ \s* }{}x;
    return $date_string;
}

=head2 my $date = date_en($stamp)

=head3 Argumenten

Positioneel.

=over

=item $timestamp

=back

=head3 Retour

Een datumstring met de maand in het Engels (Brits).

=cut

sub date_en {
    my ($stamp) = @_;

    my $old_locale = setlocale(LC_TIME, 'en_GB');
    my $date_string = strftime("%e %B %Y", localtime($stamp));
    setlocale(LC_TIME, $old_locale);

    $date_string =~ s{^ \s* }{}x;
    return $date_string;
}

1;

=head1 STUFF

(c) MMIX - MMXVIII Abe Timmerman <abeltje@cpan.org>

=cut
