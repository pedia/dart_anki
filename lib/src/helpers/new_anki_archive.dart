import 'dart:io';

import 'package:dart_anki/src/models/anki_archive.dart';
import 'package:dart_anki/src/models/card.dart';
import 'package:dart_anki/src/models/resource.dart';
import 'package:sqlite3/sqlite3.dart';

AnkiArchive new_anki_archive() {
  final tempDir = Directory.systemTemp.createTempSync();
  final resources = <Resource>[];
  final cards = <Card>[];

  File(tempDir.path + '/media').create();

  final db = sqlite3.open(tempDir.path + '/collection.anki2');

  // Initiallize the database
  db.execute('''
  CREATE TABLE cards (
    id              integer primary key,
    nid             integer not null,--    
    did             integer not null,
    ord             integer not null,
    mod             integer not null,
    usn             integer not null,
    type            integer not null,
    queue           integer not null,
    due             integer not null,
    ivl             integer not null,
    factor          integer not null,
    reps            integer not null,
    lapses          integer not null,
    left            integer not null,
    odue            integer not null,
    odid            integer not null,
    flags           integer not null,
    data            text not nul
);

CREATE TABLE col (
    id              integer primary key,
    crt             integer not null,
    mod             integer not null,
    scm             integer not null,
    ver             integer not null,
    dty             integer not null,
    usn             integer not null,
    ls              integer not null,
    conf            text not null,
    models          text not null,
    decks           text not null,
    dconf           text not null,
    tags            text not null
);

CREATE TABLE graves (
    usn             integer not null,
    oid             integer not null,
    type            integer not null
);

CREATE TABLE notes (
    id              integer primary key,
    guid            text not null,
    mid             integer not null,
    mod             integer not null,
    usn             integer not null,
    tags            text not null,
    flds            text not null,
    sfld            integer not null,
    csum            integer not null,
    flags           integer not null,
    data            text not null
);

CREATE TABLE revlog (
    id              integer primary key,
    cid             integer not null,
    usn             integer not null,
    ease            integer not null,
    ivl             integer not null,
    lastIvl         integer not null,
    factor          integer not null,
    time            integer not null,
    type            integer not null
);


CREATE INDEX ix_cards_nid on cards (nid);
CREATE INDEX ix_cards_sched on cards (did, queue, due);
CREATE INDEX ix_cards_usn on cards (usn);
CREATE INDEX ix_notes_csum on notes (csum);
CREATE INDEX ix_notes_usn on notes (usn);
CREATE INDEX ix_revlog_cid on revlog (cid);
CREATE INDEX ix_revlog_usn on revlog (usn);
  ''');

  return AnkiArchive(
      tempDir: tempDir, db: db, cards: cards, resources: resources);
}
