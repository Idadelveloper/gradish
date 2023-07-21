import 'package:flutter/material.dart';
import 'package:gradish/models/auth_models.dart';
import 'package:gradish/providers/firestore_provider.dart';
import 'package:gradish/screens/auth_screens/login_screen.dart';
import 'package:provider/provider.dart';

import '../../core/enums.dart';
import '../../providers/auth_provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<AuthProvider, FirestoreProvider>(
      builder: (context, authData, firestoreData, child) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  child: Image.asset('images/logo/logo-color.png', width: 200),
                ),
                const Text(
                  "Register",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            decoration: const InputDecoration(
                                focusColor: Colors.yellow, labelText: "Name"),
                            controller: nameController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please input a name";
                              } else {
                                return null;
                              }
                            },
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                                focusColor: Colors.yellow,
                                labelText: "Email Address"),
                            controller: emailController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please input a valid email";
                              } else {
                                return null;
                              }
                            },
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                                focusColor: Colors.yellow,
                                labelText: "Password"),
                            controller: passwordController,
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please input a valid password";
                              } else {
                                return null;
                              }
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: ElevatedButton(
                                style: const ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(
                                        Colors.yellow)),
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    RegisterRequest credentials =
                                        RegisterRequest(
                                            email: emailController.text.trim(),
                                            password:
                                                passwordController.text.trim(),
                                            name: nameController.text.trim(),
                                            confirmPassword: '');

                                    await authData
                                        .registerWithEmailAndPassword(
                                            credentials)
                                        .then((value) {
                                      if (authData.state == AppState.success) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content: Text(
                                                    "Successfully Registered")));
                                      } else if (authData.state ==
                                          AppState.error) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(firestoreData
                                                        .errorMessage ??
                                                    "Failed to Register")));
                                      }
                                      if (authData.currentUser != null) {
                                        firestoreData
                                            .addBasicUserInfo(
                                                name:
                                                    nameController.text.trim(),
                                                currentUser:
                                                    authData.currentUser!)
                                            .then((value) =>
                                                Navigator.pop(context));
                                      }
                                    });
                                  }
                                },
                                child: const Text("Register")),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          const Center(
                              child: Text("Already have an account? ")),
                          Center(
                            child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginScreen()));
                                },
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor),
                                )),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Center(
                            child: ElevatedButton(
                                style: const ButtonStyle(),
                                onPressed: () async {
                                  await authData.signInWithGoogle();
                                },
                                child: const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ImageIcon(
                                        size: 20,
                                        AssetImage('images/google.png')),
                                    Text("Sign In With Google"),
                                  ],
                                )),
                          ),
                        ],
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
