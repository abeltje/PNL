package PNL;
use Dancer ':syntax';

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

prefix '/groningen';
get '/' => sub {
    template 'groningen' => {
        title => 'Groningen Perl Mongers',
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
