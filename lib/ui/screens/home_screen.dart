import 'package:database_student/data_repository/dbHelper.dart';
import 'package:database_student/manager/student_manager.dart';
import 'package:database_student/ui/screens/search_student_screen.dart';
import 'package:database_student/ui/screens/widgets/popup_menu_button.dart';
import 'package:database_student/ui/screens/widgets/student_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _MainStudentScreenState();
}

class _MainStudentScreenState extends State<HomeScreen> {
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
        title: const Text('Students List'),
        actions: [
          InkWell(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) =>
                      SearchStudentScreen(students: studentManager.allStudents)),
            ),
            child: Icon(Icons.search),
          ),
          IconButton(onPressed: () {}, icon: Icon(Icons.grid_view)),
          MyPopupMenuButton()
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(context, '/new_student_screen');
          Navigator.pushReplacementNamed(context, '/main_screen');
        },
        child: const Icon(Icons.add),
      ),
      // drawer: Drawer(
      //   backgroundColor: !recipeManager.isDark ? Colors.blue[200] : null,
      //   child: DrawerList(),
      // ),
      body: ListView.builder(
          itemCount: studentManager.allStudents.length,
          itemBuilder: (context, index) {
            return StudentWidget(studentManager.allStudents[index]);
          }),
    );
  }
}
