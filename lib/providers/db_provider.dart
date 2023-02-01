

import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'package:qr_reader/models/scan_models.dart';
export 'package:qr_reader/models/scan_models.dart';

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

  //La siguiente forma es muy larga de crear un insert. 
  Future <int>nuevoScanRaw (ScanModel nuevoScan ) async {

    final id    = nuevoScan.id;
    final tipo  = nuevoScan.tipo;
    final valor = nuevoScan.valor;


    final db = await database;
    final res = await db.rawInsert('''
      INSERT INTO Scans(id, tipo, valor)
      VALUES ( $id, '$tipo', '$valor')

    ''');
    return res;
  }

  //Forma sensilla de agregar un Insert
  Future<int >nuevoScan(ScanModel nuevoScan ) async{
    final db = await database;
    final res = await db.insert('Scans', nuevoScan.toJson());
    print(res);

    //es el id del ultimo registro insertado. 
    return res;
  }
  Future<ScanModel?> getScanById (int id) async {
    final db = await database;
    final res = await db.query('Scans', where: 'id = ?', whereArgs: [id]);

    return res.isNotEmpty
        ? ScanModel.fromJson(res.first)
        :null;

  }

  Future<List<ScanModel>> getTodosLosScans () async {
    //Si ya esta lista la base de datos
    final db = await database;
    final res = await db.query('Scans');

    return res.isNotEmpty
        ? res.map((s) => ScanModel.fromJson(s)).toList()
        :[];

  }

  Future<List<ScanModel>> getScansPorTipo (String tipo) async {
    //Si ya esta lista la base de datos
    final db = await database;
    final res = await db.rawQuery(''' 
      SELECT * FROM Scans WHERE tipo ='$tipo'
    ''');

    return res.isNotEmpty
        ? res.map((s) => ScanModel.fromJson(s)).toList()
        :[];
  }

  Future <int> updateScan (ScanModel nuevoScan) async{
    final db = await database;
    final res = await db.update('Scans', nuevoScan.toJson(), where: 'id= ?', whereArgs: [nuevoScan.id] );
    return res;
  }

}