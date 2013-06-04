/*-------------------------------------------------------------------------------------------------
	Copyright: Mike Mitterer <office@mikemitterer.at>
	Generated for SQLite 

    Generated with Gradle TexenPlugin, BuildScript-Version: 1.0	
-------------------------------------------------------------------------------------------------*/
 

PRAGMA foreign_keys = ON;

/*-------------------------------------------------------------------------------------------------
-- CleanUp! 
-------------------------------------------------------------------------------------------------*/

DROP TABLE IF EXISTS test_db_names;

-- Shiro - start
DROP TABLE IF EXISTS userroles;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS roles;

DROP TRIGGER IF EXISTS onInsertUser;
DROP TRIGGER IF EXISTS onDeleteUser;
-- Shiro - end

/*-------------------------------------------------------------------------------------------------
-- Tabellen werden erstellt
-------------------------------------------------------------------------------------------------*/

CREATE TABLE test_db_names (
	ID 				INTEGER PRIMARY KEY AUTOINCREMENT,
	firstname      	VARCHAR(50) 	not null 
);
CREATE UNIQUE INDEX firstname on test_db_names(firstname);

-- Shiro - start
CREATE TABLE users (
	ID 				INTEGER PRIMARY KEY AUTOINCREMENT,
	username       	VARCHAR(255) 	not null /*REFERENCES userroles(username) ON DELETE CASCADE*/,
	password       	VARCHAR(255)	not null,
	salt       		VARCHAR(15)	not null,
	confirmationid  VARCHAR(15)	not null,
	confirmed       BOOLEAN	not null,
	restid       	VARCHAR(15)	not null/*,
	
	FOREIGN KEY(username) REFERENCES userroles(username)*/
);
-- DROP INDEX IF EXISTS username ;
CREATE UNIQUE INDEX username on users(username);

CREATE TABLE roles (
	ID				INTEGER PRIMARY KEY AUTOINCREMENT,
	role         	VARCHAR(10) not null/*,
	
	FOREIGN KEY(ID) REFERENCES userroles(roleid)*/
);
-- DROP INDEX IF EXISTS roleid ;
CREATE UNIQUE INDEX roleid on roles(ID);

-- roleid 4 = GUEST (Role.java)
CREATE TABLE userroles (
	username       	VARCHAR(255) not null PRIMARY KEY,
	roleid         	INTEGER DEFAULT 4 /*,
	
	FOREIGN KEY(username) REFERENCES users(username) ON DELETE CASCADE,
	FOREIGN KEY(roleid) REFERENCES roles(ID)*/
);
-- DROP INDEX IF EXISTS userrole ;
CREATE INDEX userrole on userroles(username);
-- Shiro - end

/*-------------------------------------------------------------------------------------------------
-- Trigger werden gesetzt (Nur für Shiro)
-------------------------------------------------------------------------------------------------*/



CREATE TRIGGER onInsertUser AFTER INSERT ON users 
FOR EACH ROW BEGIN
  REPLACE INTO userroles (username,roleid ) VALUES (NEW.username,(select id from roles where role = "GUEST"));
END ;

CREATE TRIGGER onDeleteUser AFTER DELETE ON users 
FOR EACH ROW BEGIN
	DELETE FROM userroles WHERE username = OLD.username;
END ;



/*-------------------------------------------------------------------------------------------------
-- Daten einfügen (test_db_names)
-------------------------------------------------------------------------------------------------*/

insert into test_db_names (firstname ) values ('Mike');
insert into test_db_names (firstname ) values ('Gerda');
insert into test_db_names (firstname ) values ('Sarah');
insert into test_db_names (firstname ) values ('Nicki');

