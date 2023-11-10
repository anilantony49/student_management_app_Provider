import 'package:database_student/model/student_model.dart';
import 'package:database_student/ui/screens/widgets/student_widget.dart';
import 'package:flutter/material.dart';

class SearchStudentScreen extends StatefulWidget {
  final List<StudentModel> students;
  List<StudentModel> filterStudents = [];
  SearchStudentScreen({super.key, required this.students}) {
    filterStudents = students;
  }

  @override
  State<SearchStudentScreen> createState() => _SearchStudentScreenState();
}

class _SearchStudentScreenState extends State<SearchStudentScreen> {
  void filterStudents(value) {
    setState(() {
      widget.filterStudents = widget.students
          .where((student) =>
              student.name.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          onChanged: (value) {
            filterStudents(value);
          },
          decoration: const InputDecoration(icon: Icon(Icons.search,color: Colors.white,)),
        ),
        actions: [
          IconButton(onPressed: (){
            setState(() {
              Navigator.pop(context);
            });
          }, icon:Icon(Icons.cancel))
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child:widget.filterStudents.isNotEmpty ? ListView.builder(
          itemCount: widget.filterStudents.length,
          itemBuilder: (BuildContext context, int index){
            return StudentWidget(widget.filterStudents[index]);
          })
          :
         Center(
          child: Text('Recipe not found'),
        ),
      ),
    );
  }
}
