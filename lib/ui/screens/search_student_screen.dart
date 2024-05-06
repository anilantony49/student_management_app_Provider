import 'package:database_student/model/student_model.dart';
import 'package:database_student/ui/screens/widgets/student_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchStudentProvider extends ChangeNotifier {
  late List<StudentModel> _students;
  List<StudentModel> _filterStudents = [];

  List<StudentModel> get filterStudents => _filterStudents;

  void initialize(List<StudentModel> students) {
    _students = students;
    _filterStudents = students;
  }

  void filterStudent(String value) {
    _filterStudents = _students
        .where((student) => student.name.toLowerCase().contains(value.toLowerCase()))
        .toList();
    notifyListeners();
  }
}

class SearchStudentScreen extends StatelessWidget {
  final List<StudentModel> students;

  const SearchStudentScreen({Key? key, required this.students}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SearchStudentProvider>(context, listen: false);
    provider.initialize(students);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xC1C1C1C1),
        title: TextField(
          onChanged: (value) {
            provider.filterStudent(value);
          },
          decoration: const InputDecoration(
            icon: Icon(
              Icons.search,
              color: Colors.black,
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.cancel),
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Consumer<SearchStudentProvider>(
          builder: (context, provider, _) {
            return provider.filterStudents.isNotEmpty
                ? ListView.builder(
                    itemCount: provider.filterStudents.length,
                    itemBuilder: (BuildContext context, int index) {
                      return StudentListWidget(provider.filterStudents[index]);
                    },
                  )
                : const Center(
                    child: Text('Student not found'),
                  );
          },
        ),
      ),
    );
  }
}
