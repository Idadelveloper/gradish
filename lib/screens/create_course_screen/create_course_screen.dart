import 'package:flutter/material.dart';
import 'package:gradish/components/appBar.dart';
import 'package:gradish/components/bottomNavBar.dart';
import 'package:gradish/core/enums.dart';
import 'package:gradish/models/grade_sheet_model.dart';
import 'package:gradish/providers/firestore_provider.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';
import '../extract_screen.dart';

class CreateCourseScreen extends StatefulWidget {
  const CreateCourseScreen({Key? key}) : super(key: key);

  @override
  State<CreateCourseScreen> createState() => _CreateCourseScreenState();
}

class _CreateCourseScreenState extends State<CreateCourseScreen> {
  TextEditingController courseNameController = TextEditingController();
  TextEditingController courseCodeController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  TextEditingController semesterController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    courseCodeController.dispose();
    courseNameController.dispose();
    semesterController.dispose();
    yearController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<AuthProvider, FirestoreProvider>(
      builder: (context, authData, firestoreData, child) {
        return Scaffold(
          appBar: GradishAppBar(title: "Create Course", authData: authData),
          bottomNavigationBar: GradishBottomNavigationBar(),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  color: Colors.yellow[200],
                  width: 200,
                  height: 200,
                  alignment: Alignment.center,
                  child: Image.asset('images/illustrations/virtual_man_laptop.jpg'),
                ),
                SafeArea(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                     margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    height: MediaQuery.of(context).size.height,
                     child: SingleChildScrollView(
                       child: Form(
                          key: _formKey,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextFormField(
                                  decoration: InputDecoration(
                                    focusColor: Colors.yellow,
                                    labelText: "Course Name"
                                  ),
                                  controller: courseNameController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Please input a valid course name";
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                                SizedBox(height: 10,),
                                TextFormField(
                                  decoration: InputDecoration(
                                      focusColor: Colors.yellow,
                                      labelText: "Course Code"
                                  ),
                                  controller: courseCodeController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Please input a valid course code";
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                                SizedBox(height: 10,),
                                TextFormField(
                                  decoration: InputDecoration(
                                      focusColor: Colors.yellow,
                                      labelText: "Academic Year"
                                  ),
                                  controller: yearController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Please input a valid course code";
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                                SizedBox(height: 10,),
                                TextFormField(
                                  decoration: InputDecoration(
                                      focusColor: Colors.yellow,
                                      labelText: "Semester"
                                  ),
                                  controller: semesterController,
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Please input a valid semester";
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                                SizedBox(height: 16),
                                ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(Colors.yellow)
                                  ),
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        GradeSheet gradeSheetNoId = GradeSheet(
                                          courseName: courseNameController.text.trim(),
                                          courseCode: courseCodeController.text.trim(),
                                          year: yearController.text.trim(),
                                          semester: semesterController.text.trim(),
                                        );

                                        if (authData.currentUser != null) {
                                          firestoreData
                                              .addGradeSheet(
                                                  currentUser: authData.currentUser!,
                                                  gradeSheet: gradeSheetNoId)
                                              .then((value) {
                                            if (firestoreData.state == AppState.success) {
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                  const SnackBar(
                                                      content: Text(
                                                          "Successfully Added GradeSheet")));
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) => ExtractScreen(
                                                            gradeSheet: firestoreData.gradeSheets.last,
                                                          )));
                                            } else if (firestoreData.state ==
                                                AppState.error) {
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                  SnackBar(
                                                      content: Text(
                                                          firestoreData.errorMessage ??
                                                              "Failed to Add GradeSheet")));

                                            }

                                          });
                                        }
                                      }
                                    },
                                    child: const Text("Create Course")),
                              ],
                            ),
                          ),
                        ),
                     ),

                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
