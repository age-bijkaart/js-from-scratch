# A database system with a javascript (node.js) interface

There are several alternatives. The most popular seems to be [mongodb](https://docs.mongodb.com/manual/). 
See the [introduction](https://docs.mongodb.com/getting-started/node/) for the 
[node.js](https://nodejs.org/) interface.

## Mongodb 
Mongodb is a so-called [NoSql](https://en.wikipedia.org/wiki/NoSQL) system, which basically means that you
cannot use [SQL](https://en.wikipedia.org/wiki/SQL)
to query and manipulate the database.

A Mongodb database consists of collections, roughly the equivalen of tables in a traditional
database system. A collection contains documents, which would be like traditional rows, except that
they can have a complex structure with any number of data types.

The following fragment from [the introduction](https://docs.mongodb.com/getting-started/node/insert/)
shows how such a complex object can be inserted in a database.

``` javascript
var MongoClient = require('mongodb').MongoClient;
var assert = require('assert');
var ObjectId = require('mongodb').ObjectID;
var url = 'mongodb://localhost:27017/test';
/* Insert a Document
 *
 * Insert a document into a collection named restaurants. 
 * The operation will create the collection if the collection does not currently exist. 
 * 
 * Defines a function insertDocument:
 */
var insertDocument = function(db, callback) {
   db.collection('restaurants').insertOne( {
      "address" : {
         "street" : "2 Avenue",
         "zipcode" : "10075",
         "building" : "1480",
         "coord" : [ -73.9557413, 40.7720266 ]
      },
      "borough" : "Manhattan",
      "cuisine" : "Italian",
      "grades" : [
         {
            "date" : new Date("2014-10-01T00:00:00Z"),
            "grade" : "A",
            "score" : 11
         },
         {
            "date" : new Date("2014-01-16T00:00:00Z"),
            "grade" : "B",
            "score" : 17
         }
      ],
      "name" : "Vella",
      "restaurant_id" : "41704620"
   }, function(err, result) {
    assert.equal(err, null);
    console.log("Inserted a document into the restaurants collection.");
    callback();
  });
};

/* Call the insert function after establishing a connection. */
MongoClient.connect(url, function(err, db) { 
  assert.equal(null, err);
  insertDocument(db, function() { db.close(); });
  });
```
Note that the result of an operation can be obtained using a callback `function (err,db)` where, as
in most mongodb interface functions, the first argument represents the presence of an error, if not
null, and the second argument the result. In this case, simply the database object.

If the callback parameter is omitted, the database manipulation function usually returns a 
[Promise](https://www.promisejs.org/). [Here](http://www.html5rocks.com/en/tutorials/es6/promises/#toc-promisifying-xmlhttprequest) is a nice read on promises.

Here's an example of a query from
this [tutorial](https://mongodb.github.io/node-mongodb-native/2.2/tutorials/crud/)
``` javascript

var MongoClient = require('mongodb').MongoClient
 , assert = require('assert');

// Connection URL
var url = 'mongodb://localhost:27017/myproject';
// Use connect method to connect to the Server
MongoClient.connect(url, function(err, db) {
  assert.equal(null, err);
  console.log("Connected correctly to server");

  var col = db.collection('find');
  // Insert a single document
  col.insertMany([{a:1}, {a:1}, {a:1}], function(err, r) {
    assert.equal(null, err);
    assert.equal(3, r.insertedCount);

    // Get first two documents that match the query
    col.find({a:1}).limit(2).toArray(function(err, docs) {
      assert.equal(null, err);
      assert.equal(2, docs.length);
      db.close();
    });
  });
});
```

What makes mongodb unsuitable is that only single document inserts are atomic and there is not support
for [transactions](https://en.wikipedia.org/wiki/Database_transaction). While mongodb has other
impressive features (spreading data over several servers, higher speed retrieval of complex objecte
etc.), the lack of transactions makes it unsuitable for the kind of application that is envisaged.

On a side note, there is another widely used javascript/node.js interface library for mongodb, called
[mongoose](http://mongoosejs.com/) which supports an 'object modeling' layer on top of mongodb, as
shown in the following example from [here](http://mongoosejs.com/):
``` javascript
var mongoose = require('mongoose');
mongoose.connect('mongodb://localhost/test');

var Cat = mongoose.model('Cat', { name: String });

var kitty = new Cat({ name: 'Zildjian' });
kitty.save(function (err) {
  if (err) {
    console.log(err);
  } else {
    console.log('meow');
  }
});
```

## Progresql

[Postgresql](https://www.postgresql.org/) is a venerable [relational database](https://en.wikipedia.org/wiki/Relational_database) system that is still being actively developed. It has excellent support for [ACID](https://en.wikipedia.org/wiki/ACID) [transactions](https://en.wikipedia.org/wiki/Database_transaction). Moreover, it supports 
[JSON](http://www.json.org/)
[datatypes](https://www.postgresql.org/docs/9.4/static/datatype-json.html) as well as large [binary](https://www.postgresql.org/docs/current/static/largeobjects.html) or [text](https://www.postgresql.org/docs/8.4/static/datatype-character.html) objects.

There are excellent alternative open source relational database systems, such as
[Mysql](https://www.mysql.com/) and [MariaDb](https://mariadb.org/) but I did not immediately find an
attractive javascript/node.js interface, at least for Mysql.

For [Postgresql](https://www.postgresql.org/), on the other hand, there is a
[promise](https://www.promisejs.org/)-based node.js/javascript interface, called
[pg-promise](https://github.com/vitaly-t/pg-promise) which is another
layer on the basic interface [node-postgres](https://github.com/brianc/node-postgres).

### Installation

Just typing 'make' will
- install and start Postgresql if not already installed 
- create a new Postgresql user and a database of the same name
- create an 'accounts' table which contains a 'password' column that
  will contain [salted hashed
  passwords](http://www.meetspaceapp.com/2016/04/12/passwords-postgresql-pgcrypto.html)
- do some simple 'register' and login tests using bash scripts.

After 'make', the directory will contain a number of more or less useful *bash* scripts:
- [install-pg](./install-pg.sh) install version 9.5.3 of Postgresql
- [uninstall-pg](./uninstall-pg.sh) completely remove the Postgresql installation
- [pg-listdbs](./pg-listdbs.sh) list the databases in the cluster (see below)
- [pg-listusers](./pg-listusers.sh) lists the Postgresql users
- [pg-adduser name passwd](./pg-adduser.sh) add a Linux and a Postgresql user and a database, all of the same name (the passwd parameter is only used for the Linux user)
- [pg-deluser name](./pg-deluser.sh) remove the user (from both Linux and Postgresql) and the corresponding database
- [pg-start](./pg-start.sh), [pg-stop](./pg-stop.sh), [pg-status](./pg-status.sh): (re)start, stop and show status of
  the Postgresql server
- [ddl](./ddl.sh) create the accounts table and enable the
  [pgcrypto](http://www.meetspaceapp.com/2016/04/12/passwords-postgresql-pgcrypto.html) module.

Installing *postgresql* can be done using the 'install-pg' script or by typing `make pg`. This also
starts the server wich a default
[cluster](https://www.postgresql.org/docs/9.5/static/creating-cluster.html) at: `/var/lib/postgresql/9.5/main`.

```
postgres  5454     1  0 15:26 ?        00:00:00 /usr/lib/postgresql/9.5/bin/postgres -D
  /var/lib/postgresql/9.5/main -c config_file=/etc/postgresql/9.5/main/postgresql.conf
postgres  5456  5454  0 15:26 ?        00:00:00 postgres: checkpointer process   
postgres  5457  5454  0 15:26 ?        00:00:00 postgres: writer process   
postgres  5458  5454  0 15:26 ?        00:00:00 postgres: wal writer process   
postgres  5459  5454  0 15:26 ?        00:00:00 postgres: autovacuum launcher process   
postgres  5460  5454  0 15:26 ?        00:00:00 postgres: stats collector process   
```

From [here](http://www.postgresqlforbeginners.com/2010/11/interacting-with-postgresql-psql.html):

> A running database server corresponds with a storage area, called a *cluster*, and a cluster can
> contain several *databases*. 

From the [docs](https://www.postgresql.org/docs/current/static/creating-cluster.html):

> A database cluster is a collection of databases that is managed by a single instance of a running
> database server. After initialization, a database cluster will contain a database named postgres,
> which is meant as a default database for use by utilities, users and third party applications. The
> database server itself does not require the postgres database to exist, but many external utility
> programs assume it exists


Creating a database in the cluster is easy. Note that you have to be *postgres superuser* to be
permitted to issue this command (and the same for *dropdb*, naturally). 
```
sudo -u postgres createdb test
```

*Postgres* is a normal Linux user (but a superuser for the database system) that was created during the installation: ``grep postgres /etc/passwd`` yields:

```
postgres:x:123:131:PostgreSQL administrator,,,:/var/lib/postgresql:/bin/bash
```

Just as for Linux, it is not a good idea to be superuser all the time. Thus we create a new user. It will be a Linux user to allow local (i.e. not via the network but via Unix sockets) logins:

``` bash
sudo useradd js
sudo passwd js
sudo -u postgres createuser --createdb js
```
where *--createdb* allows the new user to create his own databases. 

The script [pg-adduser](./pg-adduser.sh) does all this (create Linux and Postgres user)
and creates a database of the same name as the new user.

```
./pg-useradd js js
sudo -u postgres psql --command="\l"
```
which provides us with the list of databases in the cluster:
<pre>
                                  List of databases
   Name    |  Owner   | Encoding |   Collate   |    Ctype    |   Access privileges   
-----------+----------+----------+-------------+-------------+-----------------------
 js        | js       | UTF8     | en_US.UTF-8 | en_US.UTF-8 | 
 postgres  | postgres | UTF8     | en_US.UTF-8 | en_US.UTF-8 | 
 template0 | postgres | UTF8     | en_US.UTF-8 | en_US.UTF-8 | =c/postgres          +
           |          |          |             |             | postgres=CTc/postgres
 template1 | postgres | UTF8     | en_US.UTF-8 | en_US.UTF-8 | =c/postgres          +
           |          |          |             |             | postgres=CTc/postgres
(4 rows)
</pre>

And we can login as user 'js', provided we connect to her database.

```
me@server$ sudo -u js psql --dbname=js
psql (9.5.3)
Type "help" for help.

js=> 

```

Note that without the *sudo*, we cannot connect as postgres user *js* to the *js* database:
```
me@server$ psql --username=js --dbname=js
psql: FATAL:  Peer authentication failed for user "js"
```

See  [this stackoverflow page](https://stackoverflow.com/questions/17443379/psql-fatal-peer-authentication-failed-for-user-dev) for a discussion of the problem. Here we adopted a simpler solutino by having a local Linux user corresponding to each Postgresql user. 

### Defining an accounts table

This is done by the [ddl](./ddl.sh) script (DDL stands for "data definition language") which is
reproduced below. The comments should clarify things.
``` bash
#!/bin/bash
# See [here](http://www.meetspaceapp.com/2016/04/12/passwords-postgresql-pgcrypto.html)
# for a good and short explanation for the need of pgcrypto.

# The name of the linux/postgres user is the same as the name of her
# database.
USER=js
PASS=${USER}
DB=${USER}

# Verify that the ${USER} (and her database) exist, otherwise create
# ${USER} and her DB
X=$(./pg-listusers | grep ${USER} | awk '{print $1;}')
[ "${X}" = ${USER} ]  || ./pg-adduser ${USER} ${PASS} || exit $?

# See
# [here](https://www.postgresql.org/docs/current/static/client-authentication.html)
# and /etc/postgresql/9.5/main/pg_hba.conf for figuring out why the
# following does not work.  
#
#    PGPASSWORD=${USER}-password psql --username=${USER} --dbname=${DB}
#
# However, it seems that we can use 'ident' authentication: first we do
# some 'global' stuff as the postgres 'root' user, which is called
# 'postgres' (and who is also a Linux user, hence the 'sudo'. The 'DROP'
# commands are to make this script idempotent, i.e. executing it twice
# gives the same result: an empty database with an 'account' table set
# up.
sudo -u postgres psql --dbname=${DB}  <<\EOF
  DROP TABLE IF EXISTS account;
  DROP EXTENSION IF EXISTS citext;
  DROP EXTENSION IF EXISTS pgcrypto; 
  CREATE EXTENSION citext; 
  CREATE EXTENSION pgcrypto; 
EOF
[ $? -eq 0 ] || exit 1;
# Finally create the table. SERIAL is what you think it is: you cannot
# insert into it and each new instance gets an incremented id. CITEXT is
# case-insensitive (CI) text.
sudo -u ${USER} psql --dbname=${DB} <<\EOF
  CREATE TABLE account( 
    id SERIAL PRIMARY KEY,
    email CITEXT UNIQUE NOT NULL,
    password TEXT NOT NULL);
EOF
```

### Encrypting passwords

Finally, it may be interesting to see how passwords are stored using
encryption.

#### Register
The following script registers a new user using an *email* address and a
*password*.

``` bash
#!/bin/bash
USAGE="$0 email password"
[ $# -eq 2 ] || { echo "$USAGE"; exit 1; }

USER=js
EMAIL=$1
PASSWD=$2;
sudo -u ${USER} psql --quiet --dbname=${DB} <<EOF
  INSERT INTO account (email, password) 
           VALUES ('${EMAIL}', crypt('${PASSWD}', gen_salt('bf', 8)));
EOF
...
```
#### Login
while here is how a password is checked at login time:
```bash
#!/bin/bash
USAGE="$0 email password"
[ $# -eq 2 ] || { echo "$USAGE"; exit 1; }

USER=js
EMAIL=$1
PASSWD=$2;
sudo -u ${USER} psql --quiet --tuples-only --dbname=${DB} <<EOF

  SELECT count(id) 
  FROM account 
  WHERE email='${EMAIL}' AND password = crypt('${PASSWD}', password);

EOF
# output will be 1 if found, 0 otherwise
```

