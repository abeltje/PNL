#!/bin/sh

set -x

DBDIR=/var/db/PNL
LIBDIR="dump_directory=../../lib"

sqlite3 $DBDIR/eventdb < event.sqlite
dbicdump -o $LIBDIR Event::Schema dbi:SQLite:$DBDIR/eventdb
