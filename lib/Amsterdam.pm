package Amsterdam;
use Dancer ':syntax';      # Controler
use Template;              # View

use Amsterdam::Meeting 'next_amsterdam_meeting';

our $VERSION = '0.1';

get '/' => sub {
    template 'amsterdam' => {
        title         => 'Amsterdam Perl Mongers',
        meeting_date  => next_amsterdam_meeting(),
        meeting_place => 'linghong.tt',
    };
};

get '/mailing_list' => sub {
    template 'amsterdam_mailing_list' => {
        title => 'Perl Mongers mailing list',
    };
};

true;
