import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:bbts_flutter/models/funcionario.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DBProvider {
  DBProvider._();
  // static Database _database;
  static final DBProvider db = DBProvider._();



  // Future<List> senddata() async {
    // final response = await http.post(
    //     "http://raushanjha.in/insertdata.php", body: {
    //   "name": 'aaa',
    //   "email": 'aaaa',
    //   "mobile": 'aaaa',
    // });

    // var datauser = json.decode(response.body);
  // }



  // initDB() async {
  //   // Directory documentsDirectory = await getApplicationDocumentsDirectory();
  //   // String path = join('documentsDirectory.path', 'funcionarios.db');
  //   String path = 'http://localhost';
  //   print (path);
  //   return await openDatabase(path, version: 1, onOpen: (db) {},
  //       onCreate: (Database db, int version) async {
  //     CreateTable(db);
  //   });
  // }
  //
  // void CreateTable(db) async {
  //   print("Criando Tabelas!");
  //   await db.execute('''CREATE TABLE IF NOT EXISTS Funcionarios(
  //         matricula INTEGER PRIMARY KEY);''');
  // }
  //
  // CreateEmployee(Funcionario newEmployee) async {
  //   print("Criando Funcionario!");
  //   final db = await database;
  //   final res = await db.insert('Funcionarios', newEmployee.toJson());
  //   return res;
  // }
  //
  // Future<List<Funcionario>> getAllFuncionarios() async {
  //   final db = await database;
  //   print('Listando Dados da tabela!');
  //   final res = await db.rawQuery("SELECT * FROM Funcionarios");
  //   List<Funcionario> list =
  //       res.isNotEmpty ? res.map((c) => Funcionario.fromJson(c)).toList() : [];
  //
  //   return list;
  // }
}
