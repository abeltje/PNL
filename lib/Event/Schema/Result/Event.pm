use utf8;
package Event::Schema::Result::Event;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Event::Schema::Result::Event

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<events>

=cut

__PACKAGE__->table("events");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 event_year

  data_type: 'integer'
  is_nullable: 0

=head2 start_month

  data_type: 'integer'
  is_nullable: 1

=head2 start_day

  data_type: 'integer'
  is_nullable: 1

=head2 stop_month

  data_type: 'integer'
  is_nullable: 1

=head2 stop_day

  data_type: 'integer'
  is_nullable: 1

=head2 event_name

  data_type: 'text'
  is_nullable: 0

=head2 city

  data_type: 'text'
  is_nullable: 1

=head2 country

  data_type: 'text'
  is_nullable: 1

=head2 event_url

  data_type: 'text'
  is_nullable: 1

=head2 remark

  data_type: 'text'
  is_nullable: 1

=head2 tr_class

  data_type: 'text'
  is_nullable: 1

=head2 editor

  data_type: 'text'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "event_year",
  { data_type => "integer", is_nullable => 0 },
  "start_month",
  { data_type => "integer", is_nullable => 1 },
  "start_day",
  { data_type => "integer", is_nullable => 1 },
  "stop_month",
  { data_type => "integer", is_nullable => 1 },
  "stop_day",
  { data_type => "integer", is_nullable => 1 },
  "event_name",
  { data_type => "text", is_nullable => 0 },
  "city",
  { data_type => "text", is_nullable => 1 },
  "country",
  { data_type => "text", is_nullable => 1 },
  "event_url",
  { data_type => "text", is_nullable => 1 },
  "remark",
  { data_type => "text", is_nullable => 1 },
  "tr_class",
  { data_type => "text", is_nullable => 1 },
  "editor",
  { data_type => "text", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 UNIQUE CONSTRAINTS

=head2 C<event_year_event_name_unique>

=over 4

=item * L</event_year>

=item * L</event_name>

=back

=cut

__PACKAGE__->add_unique_constraint("event_year_event_name_unique", ["event_year", "event_name"]);


# Created by DBIx::Class::Schema::Loader v0.07024 @ 2012-06-03 16:20:16
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:Eww3WPXMw4fYZ+8cjR5tBQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
