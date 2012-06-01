package PNL;
use Dancer ':syntax';
use Data::Peek;

our $VERSION = '0.1';

get '/' => sub {
    template 'peek';
};

# let's peek under the hood
sub reveal {
   my $data = DDumper($_[1]);
   template 'peek', {
       what => $_[0],
       data => $data,
       extra_navi => 'peek_navi.tt',
    };
};

get '/ENV' => sub {
    reveal('ENV', \%ENV);
};

get '/INC' => sub {
    reveal('INC', \%INC);
};

get '/request' => sub {
    my $req  = request;
    reveal('request', \$req);
};

get '/session' => sub {
    my $ses  = session;
    reveal('session', \$ses);
};

get '/vars' => sub {
    my $vars = vars;
    reveal('vars', \$vars);
};

get '/cookies' => sub {
    my $cook = cookies;
    reveal('cookies', \$cook);
};

get '/config' => sub {
    my $conf = config;
    reveal('config', \$conf);
};

true;
