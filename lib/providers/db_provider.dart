

import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


class DBProvider {

  static Database? _database;
  static final DBProvider db = DBProvider._();
  DBProvider._();

  Future <Database> get database async{
    if (_database !=null) return _database!;

    _database =await initDB();

    return _database!;

  }

  Future <Database> initDB() async {

    //Path de donde almacenaremos la base de datos. 

    Directory documenentsDirectory = await getApplicationDocumentsDirectory();

    final path = join(documenentsDirectory.path, 'ScansDB.db');
    print(path);

    //Crear base de datos

    return await openDatabase(
      path,
      version: 1,
      onOpen: ((db) { }),
      onCreate: (Database db, int version)async{

        await db.execute('''
          CREATE TABLE Scans(
            id  INTEGER PRIMARY KEY, 
            tipo TEXT,
            valor TEXT
          )
        ''');
      }

    );
    
  }

}