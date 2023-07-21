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
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  child: Image.asset('images/logo/logo-color.png', width: 200),
                ),
                // Container(
                //   // color: Colors.yellow[200],
                //   width: 250,
                //   height: 200,
                //   alignment: Alignment.center,
                //   child: Image.asset('images/illustrations/login.jpg'),
                // ),
                const Text(
                  "Login",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
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
                          SizedBox(
                            height: 20,
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
                            style: const ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll(Colors.yellow)),
                            child: const Text("Login"),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          const Text("Don't yet have an account? "),
                          InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const RegisterScreen()));
                              },
                              child: Text(
                                "Register",
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor),
                              )),
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
