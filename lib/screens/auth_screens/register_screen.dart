import 'package:flutter/material.dart';
import 'package:googleapis/servicecontrol/v2.dart';
import 'package:gradish/models/auth_models.dart';
import 'package:gradish/providers/firestore_provider.dart';
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
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Name"),
                    TextFormField(
                      controller: nameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please input a name";
                        } else {
                          return null;
                        }
                      },
                    ),
                    const Text("Email"),
                    TextFormField(
                      controller: emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please input a valid email";
                        } else {
                          return null;
                        }
                      },
                    ),
                    const Text("Paaword"),
                    TextFormField(
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
                    ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            RegisterRequest credentials = RegisterRequest(
                                email: emailController.text.trim(),
                                password: passwordController.text.trim(),
                                name: nameController.text.trim(),
                                confirmPassword: '');

                            await authData
                                .registerWithEmailAndPassword(credentials)
                                .then((value) {
                              if(authData.state == AppState.success){
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Successfully Registered")));
                              }

                              else if(authData.state == AppState.error){
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(firestoreData.errorMessage ?? "Failed to Register")));
                              }
                              if (authData.currentUser != null) {
                                firestoreData.addBasicUserInfo(
                                    name: nameController.text.trim(),
                                    currentUser: authData.currentUser!);
                              }
                            });
                          }
                        },
                        child: const Text("Register")),
                    ElevatedButton(
                        onPressed: () async {
                          await authData.signInWithGoogle();
                        },
                        child: const Text("Sign In With Google")),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
