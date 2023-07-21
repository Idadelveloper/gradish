import 'package:flutter/material.dart';
import 'package:gradish/screens/create_course_screen/create_course_screen.dart';
import 'package:gradish/screens/home_screen.dart';

class GradishBottomNavigationBar extends StatefulWidget {
  const GradishBottomNavigationBar({Key? key}) : super(key: key);

  @override
  State<GradishBottomNavigationBar> createState() => _GradishBottomNavigationBarState();
}

class _GradishBottomNavigationBarState extends State<GradishBottomNavigationBar> {
  int _selectedScreenIndex = 0;
  final List _screens = [
    {"screen": const HomeScreen(), "title": "Home"},
    {"screen": const CreateCourseScreen(), "title": "Create Course"}
  ];

  void _selectScreen(int index) {
    setState(() {
      _selectedScreenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _selectedScreenIndex,
      onTap: _selectScreen,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.create), label: "Record Marks")
      ],
    );
  }
}
