import 'dart:io';

import 'package:flutter_application_1/model/student.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();
  static Database? _database;

  final String studentsTable = 'Students';
  final String columnId = 'id';
  final String columnName = 'name';

  Future<Database> get database async {
    _database ??= await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final Directory dir = await getApplicationDocumentsDirectory();
    final String path = '${dir.path}/Student.db';
    return openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute(
      'CREATE TABLE $studentsTable($columnId INTEGER PRIMARY KEY AUTOINCREMENT, $columnName TEXT)',
    );
  }

  Future<List<Student>> getStudents() async {
    final Database db = await database;
    final List<Map<String, dynamic>> studentsMapList = await db.query(studentsTable);
    return studentsMapList.map(Student.fromMap).toList();
  }

  Future<Student> insertStudent(Student student) async {
    final Database db = await database;
    student.id = await db.insert(studentsTable, student.toMap());
    return student;
  }

  Future<int> updateStudent(Student student) async {
    final Database db = await database;
    return db.update(
      studentsTable,
      student.toMap(),
      where: '$columnId = ?',
      whereArgs: [student.id],
    );
  }

  Future<int> deleteStudent(int? id) async {
    final Database db = await database;
    return db.delete(
      studentsTable,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }
}