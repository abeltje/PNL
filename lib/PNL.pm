package PNL;
use Dancer ':syntax';
use Dancer::Plugin::DBIC 'schema';

our $VERSION = '0.1';

get '/' => sub {
    template 'index';
};

prefix '/about';
get '/' => sub {
    template 'about' => {
        title => 'Over Perl',
    };
};

prefix '/news';
get '/' => sub {
    template 'news' => {
        title => 'Perl Nieuws',
    };
};

load_app 'Amsterdam', prefix => '/amsterdam';
load_app 'Event', prefix => '/events';

prefix '/groningen';
get '/' => sub {
    template 'groningen' => {
        title => 'Groningen Perl Mongers',
    };
};
get '/mailing_list' => sub {
    template 'groningen_mailing_list' => {
        title => 'Groningen Perl Mongers mailing list',
    };
};

prefix '/workshop';
get '/' => sub {
    template 'workshop' => {
        title => 'Nederlandse Perl Workshop',
    };
};

prefix '/sppn';
get '/' => sub {
    template 'sppn' => {
        title => 'Stichting Perl Promotie Nederland',
    };
};

prefix '/why';
get '/' => sub {
    template 'why' => {
        title => 'Waarom Perl',
    };
};

if (config->{environment} eq 'development') {
    load_app 'Peek', prefix => '/peek';
};
    
true;
