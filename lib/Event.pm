package Event;
use Dancer ':syntax';
use Dancer::Plugin::DBIC 'schema';

our $VERSION = '0.1';

get '/' => sub {
    my @events = schema('EV')->resultset('Event')->search(
        undef,
        { order_by => { -asc => [qw<event_year start_month start_day>] },
        }
    );
    template 'events' => {
        lang => 'en',
        title => 'Events',
        events => \@events,
    };
};
    
true;