insert into test_db_names (firstname ) values ('Angel/Archangel');
insert into test_db_names (firstname ) values ('Apocalypse');
insert into test_db_names (firstname ) values ('Bishop');
insert into test_db_names (firstname ) values ('Beast');
insert into test_db_names (firstname ) values ('Caliban');
insert into test_db_names (firstname ) values ('Colossus');
insert into test_db_names (firstname ) values ('Cyclops');
insert into test_db_names (firstname ) values ('Firestar');
insert into test_db_names (firstname ) values ('Emma Frost');
insert into test_db_names (firstname ) values ('Gambit');
insert into test_db_names (firstname ) values ('High Evolutionary');
insert into test_db_names (firstname ) values ('Dark Phoenix');
insert into test_db_names (firstname ) values ('Marvel Girl');
insert into test_db_names (firstname ) values ('Iceman');
insert into test_db_names (firstname ) values ('Juggernaut');
insert into test_db_names (firstname ) values ('Magneto');
insert into test_db_names (firstname ) values ('Minos');
insert into test_db_names (firstname ) values ('Mr. Sinister');
insert into test_db_names (firstname ) values ('Mystique');
insert into test_db_names (firstname ) values ('Nightcrawler');
insert into test_db_names (firstname ) values ('Professor X');
insert into test_db_names (firstname ) values ('Pyro');
insert into test_db_names (firstname ) values ('Psylocke');
insert into test_db_names (firstname ) values ('Rogue');
insert into test_db_names (firstname ) values ('Sabretooth');
insert into test_db_names (firstname ) values ('Shadowcat');
insert into test_db_names (firstname ) values ('Storm');
insert into test_db_names (firstname ) values ('Talker');
insert into test_db_names (firstname ) values ('Wolverine');
insert into test_db_names (firstname ) values ('X-23');

select ""; select "---- all test-names ----";
select * from test_db_names;

/*-------------------------------------------------------------------------------------------------
-- Daten einfügen (shiro)
-------------------------------------------------------------------------------------------------*/

-- Werte müssen mit den Einträgen in Role.java zusammenstimmen!
insert into roles (role )
	values ('ADMIN'); /* ID 1 */

insert into roles (role )
	values ('VIP'); /* ID 2 */
	
insert into roles (role )
	values ('USER'); /* ID 3 */
	
insert into roles (role )
	values ('GUEST'); /* ID 4 */

insert into users (username,password,salt,confirmationid,confirmed,restid) 
	/* PW: test123A# */
	/* Hased mit ./hashpw.sh */
	values ('admin@shiro.at', 'ZhmbMuXiAf5oTNvcopn6X7t/yTM1zCR73O/menRLQKA=','0123456789abcde','aabbccddeeff001',1,'edcba9876543210');

-- insert into userroles(username,roleid) values ('admin@shiro.at',(select id from roles where role = "GUEST"));
update userroles set roleid = 1 where username = "admin@shiro.at";

insert into users (username,password,salt,confirmationid,confirmed,restid) 
	/* PW: guest123B? */
	/* Hased mit ./hashpw.sh */
	values ('guest@shiro.at', 'ZhmbMuXiAf5oTNvcopn6X7t/yTM1zCR73O/menRLQKA=','0123456789abcde','aabbccddeeff002',1,'edcba9876543211');
-- insert into userroles(username,roleid) values ('guest@shiro.at',(select id from roles where role = "GUEST"));

insert into users (username,password,salt,confirmationid,confirmed,restid) 
	/* PW: guest123B? */
	/* Hased mit ./hashpw.sh */
	values ('guest2@shiro.at', 'ZhmbMuXiAf5oTNvcopn6X7t/yTM1zCR73O/menRLQKA=','0123456789abcde','aabbccddeeff002',1,'edcba9876543211');
-- insert into userroles(username,roleid) values ('guest2@shiro.at',(select id from roles where role = "GUEST"));

/*	
insert into userroles (username,roleid )
	values ('admin@shiro.at',1);

insert into userroles (username,roleid )
	values ('guest@shiro.at',4);
*/	
	
/*
 * Fehler - foreign key constraint failed
 delete from roles where role = "ADMIN";
 */

select ""; select "---- all users ----";
select * from users;

select ""; select "---- all roles ----";
select * from roles;

select ""; select "---- user with its role ----";
select users.username,roles.role from users,roles,userroles 
	where users.username=userroles.username 
	and userroles.roleid=roles.id;
	
delete from users where username = "guest@shiro.at";
delete from users where username = "guest2@shiro.at";

select ""; select "---- all users (2 were deleted) ----";
select * from users;

select ""; select "---- user with its role (only admin...) ----";
select users.username,roles.role from users,roles,userroles 
	where users.username=userroles.username 
	and userroles.roleid=roles.id;

select ""; select "---- userroles ----";
select * from userroles;

