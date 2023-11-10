import 'dart:io';

import 'package:database_student/data_repository/dbHelper.dart';
import 'package:database_student/model/student_model.dart';
import 'package:database_student/manager/student_manager.dart';
import 'package:database_student/ui/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditStudentScreen extends StatefulWidget {
  final StudentModel studentModel;
  const EditStudentScreen({super.key, required this.studentModel});

  @override
  State<EditStudentScreen> createState() => _EditStudentScreenState();
}

class _EditStudentScreenState extends State<EditStudentScreen> {
  Future pickImage(BuildContext context, ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) return;

    StudentManager().image = File(image.path);
  }

  void refresh() async {
    final data = await DbHelper.dbHelper.getAllStudents();
    setState(() {
      StudentManager().allStudents = data;
    });
  }

  @override
  void initState() {
    super.initState();
    refresh();
  }

  @override
  Widget build(BuildContext context) {
    StudentManager studentManager = StudentManager();

    return Scaffold(
        appBar: AppBar(
          title: const Text('Edit Student'),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: studentManager.nameController,
                  decoration: InputDecoration(
                      label: Text('Name'),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15))),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: studentManager.preparationTimeController,
                  decoration: InputDecoration(
                      label: Text('Age'),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15))),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    PopupMenuButton(
                        color: !studentManager.isDark ? Colors.blue[100] : null,
                        itemBuilder: (context) => [
                              PopupMenuItem(
                                  onTap: () =>
                                      pickImage(context, ImageSource.camera),
                                  child: const Row(
                                    children: [
                                      Icon(Icons.camera_alt_outlined),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text('Take a Picture')
                                    ],
                                  )),
                              PopupMenuItem(
                                  onTap: () =>
                                      pickImage(context, ImageSource.gallery),
                                  child: Row(
                                    children: [
                                      Icon(Icons.image_outlined),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text('Seletct a Picture')
                                    ],
                                  ))
                            ]),
                    Text(
                      'ADD A PICTURE',
                      style: TextStyle(fontSize: 16),
                    )
                  ],
                ),
                Visibility(
                    visible: studentManager.image != null,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            studentManager.image = null;
                            setState(() {});
                          },
                          child: Icon(
                            Icons.cancel_outlined,
                            color: Colors.red,
                          ),
                        ),
                        studentManager.image != null
                            ? Image.file(
                                studentManager.image!,
                                width: 100,
                                height: 100,
                              )
                            : Container()
                      ],
                    )),
                SizedBox(
                  height: 20,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: SizedBox(
                    height: 100,
                    child: TextField(
                      expands: true,
                      maxLines: null,
                      controller: studentManager.ingredientsController,
                      decoration: InputDecoration(
                          label: Text('Ingredients'),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16))),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: SizedBox(
                    height: 100,
                    child: TextField(
                      expands: true,
                      maxLines: null,
                      controller: studentManager.instructionController,
                      decoration: InputDecoration(
                          label: Text('Instructions'),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15))),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      widget.studentModel.name =
                          studentManager.nameController.text;
                      widget.studentModel.preparationTime = int.parse(
                          studentManager.preparationTimeController.text != ''
                              ? studentManager.preparationTimeController.text
                              : '0');
                      widget.studentModel.image = studentManager.image;
                      widget.studentModel.ingredients =
                          studentManager.ingredientsController.text;
                      widget.studentModel.instruction =
                          studentManager.instructionController.text;

                      studentManager.updateStudent(widget.studentModel);
                      studentManager.nameController.clear();
                      studentManager.preparationTimeController.clear();
                      studentManager.instructionController.clear();
                      studentManager.ingredientsController.clear();
                      studentManager.image = null;
                      refresh();
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>const HomeScreen()));
                    },
                    child: const Center(
                      child: Text('Save Changes'),
                    ))
              ],
            ),
          ),
        ));
  }
}
