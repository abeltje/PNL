package PNL;
use Dancer ':syntax';

our $VERSION = '0.1';

get '/' => sub {
    template 'index';
};

get '/about/' => sub {
    template 'about' => {
        title => 'Over Perl',
    };
};

get '/news/' => sub {
    template 'news' => {
        title => 'Perl Nieuws',
    };
};

load_app 'Amsterdam', prefix => '/amsterdam';

get '/groningen/' => sub {
    template 'groningen' => {
        title => 'Groningen Perl Mongers',
    };
};

get '/workshop/' => sub {
    template 'workshop' => {
        title => 'Nederlandse Perl Workshop',
    };
};

get '/sppn/' => sub {
    template 'sppn' => {
        title => 'Stichting Perl Promotie Nederland',
    };
};

get '/why/' => sub {
    template 'why' => {
        title => 'Waarom Perl',
    };
};

true;
