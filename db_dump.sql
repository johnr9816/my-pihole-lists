PRAGMA foreign_keys=OFF;
BEGIN TRANSACTION;
DROP TABLE IF EXISTS 'domainlist_by_group';
DROP TABLE IF EXISTS 'group';
DROP TABLE IF EXISTS 'domainlist';
DROP TABLE IF EXISTS 'adlist';
CREATE TABLE IF NOT EXISTS "group"
(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    enabled BOOLEAN NOT NULL DEFAULT 1,
    name TEXT UNIQUE NOT NULL,
    date_added INTEGER NOT NULL DEFAULT (cast(strftime('%s', 'now') as int)),
    date_modified INTEGER NOT NULL DEFAULT (cast(strftime('%s', 'now') as int)),
    description TEXT
);
INSERT INTO "group" VALUES(0,1,'Default',1719567478,1719567478,'The default group');
CREATE TABLE domainlist
(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    type INTEGER NOT NULL DEFAULT 0,
    domain TEXT NOT NULL,
    enabled BOOLEAN NOT NULL DEFAULT 1,
    date_added INTEGER NOT NULL DEFAULT (cast(strftime('%s', 'now') as int)),
    date_modified INTEGER NOT NULL DEFAULT (cast(strftime('%s', 'now') as int)),
    comment TEXT,
    UNIQUE(domain, type)
);
INSERT INTO domainlist VALUES(1,0,'mask.icloud.com',1,1719656330,1719656330,'Added from Audit Log');
CREATE TABLE adlist
(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    address TEXT UNIQUE NOT NULL,
    enabled BOOLEAN NOT NULL DEFAULT 1,
    date_added INTEGER NOT NULL DEFAULT (cast(strftime('%s', 'now') as int)),
    date_modified INTEGER NOT NULL DEFAULT (cast(strftime('%s', 'now') as int)),
    comment TEXT,
    date_updated INTEGER,
    number INTEGER NOT NULL DEFAULT 0,
    invalid_domains INTEGER NOT NULL DEFAULT 0,
    status INTEGER NOT NULL DEFAULT 0
);
INSERT INTO adlist VALUES(1,'https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts',1,1719567478,1719567478,'Migrated from /etc/pihole/adlists.list',1726386486,166335,1,1);
CREATE TABLE domainlist_by_group
(
    domainlist_id INTEGER NOT NULL REFERENCES domainlist (id),
    group_id INTEGER NOT NULL REFERENCES "group" (id),
    PRIMARY KEY (domainlist_id, group_id)
);
INSERT INTO domainlist_by_group(rowid,domainlist_id,group_id) VALUES(1,1,0);
COMMIT;
