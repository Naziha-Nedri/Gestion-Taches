
import 'package:flutter_app/notes_database.dart';
import 'package:sqflite/sqflite.dart';

class Repository{
  final DatabaseConnexion _databaseConnexion = DatabaseConnexion();

  Repsitory(){
   _databaseConnexion.setDatabase();

  }
  static Database _database;

   Future<Database> get database async{
     if(_database!=null) return _database;
     _database = await _databaseConnexion.setDatabase();
     return _database;
   }

   insertData(table,data) async {
     var connection = await database;
     return await connection.insert(table,data);

   }

   readData(table) async {
     var connection = await database;
     return await connection.query(table);
   }
}