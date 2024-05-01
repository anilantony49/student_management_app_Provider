import 'dart:io';
import 'package:database_student/data_repository/dbHelper.dart';
import 'package:database_student/model/student_model.dart';
import 'package:flutter/material.dart';

class StudentManager {
  static final StudentManager _instance = StudentManager._internal();

  factory StudentManager() {
    return _instance;
  }
  
  StudentManager._internal() {  
    getStudents();
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  File? image;

  List<StudentModel> allStudents = [];

  Future<void> getStudents() async {
    allStudents = await DbHelper.dbHelper.getAllStudents();
  }

  void insertNewStudent() {
    StudentModel studentModel = StudentModel(
        name: nameController.text,
        image: image,
        age: int.parse(ageController.text),
        address: addressController.text,
        email: emailController.text,
        phoneNumber: int.parse(phoneNumberController.text));

    DbHelper.dbHelper.insetNewStudent(studentModel);

    // getStudents();
  }

  Future<void> updateStudent(StudentModel studentModel) async {
    await DbHelper.dbHelper.updateStudent(studentModel);
    // getStudents();
  }

  void deleteStudents(StudentModel studentModel) {
    DbHelper.dbHelper.deleteStudent(studentModel);
    // getStudents();
  }
}
