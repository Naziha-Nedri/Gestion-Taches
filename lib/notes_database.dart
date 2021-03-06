
import 'dart:async';
import 'dart:io' as io;
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseConnexion {

  setDatabase() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = join (directory.path,'todofile.db');
    final database = await openDatabase(path,version: 1,onCreate: _onCreatingDatabase);
  return database;
  }
  _onCreatingDatabase(Database database,int version ) async{
    await database.execute('CREATE TABLE todos(id INTEGER PRIMERY KEY, datedebut TEXT,datefin TEXT,quantite TEXT, isFinished INTEGER)');



  }
  
  
  
  
}
