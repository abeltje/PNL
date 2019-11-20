package Amsterdam;
use Dancer ':syntax';

use Amsterdam::Meeting 'next_amsterdam_meeting';

our $VERSION = '0.2';

get '/' => sub {
    template 'amsterdam' => {
        title         => 'Amsterdam Perl Mongers',
        meeting_date  => next_amsterdam_meeting(),
        meeting_place => 'mintlab.tt',
    };
};

get '/mailing_list' => sub {
    template 'amsterdam_mailing_list' => {
        title => 'Perl Mongers mailing list',
    };
};

# Voorkom 404 via redirect

get '/robots.txt' => sub {
    return redirect '/robots.txt';
};

get '/meetings/**' => sub {
    return redirect prefix;
};

1;
