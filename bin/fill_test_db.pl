#!/usr/bin/perl

#
# This script was initialy used to fill the db
# used by the test with test data.
#

use strict;
use warnings;

use DBI;

my $db = '../t/lexicon.db';

die "SQLite database $db not found: $!" unless -f $db;

my $dbh = DBI->connect("dbi:SQLite:dbname=$db", "", "", { AutoCommit => 1, PrintError => 0, });

my @lexicon = (
               { id => 1, lex => '*',   lang => 'de', key => 'Hello World!',    value => 'Hallo Welt!', },
               { id => 2, lex => '*',   lang => 'en', key => 'Hello World!',    value => 'Hello World!', },
               { id => 3, lex => '*',   lang => 'de', key => 'This is a [_1].', value => 'Dies ist ein [_1].', },
               { id => 4, lex => '*',   lang => 'en', key => 'This is a [_1].', value => 'This is a [_1].', },
               { id => 5, lex => 'foo', lang => 'de', key => 'Lex Foo',         value => 'Lexikon "foo", de', },
               { id => 6, lex => 'foo', lang => 'en', key => 'Lex Foo',         value => 'Lexicon "foo", en', },
              );

$dbh->do("DELETE FROM `lexicon`;");

foreach (@lexicon) {
    $dbh->do(  "INSERT INTO `lexicon` (`id`, `lang`, `lex`, `key`, `value`) VALUES ('"
             . $_->{id} . "', '"
             . $_->{lang} . "', '"
             . $_->{lex} . "', '"
             . $_->{key} . "', '"
             . $_->{value}
             . "');");

    if ($dbh->err()) { die "$DBI::errstr\n"; }
}

$dbh->disconnect();
