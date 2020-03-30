use Test::More tests => 2;
use strict;
use warnings;

use Cwd 'abs_path';
BEGIN { $ENV{DANCER_APPDIR} = abs_path('.'); }

# the order is important
use PNL;
use Dancer::Test;

route_exists [GET => '/'], 'a route handler is defined for /';
my $response = dancer_response(GET => '/');
is($response->status, 200, 'response status is 200 for /')
    or diag(explain($response));
