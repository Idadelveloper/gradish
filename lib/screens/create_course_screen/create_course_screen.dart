
import 'package:flutter/material.dart';
import 'package:googleapis/servicecontrol/v2.dart';
import 'package:gradish/core/enums.dart';
import 'package:gradish/models/auth_models.dart';
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
    return Consumer2 <AuthProvider, FirestoreProvider>(
      builder: (context, authData, firestoreData, child){
        return Scaffold(
          body: SafeArea(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const Text("Course Name"),
                  TextFormField(
                    controller: courseNameController,
                    validator: (value){
                      if(value == null || value.isEmpty){
                        return "Please input a valid course name";
                      } else{
                        return null;
                      }
                    },

                  ),
                  const Text("Course COde"),
                  TextFormField(
                    controller: courseCodeController,
                    validator: (value){
                      if(value == null || value.isEmpty){
                        return "Please input a valid course code";
                      } else{
                        return null;
                      }
                    },

                  ),
                  const Text("year"),
                  TextFormField(
                    controller: yearController,
                    validator: (value){
                      if(value == null || value.isEmpty){
                        return "Please input a valid course code";
                      } else{
                        return null;
                      }
                    },



                  ),

                  const Text("semester"),
                  TextFormField(
                    controller: semesterController,
                    keyboardType: TextInputType.number,
                    validator: (value){
                      if(value == null || value.isEmpty){
                        return "Please input a valid semester";
                      } else{
                        return null;
                      }
                    },

                  ),


                  ElevatedButton(onPressed: () async {


                    if(_formKey.currentState!.validate()){
                      GradeSheet gradeSheet = GradeSheet(courseName: courseNameController.text.trim(), courseCode: courseCodeController.text.trim(), year: yearController.text.trim(), semester: semesterController.text.trim());

                      if(authData.currentUser !=null){
                        firestoreData.addGradeSheet(currentUser: authData.currentUser!, gradeSheet: gradeSheet).then((value) {

                          if(firestoreData.state == AppState.success){
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Successfully Added GradeSheet")));
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const ExtractScreen()));
                          }

                         else if(firestoreData.state == AppState.error){
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(firestoreData.errorMessage ?? "Failed to Add GradeSheet")));
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const ExtractScreen()));
                          }


                        });
                      }

                    }


                  }, child: const Text("Create Course")),

                ],


              ),
            ),
          ),
        );
      },


    );
  }
}
