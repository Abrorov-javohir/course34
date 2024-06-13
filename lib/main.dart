import 'package:course/screens/course_screen.dart';
import 'package:course/view_model/course_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => CoursesViewModel(),
      child: MaterialApp(
        title: 'Kurslar',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: CourseScreen(),
      ),
    );
  }
}