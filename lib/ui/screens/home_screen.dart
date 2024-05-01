import 'package:database_student/data_repository/dbHelper.dart';
import 'package:database_student/manager/student_manager.dart';
import 'package:database_student/ui/screens/search_student_screen.dart';
import 'package:database_student/ui/screens/widgets/popup_menu_button.dart';
import 'package:database_student/ui/screens/widgets/student_grid_widget.dart';
import 'package:flutter/material.dart';

import 'widgets/student_list_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _MainStudentScreenState();
}

class _MainStudentScreenState extends State<HomeScreen> {
  bool isGridView = false;
  void refresh() async {
    final data = await DbHelper.dbHelper.getAllStudents();
    setState(() {
      StudentManager().allStudents = data;
    });
  }

  void toogleView() {
    setState(() {
      isGridView = !isGridView;
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
        backgroundColor: const Color(0xC1C1C1C1),
        title: const Text('Students List'),
        actions: [
          InkWell(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) => SearchStudentScreen(
                      students: studentManager.allStudents)),
            ),
            child: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: toogleView,
            icon: isGridView
                ? const Icon(Icons.list)
                : const Icon(Icons.grid_view),
          ),
          const MyPopupMenuButton()
        ],
      ),
      floatingActionButton: FloatingActionButton(
        
        backgroundColor: const Color(0xC1C1C1C1),
        onPressed: () async {
          await Navigator.pushNamed(context, '/new_student_screen');
          Navigator.pushReplacementNamed(context, '/main_screen');
        },
        child: const Icon(Icons.add),
      ),
      
      body: isGridView ? buildGridView() : buildListView(),
    );
  }

  Widget buildListView() {
    StudentManager studentManager = StudentManager();

    return ListView.builder(
        itemCount: studentManager.allStudents.length,
        itemBuilder: (context, index) {
          return StudentListWidget(studentManager.allStudents[index]);
        });
  }

  Widget buildGridView() {
    StudentManager studentManager = StudentManager();

    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 20, // Spacing between columns
          mainAxisSpacing: 20, // Spacing between rows
          childAspectRatio: 1,
        ),
        itemCount: studentManager.allStudents.length,
        itemBuilder: (context, index) {
          return StudentGridWidget(studentManager.allStudents[index]);
        });
  }
}
