
import 'dart:io';
import 'package:database_student/data_repository/dbHelper.dart';
import 'package:database_student/model/student_model.dart';
import 'package:flutter/material.dart';

class StudentManager  {
  static final StudentManager _instance = StudentManager._internal();

  factory StudentManager() {
    return _instance;
  }

  StudentManager._internal() {
    getRecipes();
  }

  bool isDark = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController preparationTimeController = TextEditingController();
  TextEditingController instructionController = TextEditingController();
  TextEditingController ingredientsController = TextEditingController();
  File? image;

  List<StudentModel> allStudents = [];
 

  void changeIsDark() {
    isDark = !isDark;
  }

  Future<void> getRecipes() async {
    allStudents = await DbHelper.dbHelper.getAllStudents();
  
    // favoriteRecipes = allRecipes.where((e) => e.isFavorite).toList();
  }
  

  void insertNewStudent() {
    StudentModel studentModel = StudentModel(
      name: nameController.text,
      // isFavorite: false,
      image: image,
      preparationTime: int.parse(
        preparationTimeController.text.isNotEmpty
            ? preparationTimeController.text
            : '0',
      ),
      instruction: instructionController.text,
      ingredients: ingredientsController.text,
    );

    DbHelper.dbHelper.insetNewStudent(studentModel);
    
    // getRecipes();
  }

  Future<void> updateStudent(StudentModel studentModel) async {
    await DbHelper.dbHelper.updateStudent(studentModel);
    // getRecipes();
  }


  void deleteRecipe(StudentModel studentModel) {
    DbHelper.dbHelper.deleteStudent(studentModel);
    // getRecipes();
  }
}
