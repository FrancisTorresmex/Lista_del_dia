
import 'dart:async';


import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tusdeberes/models/dataBase_model.dart';


class Operation {
  static  Future<Database> _openDb() async{
    return openDatabase(join(await getDatabasesPath(), 'duty_database.db'),
      onCreate: (db, version){
        db.execute(
          "CREATE TABLE duty(id INTEGER PRIMARY KEY, name TEXT, description TEXT, finished INTEGER)", //creamos la tabla duty
        );
      }, version: 2
    );
  }

  //insertar
  static Future insert(Should should) async{
    Database database = await _openDb();
    return database.insert("duty", should.toMap());
  }

  //ver lista
  static Future<List<Should>> shouldsList() async{
    Database database = await _openDb();
    final List<Map<String, dynamic>> shouldMap = await  database.query("duty");

     //for(var s in shouldMap) {
      //print('aqui: $s["name"]');
     //}
    
    return List.generate(shouldMap.length, (i) => Should(id: shouldMap[i]['id'], name: shouldMap[i]['name'], description: shouldMap[i]['description'], finished: shouldMap[i]['finished']));
  }

  //modificar
  static Future update(Should should) async{
    Database database = await _openDb();
    return database.update("duty", should.toMap(), where: 'id = ?', whereArgs: [should.id]);
  }

  //eliminar
  static Future delete(Should should) async{
    Database database = await _openDb();
    return database.delete("duty", where: 'id = ?', whereArgs: [should.id]);
  }

}