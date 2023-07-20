import 'package:flutter/material.dart';
import 'package:gradish/models/auth_models.dart';
import 'package:gradish/screens/auth_screens/register_screen.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authData, child) {
        return Scaffold(
          appBar: AppBar(),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
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
                            LoginRequest credentials = LoginRequest(
                                email: emailController.text.trim(),
                                password: passwordController.text.trim());

                            await authData
                                .signInWithEmailAndPassword(credentials);
                          }
                        },
                        child: const Text("Login")),
                    const Text("Don't yet have an account? "),
                    InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const RegisterScreen()));
                        },
                        child: Text("Register",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor))),
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
