import 'package:flutter/material.dart';
import 'package:gradish/providers/auth_provider.dart';
import 'package:gradish/providers/firestore_provider.dart';
import 'package:gradish/screens/create_course_screen/create_course_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer2<AuthProvider, FirestoreProvider>(
      builder: (context, authData, firestoreData, child) {
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
                IconButton(
                  icon: const Icon(Icons.settings),
                  onPressed: () {},
                ),
              ],
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 32,
                ),
                Text(
                  "Hello ${authData.currentUser?.displayName ?? authData.currentUser?.email},",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 100,
                ),
                Text("No activity yet"),
                SizedBox(height: 64),
                ElevatedButton(
                  onPressed: () {},
                  style: const ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll<Color>(Color(0xff3D3839)),
                  ),
                  child: const Text("Upload Class List",
                      style: TextStyle(
                          fontWeight: FontWeight.w200,
                          color: Color(0xffffc604))),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CreateCourseScreen()));
                  },
                  style: const ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll<Color>(Color(0xff3D3839)),
                  ),
                  child: const Text("Record Marks",
                      style: TextStyle(
                          fontWeight: FontWeight.w200,
                          color: Color(0xffffc604))),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => const ExtractScreen()),
                    // );
                  },
                  style: const ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll<Color>(Color(0xff3D3839)),
                  ),
                  child: const Text("Record ID info",
                      style: TextStyle(
                          fontWeight: FontWeight.w200,
                          color: Color(0xffffc604))),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async {
                    authData.logOut;
                  },
                  style: const ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll<Color>(Color(0xff3D3839)),
                  ),
                  child: const Text("logout",
                      style: TextStyle(
                          fontWeight: FontWeight.w200,
                          color: Color(0xffffc604))),
                )
              ],
            ));
      },
    );
  }
}
