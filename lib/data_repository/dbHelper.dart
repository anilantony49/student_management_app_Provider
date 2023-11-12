import 'dart:io';

import 'package:database_student/model/student_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  late Database database;
  static DbHelper dbHelper = DbHelper();
  final String tableName = 'recipes';
  final String nameColumn = 'name';
  final String idColumn = 'id';
  final String addressColumn = 'address';
  final String phoneNumberColumn = 'phoneNumber';
  final String ageColumn = 'age';
  final String imageColumn = 'image';
  final String emailColumn = 'email';

  initDatabase() async {
    database = await connectToDatabase();
  }

  Future<Database> connectToDatabase() async {
    // Get the location uisng getDatabasePath
    Directory directory = await getApplicationDocumentsDirectory();

    // to specific name of database

    String path = "$directory/recipe.db";

    // to create database
    return openDatabase(
      path, version: 1,

      // to create the table
      onCreate: (db, version) {
        db.execute(
            'CREATE TABLE $tableName ($idColumn INTEGER PRIMARY KEY AUTOINCREMENT, $nameColumn TEXT, $ageColumn INTEGER,'
            '$addressColumn TEXT, $emailColumn TEXT, $phoneNumberColumn INTEGER, $imageColumn TEXT)');
      },
      onUpgrade: (db, oldVersion, newVersion) {
        db.execute(
            'CREATE TABLE $tableName ($idColumn INTEGER PRIMARY KEY AUTOINCREMENT, $nameColumn TEXT, $ageColumn INTEGER,'
            '$addressColumn TEXT, $emailColumn TEXT, $phoneNumberColumn INTEGER, $imageColumn TEXT)');
      },
      onDowngrade: (db, oldVersion, newVersion) {
        db.delete(tableName);
      },
    );
  }
// to read data

  Future<List<StudentModel>> getAllStudents() async {
    List<Map<String, dynamic>> tasks = await database.query(tableName);
    return tasks.map((e) => StudentModel.fromMap(e)).toList();
  }

// to insert some data
  insetNewStudent(StudentModel studentModel) {
    database.insert(tableName, studentModel.toMap());
  }

// to delete one column from table

  deleteStudent(StudentModel studentModel) {
    database.delete(tableName,
        where: " $idColumn =?", whereArgs: [studentModel.id]);
  }

// to delete all of table

  deleteStudents() {
    database.delete(tableName);
  }

// to update data

  updateStudent(StudentModel studentModel) async {
    await database.update(
        tableName,
        {
          nameColumn: studentModel.name,
          ageColumn: studentModel.age,
          imageColumn: studentModel.image!.path,
          addressColumn: studentModel.address,
          emailColumn: studentModel.email,
          phoneNumberColumn: studentModel.phoneNumber
        },
        where: '$idColumn=?',
        whereArgs: [studentModel.id]);
  }
}
