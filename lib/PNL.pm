package PNL;
use Dancer ':syntax';

our $VERSION = '0.1';

get '/' => sub {
    template 'index';
};

get '/about/' => sub {
    template 'about';
};

get '/news/' => sub {
    template 'news';
};

load_app 'Amsterdam', prefix => '/amsterdam';

get '/groningen/' => sub {
    template 'groningen';
};

get '/workshop/' => sub {
    template 'workshop';
};

get '/sppn/' => sub {
    template 'sppn';
};

get '/why/' => sub {
    template 'why';
};

true;
