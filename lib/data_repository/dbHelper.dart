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
  // final String isFavoriteColumn = 'isFavorite';
  final String ingredientsColumn = 'ingredients';
  final String instructionColumn = 'instructions';
  final String preparationTimeColumn = 'preparationTime';
  final String imageColumn = 'image';

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
            'CREATE TABLE $tableName ($idColumn INTEGER PRIMARY KEY AUTOINCREMENT, $nameColumn TEXT,$preparationTimeColumn INTEGER,'
            // '$isFavoriteColumn INTEGER,'
            '$ingredientsColumn TEXT, $instructionColumn TEXT, $imageColumn TEXT)');
      },
      onUpgrade: (db, oldVersion, newVersion) {
        db.execute(
            'CREATE TABLE $tableName ($idColumn INTEGER PRIMARY KEY AUTOINCREMENT, $nameColumn TEXT, $preparationTimeColumn INTEGER,'
            // '$isFavoriteColumn INTEGER,'
            '$ingredientsColumn TEXT, $instructionColumn TEXT, $imageColumn TEXT)');
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
          preparationTimeColumn: studentModel.preparationTime,
          imageColumn: studentModel.image!.path,
          ingredientsColumn: studentModel.ingredients,
          instructionColumn: studentModel.instruction
        },
        where: '$idColumn=?',
        whereArgs: [studentModel.id]);
  }
}
