package Amsterdam;
use Dancer ':syntax';      # Controler
use Template;              # View
use Dancer::Plugin::DBIC;  # Model

use I18N::LangTags::List;  # languages

our $VERSION = '0.1';

get '/' => sub {
    template 'index';
};

true;
