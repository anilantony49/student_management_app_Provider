import 'dart:io';

import 'package:database_student/manager/student_manager.dart';
import 'package:flutter/material.dart';

class MyPopupMenuButton extends StatefulWidget {
  const MyPopupMenuButton({super.key});

  @override
  State<MyPopupMenuButton> createState() => _MyPopupMenuButtonState();
}

class _MyPopupMenuButtonState extends State<MyPopupMenuButton> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      color: !StudentManager().isDark ? const Color.fromARGB(255, 85, 78, 78): null,
      // color: !myProvider.isDark ? Colors.blue[200] : null,
      itemBuilder: (context) => [
       
        // const PopupMenuItem(child: Text('About')),
        PopupMenuItem(
            onTap: () => exit(0),
            child: const Text('Exit'))
      ],
    );
  }
}
