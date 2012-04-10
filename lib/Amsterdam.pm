package Amsterdam;
use Dancer ':syntax';      # Controler
use Template;              # View
use Dancer::Plugin::DBIC;  # Model

our $VERSION = '0.1';

get '/' => sub {
    template 'amsterdam';
};

true;
