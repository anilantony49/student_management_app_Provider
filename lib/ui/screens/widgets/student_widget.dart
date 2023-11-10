import 'package:database_student/model/student_model.dart';
import 'package:database_student/manager/student_manager.dart';
import 'package:database_student/ui/screens/show_student_screen.dart';
import 'package:flutter/material.dart';

class StudentWidget extends StatelessWidget {
  final StudentModel studentModel;
  const StudentWidget(
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
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(5),
        child: ListTile(
          tileColor: !studentManager.isDark
              ? Colors.blue[100]
              : null,
          leading: studentModel.image == null
              ? Container(
                  decoration: BoxDecoration(
                      color: !studentManager.isDark ? Colors.blue : null,

                      // color: !Provider.of<RecipeClass>(context).isDark ? Colors.blue : null,
                      borderRadius: BorderRadius.circular(8)),
                  height: double.infinity,
                  width: 70,
                  child: Center(
                    child: CircleAvatar(
                      backgroundImage:
                          AssetImage('assets/images/student iimage2.jpg'),
                    ),
                  ),
                )
              : Image.file(
                  studentModel.image!,
                  width: 70,
                  height: double.infinity,
                ),
          title: Text(studentModel.name),
          subtitle: Text('${studentModel.preparationTime} mins'),
          // trailing: Icon(Icons.dangerous),
        ),
      ),
    );
  }
}
