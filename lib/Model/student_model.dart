import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MyDb {
  late Database db;

  Future open() async {
    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo.db');
    //join is from path package

    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute('''

                  CREATE TABLE IF NOT EXISTS students( 
                        id INTEGER PRIMARY KEY AUTOINCREMENT,
                        username varchar(255) not null,
                        mobile_no VARCHAR(15) not null,
                        email varchar(255) not null,
                        password varchar(255) not null
                    );

                    //create more table here
                
                ''');
      await db.execute('''

                           CREATE TABLE IF NOT EXISTS s_record( 
                        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
                        name varchar(255) not null,
                        roll_no int not null,
                        address varchar(255) not null
                    );

                    //create more table here
                
                ''');
    });
  }
}
