import 'package:database_student/model/student_model.dart';
import 'package:database_student/ui/screens/widgets/student_list_widget.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
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
                backgroundColor: const Color(0xC1C1C1C1),

        title: TextField(
          onChanged: (value) {
            filterStudents(value);
          },
          decoration: const InputDecoration(
              icon: Icon(
            Icons.search,
            color: Colors.black,
          )),
        ),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  Navigator.pop(context);
                });
              },
              icon: const Icon(Icons.cancel))
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: widget.filterStudents.isNotEmpty
            ? ListView.builder(
                itemCount: widget.filterStudents.length,
                itemBuilder: (BuildContext context, int index) {
                  return StudentListWidget(widget.filterStudents[index]);
                })
            : const Center(
                child: Text('Student not found'),
              ),
      ),
    );
  }
}
