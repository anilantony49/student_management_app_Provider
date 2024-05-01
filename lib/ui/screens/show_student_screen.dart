import 'package:database_student/data_repository/dbHelper.dart';
import 'package:database_student/model/student_model.dart';
import 'package:database_student/manager/student_manager.dart';
import 'package:database_student/ui/screens/edit_student_screen.dart';
import 'package:database_student/ui/screens/home_screen.dart';
import 'package:flutter/material.dart';

import 'widgets/constants.dart';

class ShowStudentScreen extends StatefulWidget {
  final StudentModel studentModel;
  const ShowStudentScreen({super.key, required this.studentModel});

  @override
  State<ShowStudentScreen> createState() => _ShowStudentScreenState();
}

class _ShowStudentScreenState extends State<ShowStudentScreen> {
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xC1C1C1C1),
        actions: [
          InkWell(
            onTap: () {
              StudentManager studentManager = StudentManager();
              studentManager.nameController.text = widget.studentModel.name;
              studentManager.ageController.text =
                  widget.studentModel.age.toString();
              studentManager.addressController.text =
                  widget.studentModel.address;
              studentManager.phoneNumberController.text =
                  widget.studentModel.phoneNumber.toString();
              studentManager.emailController.text = widget.studentModel.email;

              studentManager.image = widget.studentModel.image!;

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      EditStudentScreen(studentModel: widget.studentModel),
                ),
              );
            },
            child: const Icon(Icons.edit),
          ),
          const SizedBox(
            width: 20,
          ),
          InkWell(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      title: const Text('Delete'),
                      content: const Text('Are you sure want to delete?'),
                      actions: [
                        TextButton(
                            onPressed: () {
                              StudentManager()
                                  .deleteStudents(widget.studentModel);
                              refresh();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const HomeScreen()));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text('Delete succesfully'),
                                behavior: SnackBarBehavior.floating,
                                margin: EdgeInsets.all(10),
                              ));
                            },
                            child: const Text('Yes',style: TextStyle(color:kColor),)),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('No',style: TextStyle(color:kColor),))
                      ],
                    );
                  });
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Icon(Icons.delete),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color:kColor,
                borderRadius: BorderRadius.circular(5),
              ),
              height: 170,
              child: widget.studentModel.image == null || widget.studentModel.image!.path.isEmpty
                  ? const Center(
                      child: CircleAvatar(
                        radius: 40,
                        backgroundImage:
                            AssetImage('assets/images/blank profile.jpg'),
                      ),
                    )
                  : Image.file(widget.studentModel.image!),
            ),
          kHeight2,
            Center(
              child: Text(
                widget.studentModel.name,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          kHeight1,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: EdgeInsets.all(10),
                // width: 500,
                // margin: EdgeInsets.symmetric(horizontal: 50),
                decoration: BoxDecoration(
                  color:kColor ,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    const Text(
                      'Age :',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      widget.studentModel.age.toString(),
                      style: TextStyle(fontSize: 16),
                    )
                  ],
                ),
              ),
            ),
           kHeight2,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color:kColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Address',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                   kHeight1,
                    Text(
                      widget.studentModel.address,
                      style: const TextStyle(fontSize: 26),
                    )
                  ],
                ),
              ),
            ),
          kHeight2,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color:kColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'phone number',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  kHeight1,
                    Text(
                      widget.studentModel.phoneNumber.toString(),
                      style: const TextStyle(fontSize: 26),
                    )
                  ],
                ),
              ),
            ),
         kHeight2,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color:kColor ,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'email',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  kHeight1,
                    Text(
                      widget.studentModel.email,
                      style: const TextStyle(fontSize: 26),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
