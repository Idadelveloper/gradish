import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gradish/components/bottomNavBar.dart';
import 'package:gradish/providers/auth_provider.dart';
import 'package:gradish/providers/firestore_provider.dart';
import 'package:gradish/screens/create_course_screen/create_course_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
  // final User user;

  // Future<User?> getFirestoreData(FirestoreProvider? firestoreData, AuthProvider? authData) async {
  //   final User user = await firestoreData.gradeSheets;
  //
  //   return user;
  // }

}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer2<AuthProvider, FirestoreProvider>(
      builder: (context, authData, firestoreData, child) {
        // final User? user = authData.currentUser;
        final List<String> courses = ["Computer Graphics", "Computer Forensics", "Visual Media Compression and Processing", "Computer Vision", "Parallel and Distributed Computing Systems", "In formation Retrieval", "Simulation and Modelling", "Entrepreneurship", "Research Methodology"];
        final List<String> courseCodes = ["COME5101", "COME5102", "COME5103", "COME5104", "COME5105", "COME5106", "COME5107", "COME5108", "COME5109"];
        print(firestoreData.gradeSheets);
        return Scaffold(
            appBar: AppBar(
              backgroundColor: const Color(0xffffc604),
              centerTitle: true,
              title: IconButton(
                onPressed: null,
                icon: Image.asset('images/logo/logo-black.png'),
                iconSize: 10,
              ),
              leading: IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {},
              ),
              actions: [
                PopupMenuButton(
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      child: GestureDetector(
                        onTap: () async {
                          authData.logOut;
                        },
                        child: const Row(
                          children: [
                            Icon(Icons.logout),
                            Text("Logout")
                          ],
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
            body: content(firestoreData.gradeSheets, courses, courseCodes),
          bottomNavigationBar: GradishBottomNavigationBar(),
        );
      },
    );
  }

  Widget content(List fireStoreData, List courses, List courseCodes) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            // width: double.infinity,
            // height: 100,
            decoration: BoxDecoration(
              color: Colors.amber[200],
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Center(
              child: Column(
                children: [
                  Text(
                    "Hello Ida",
                    style: TextStyle(fontSize: 30),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                        "Select an action below to record your student marks or their ID info",
                      style: TextStyle(

                      ),
                    ),
                  )
                ],

              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Choose an action",
            style: TextStyle(
              fontSize: 20
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.all(
                10
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap:() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CreateCourseScreen()));
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10.0),
                      padding: const EdgeInsets.only(
                        left: 20
                      ),
                      height: 100,
                      width: 200,
                      decoration: BoxDecoration(
                        color: Colors.yellow[100],
                        borderRadius: BorderRadius.circular(15.0),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 1),
                            blurRadius: 5,
                            color: Colors.black.withOpacity(0.3),
                          ),
                        ],
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.description, size: 30,),
                          Text(
                            "Record Marks",
                            style: TextStyle(
                              fontSize: 18
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap:() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CreateCourseScreen()));
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10.0),
                      padding: const EdgeInsets.only(
                          left: 20
                      ),
                      height: 100,
                      width: 200,
                      decoration: BoxDecoration(
                        color: Colors.yellow[100],
                        borderRadius: BorderRadius.circular(15.0),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 1),
                            blurRadius: 5,
                            color: Colors.black.withOpacity(0.3),
                          ),
                        ],
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.upload_file, size: 30,),
                          Text(
                            "Upload Classlist",
                            style: TextStyle(
                                fontSize: 18
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Record History",
            style: TextStyle(
              fontSize: 20
            ),
          ),
          Flexible(
            child: fireStoreData.isNotEmpty
                ? const Text("There is data")
                : ListView.builder(
              itemCount: 9,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) => Card(
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Container(
                  // width: MediaQuery.of(context).size.width,
                  // padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 200,
                                  child: Text(
                                    courses[index],
                                    style: const TextStyle(
                                        fontSize: 18.0
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 5,),
                                Text(
                                  courseCodes[index],
                                  style: TextStyle(
                                      color: Colors.grey
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              IconButton(onPressed: (){}, icon: const Icon(Icons.edit)),
                              IconButton(onPressed: (){}, icon: const Icon(Icons.delete)),
                            ],
                          )
                        ],
                      ),
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: (){},
                              style: const ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(Colors.yellow)
                              ),
                              child: const Text("Get Gradesheet", style: TextStyle(fontSize: 10),),
                            ),
                            ElevatedButton(
                              onPressed: (){},
                              style: const ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(Colors.yellow)
                              ),
                              child: const Text("Continue Scanning", style: TextStyle(fontSize: 10),),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          )
        ],
      ),
    );
  }
}
