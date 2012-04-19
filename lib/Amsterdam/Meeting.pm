package Amsterdam::Meeting;
use v5.10.0;
use warnings;
use strict;

use Time::Local;

use Exporter 'import';
our @EXPORT_OK = qw/next_amsterdam_meeting/;
our %EXPORT_TAGS = (all => [@EXPORT_OK]);

sub next_amsterdam_meeting {
    my $now = time();
    my @now = localtime($now);

    my $month = $now[4]; # 0..11
    my $year  = $now[5] + 1900;

    my $meeting = amsterdam_meeting_time($month, $year);
    if ($meeting < $now) {
        $month++;
        if ($month > 10) {
            $month = 0;
            $year++;
        }
        $meeting = amsterdam_meeting_time($month, $year);
    }

    return date_nl($meeting);
}

sub amsterdam_meeting_time {
    my ($month, $year) = @_;

    $month //= (localtime)[4];
    $year  //= (localtime)[5] + 1900;

    # get the weekday of the first of the month
    my $wday = (localtime timelocal 0, 0, 0, 1, $month, $year)[6];
    my $mday = ( (9 - $wday) % 7 ) + 1;

    # not on 1 jan, 1 or 5 may, 5 dec;
    if (   ($month == 0 && $mday == 1)
        or ($month == 4 && $mday == 1 && $year == 2012)
        or ($month == 4 && $mday == 5)
        or ($month == 11 && $mday == 5))
    {
        $mday += 7;
    }

    return timelocal(0, 0, 20, $mday, $month, $year);
}

sub date_nl {
    my ($stamp) = @_;
    my ($mday, $month, $year) = (localtime($stamp))[3, 4, 5];
    $year += 1900;

    my $month_name = [
        qw/
            januari februari maart april mei juni juli
            augustus september oktober november december
        /
    ]->[$month];

    return sprintf(
        "%d %s %d",
        $mday,
        $month_name,
        $year
    );
}

1;
