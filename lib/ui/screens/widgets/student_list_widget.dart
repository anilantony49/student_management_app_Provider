import 'package:database_student/model/student_model.dart';
import 'package:database_student/manager/student_manager.dart';
import 'package:database_student/ui/screens/show_student_screen.dart';
import 'package:flutter/material.dart';

class StudentListWidget extends StatelessWidget {
  final StudentModel studentModel;
  const StudentListWidget(
    this.studentModel, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    StudentManager studentManager = StudentManager();

    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    ShowStudentScreen(studentModel: studentModel)));
      },
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              tileColor: !studentManager.isDark ? Colors.grey : null,
              leading: Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: CircleAvatar(
                  radius: 35,
                  backgroundImage: FileImage(studentModel.image!),
                ),
              ),
              title: Text(
                studentModel.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
