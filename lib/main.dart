import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:gestion_alumnos/provider/student_provider.dart';
import 'package:gestion_alumnos/screens/students_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => StudentProvider(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'App con BD de Estudiantes',
        home: StudentsScreen(),
      ),
    );
  }
}
