import 'package:flutter/material.dart';
import 'package:gradish/providers/auth_provider.dart';
import 'package:gradish/screens/create_course_screen/create_course_screen.dart';
import 'package:gradish/screens/scan_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authData, child){
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
          children: [
            const SizedBox(
              height: 50,
              child: Text(
                "Hello Ida,",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            const SizedBox(
              height: 100,
              child: Center(
                child: Text("No activity yet"),
              ),
            ),
            SizedBox(
              child: Column(
                children: [
                   ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ExtractScreen()),
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll<Color>(Color(0xff3D3839)),
                    ),
                    child: Text(
                      "Upload Class List",
                      style: TextStyle(
                        fontWeight: FontWeight.w200,
                        color: Color(0xffffc604))
                      ),
                  ),
                   ElevatedButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> CreateCourseScreen()));
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll<Color>(Color(0xff3D3839)),
                    ),
                    child: Text(
                        "Record Marks",
                        style: TextStyle(
                            fontWeight: FontWeight.w200,
                            color: Color(0xffffc604))
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ExtractScreen()),
                      );
                    },
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll<Color>(Color(0xff3D3839)),
                    ),
                    child: const Text(
                        "Record ID info",
                        style: TextStyle(
                            fontWeight: FontWeight.w200,
                            color: Color(0xffffc604))
                    ),
                  )
                ,
                  ElevatedButton(
                    onPressed: () async {
                   authData.logOut;
                    },
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll<Color>(Color(0xff3D3839)),
                    ),
                    child: const Text(
                        "logout",
                        style: TextStyle(
                            fontWeight: FontWeight.w200,
                            color: Color(0xffffc604))
                    ),
                  )
           
                ],
              ),
            )
          ],
        )
      );
    
      },
    );
  }
}
