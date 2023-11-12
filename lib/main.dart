import 'package:database_student/data_repository/dbHelper.dart';
import 'package:database_student/manager/student_manager.dart';
import 'package:database_student/ui/screens/home_screen.dart';
import 'package:database_student/ui/screens/new_student_screen.dart';
import 'package:database_student/ui/screens/splash_screen.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DbHelper.dbHelper.initDatabase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const InitApp();
  }
}

class InitApp extends StatefulWidget {
  const InitApp({super.key});

  @override
  _InitAppState createState() => _InitAppState();
}

class _InitAppState extends State<InitApp> {
  @override
  void initState() {
    StudentManager().getRecipes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: StudentManager().isDark
          ? ThemeData.dark()
          : ThemeData(
            
              scaffoldBackgroundColor: const Color(0xFF596157),
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple,),
              useMaterial3: true,
            ),
      title: 'Student database app',
      home: const SplashScreen(),
      routes: {
        '/new_student_screen': (context) => const NewStudentScreen(),
        '/main_screen': (context) => const HomeScreen(),
      },
    );
  }
}
