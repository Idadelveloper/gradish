
import 'package:flutter/material.dart';
import 'package:googleapis/servicecontrol/v2.dart';
import 'package:gradish/models/auth_models.dart';
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
      builder: (context, authData, child){
        return Scaffold(
          body: Form(
            key: _formKey,
            child: Column(
              children: [
                Text("Email"),
                TextFormField(
                  controller: emailController,
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return "Please input a valid email";
                    } else{
                      return null;
                    }
                  },

                ),
                Text("Paaword"),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return "Please input a valid password";
                    } else{
                      return null;
                    }
                  },

                ),

                ElevatedButton(onPressed: () async {

                  if(_formKey.currentState!.validate()){
                    LoginRequest credentials= LoginRequest(email: emailController.text.trim(), password: passwordController.text.trim());

                    await authData.signInWithEmailAndPassword(credentials);


                  }

                }, child: Text("Login")),
              ],


            ),
          ),
        );
      },


    );
  }
}
