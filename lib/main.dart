import 'package:database_student/data_repository/dbHelper.dart';
import 'package:database_student/manager/student_manager.dart';
import 'package:database_student/ui/screens/home_screen.dart';
import 'package:database_student/ui/screens/new_and_edit_student_screen.dart';
import 'package:database_student/ui/screens/search_student_screen.dart';
import 'package:database_student/ui/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await DbHelper.dbHelper.initDatabase();
  await initializeDatabase();
  runApp(const MyApp());
}

Future<void> initializeDatabase() async {
  await Future.delayed(Duration
      .zero); // Delay execution to allow scheduling in background isolate
  await DbHelper.dbHelper.initDatabase();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => StudentManager()),
        ChangeNotifierProvider(create: (context) => SearchStudentProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xFF596157),
          // colorScheme: ColorScheme.fromSeed(
          //   // seedColor: Colors.deepPurple,
          // ),
          // useMaterial3: true,
        ),
        title: 'Student database app',
        home: const SplashScreen(),
        routes: {
          '/new_student_screen': (context) => const NewAndEditStudentScreen(
                isEditing: false,
              ),
          '/main_screen': (context) => const HomeScreen(),
        },
      ),
    );
  }
}
