import 'package:database_student/data_repository/dbHelper.dart';
import 'package:database_student/model/student_model.dart';
import 'package:database_student/manager/student_manager.dart';
import 'package:database_student/ui/screens/edit_student_screen.dart';
import 'package:database_student/ui/screens/home_screen.dart';
import 'package:flutter/material.dart';

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
        actions: [
          InkWell(
            onTap: () {
              StudentManager studentManager = StudentManager();
              studentManager.nameController.text = widget.studentModel.name;
              studentManager.preparationTimeController.text =
                  widget.studentModel.preparationTime.toString();
              studentManager.ingredientsController.text =
                  widget.studentModel.ingredients;
              studentManager.instructionController.text =
                  widget.studentModel.instruction;
              studentManager.image = widget.studentModel.image;

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      EditStudentScreen(studentModel: widget.studentModel),
                ),
              );
            },
            child: Icon(Icons.edit),
          ),
          SizedBox(
            width: 20,
          ),
          InkWell(
            onTap: () {
              StudentManager().deleteRecipe(widget.studentModel);
              refresh();
              Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
            },
            child: Icon(Icons.delete),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: !StudentManager().isDark ? Colors.blue : null,
                borderRadius: BorderRadius.circular(5),
              ),
              height: 170,
              child: widget.studentModel.image == null
                  ? const Center(
                      child: CircleAvatar(
                        radius: 40,
                        backgroundImage: AssetImage(
                            'assets/images/student image3.jpg'),
                      ),
                    )
                  : Image.file(widget.studentModel.image!),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Text(
                widget.studentModel.name,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: !StudentManager().isDark ? Colors.blue[100] : null,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Text(
                    'Preparation time :',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    '${widget.studentModel.preparationTime}mins',
                    style: TextStyle(fontSize: 16),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: !StudentManager().isDark ? Colors.blue[100] : null,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ingredients',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    widget.studentModel.ingredients,
                    style: TextStyle(fontSize: 26),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: !StudentManager().isDark ? Colors.blue[100] : null,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Instructions',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    widget.studentModel.instruction,
                    style: TextStyle(fontSize: 26),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
