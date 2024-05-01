import 'dart:io';

import 'package:database_student/data_repository/dbHelper.dart';
import 'package:database_student/model/student_model.dart';
import 'package:database_student/manager/student_manager.dart';
import 'package:database_student/ui/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'widgets/constants.dart';

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
    setState(() {
      StudentManager().image = File(image.path);
    });
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

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    StudentManager studentManager = StudentManager();

    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xC1C1C1C1),
          title: const Text('Edit Student'),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(5),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                kHeight2,
                  TextFormField(
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    controller: studentManager.nameController,
                    decoration: InputDecoration(
                        label: const Text(
                          'Name',
                          style: TextStyle(color: Colors.white),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15))),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'please fill this field';
                      } else {
                        return null;
                      }
                    },
                  ),
                  kHeight1,
                  TextFormField(
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    keyboardType: TextInputType.number,
                    controller: studentManager.ageController,
                    decoration: InputDecoration(
                        label: const Text(
                          'Age',
                          style: TextStyle(color: Colors.white),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15))),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'please fill this field';
                      } else {
                        return null;
                      }
                    },
                  ),
                 kHeight1,
                  Row(
                    children: [
                      PopupMenuButton(
                          color:kColor,
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
                                    child: const Row(
                                      children: [
                                        Icon(Icons.image_outlined),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          'Seletct a Picture',
                                          style: TextStyle(color: Colors.white),
                                        )
                                      ],
                                    ))
                              ]),
                      const Text(
                        'ADD A PICTURE',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
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
                            child: const Icon(
                              Icons.cancel_outlined,
                              color: Colors.red,
                            ),
                          ),
                          studentManager.image != null
                              ? CircleAvatar(
                                  radius: 35,
                                  backgroundImage:
                                      FileImage(studentManager.image!),
                                )
                              : Container()
                        ],
                      )),
                kHeight1,
                  SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: SizedBox(
                      height: 100,
                      child: TextFormField(
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                        expands: true,
                        maxLines: null,
                        controller: studentManager.addressController,
                        decoration: InputDecoration(
                            label: const Text(
                              'Address',
                              style: TextStyle(color: Colors.white),
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16))),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'please fill this field';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                  ),
                kHeight1,
                  SizedBox(
                    // height: 100,
                    child: TextFormField(
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      keyboardType: TextInputType.number,
                      controller: studentManager.phoneNumberController,
                      decoration: InputDecoration(
                          label: const Text(
                            'Phone number',
                            style: TextStyle(color: Colors.white),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15))),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'please fill this field';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                 kHeight1,
                  SizedBox(
                    // height: 100,
                    child: TextFormField(
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      controller: studentManager.emailController,
                      decoration: InputDecoration(
                          label: const Text(
                            'email',
                            style: TextStyle(color: Colors.white),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15))),
                    ),
                  ),
                kHeight1,
                  ElevatedButton(
                      style: const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(
                        Color(0xC1C1C1C1),
                      )),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();

                          widget.studentModel.name =
                              studentManager.nameController.text;
                          widget.studentModel.age = int.parse(
                              studentManager.ageController.text);
                          widget.studentModel.image = studentManager.image;
                          widget.studentModel.address =
                              studentManager.addressController.text;
                          widget.studentModel.phoneNumber = int.parse(
                              studentManager.phoneNumberController.text);
                          widget.studentModel.email =
                              studentManager.emailController.text;

                          studentManager.updateStudent(widget.studentModel);
                          studentManager.nameController.clear();
                          studentManager.ageController.clear();
                          studentManager.addressController.clear();
                          studentManager.emailController.clear();
                          studentManager.phoneNumberController.clear();

                          studentManager.image = null;
                          refresh();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomeScreen()));
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text('Edit Succesfully'),
                            behavior: SnackBarBehavior.floating,
                            margin: EdgeInsets.all(10),
                          ));
                        }
                      },
                      child: const Center(
                        child: Text(
                          'Save Changes',
                          style: TextStyle(color: Colors.black),
                        ),
                      ))
                ],
              ),
            ),
          ),
        ));
  }
}
