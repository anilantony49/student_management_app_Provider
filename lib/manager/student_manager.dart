import 'dart:io';
import 'package:database_student/data_repository/dbHelper.dart';
import 'package:database_student/model/student_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class StudentManager extends ChangeNotifier {
  // static final StudentManager _instance = StudentManager._internal();

  // factory StudentManager() {
  //   return _instance;
  // }

  // StudentManager._internal() {
  //   getStudents();
  // }

  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  File? image;

  List<StudentModel> allStudents = [];
  bool _isGridView = false;

  bool get isGridView => _isGridView;

  void toggleView() {
    _isGridView = !_isGridView;
    notifyListeners(); // Notify listeners of state change
  }

  Future<void> pickImage(BuildContext context, ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) return;
    this.image = File(image.path);
    notifyListeners();
  }

  void refresh() async {
    final data = await DbHelper.dbHelper.getAllStudents();
    allStudents = data;
    notifyListeners();
  }

  void clearImage() {
    image = null;
    notifyListeners();
  }

  StudentManager() {
    getStudents();
  }
  // bool isGridView = false;

  // File? get image => _image;
  // set image(File? value) {
  //   _image = value;
  //   notifyListeners();
  // }

  // List<StudentModel> get allStudents => allStudents;

  // toggleView() {
  //   isGridView = !isGridView;
  // }

  // Future<void> refresh() async {
  //   final data = await DbHelper.dbHelper.getAllStudents();
  //   _allStudents = data;
  //   notifyListeners();
  // }

  Future<void> getStudents() async {
    allStudents = await DbHelper.dbHelper.getAllStudents();
    notifyListeners();
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
    // refresh();

    getStudents();
  }

  Future<void> updateStudent(StudentModel studentModel) async {
    await DbHelper.dbHelper.updateStudent(studentModel);
    // refresh();
    getStudents();
  }

  void deleteStudents(StudentModel studentModel) {
    DbHelper.dbHelper.deleteStudent(studentModel);
    // refresh();
    getStudents();
  }
}
