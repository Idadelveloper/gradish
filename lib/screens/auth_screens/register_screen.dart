
import 'package:flutter/material.dart';
import 'package:googleapis/servicecontrol/v2.dart';
import 'package:gradish/models/auth_models.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
          body: SafeArea(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const Text("Email"),
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
                  const Text("Paaword"),
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
                      RegisterRequest credentials= RegisterRequest(email: emailController.text.trim(), password: passwordController.text.trim(), name: '', confirmPassword: '');
          
                      await authData.registerWithEmailAndPassword(credentials);
          
                    }
          
          
          
                  }, child: const Text("Login")),
               
                     ElevatedButton(onPressed: () async {
          
            
          
                      await authData.signInWithGoogle();
          
          
             
          
          
                  }, child: const Text("Sign In With Google")),
                
                ],
          
          
              ),
            ),
          ),
        );
      },


    );
  }
}
