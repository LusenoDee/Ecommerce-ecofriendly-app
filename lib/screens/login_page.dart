import 'package:eccomercelive/screens/register_page.dart';
import 'package:eccomercelive/utils/custom_text_field.dart';
import 'package:eccomercelive/utils/square_tile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/auth_service.dart';
import '../utils/custom_button.dart';
import 'home/home_screen.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
   const LoginPage({
    super.key,
    required this.onTap
    });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final username = TextEditingController();

  final password = TextEditingController();
  

  // sign in user
  void signInUser( ) async {
    //bool? success;
    showDialog(context: context, builder: (context) {
      return Center(child: CircularProgressIndicator(),);
    });
    try {
      
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: username.text, 
        password: password.text);
        //Get.to(HomeScreen());
        Get.snackbar('Success!', 'Login Successful');

        

//Navigator.pop(context);
//Get.to(HomeScreen());
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Failed!', e.toString(), duration: Duration(seconds: 5));
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // logo
              const Center(
                child: Icon(
                  Icons.lock_outline,
                  size: 100,
                  ),
              ),
        
        
              const SizedBox(height: 15,),
              Text(
                'Welcome back!',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
                ),
        
                const SizedBox(height: 45,),
              
              // username textfield
              CustomTextField(
                controller: username,
                hintText: 'Username',
                obscureText: false,
              ),
        
              const SizedBox(height: 18,),
              
              // password
              CustomTextField(
                controller: password,
                hintText: 'Password',
                obscureText: true,
              ),
        
              const SizedBox(height: 18,),
        
              //forgot password 
               Padding(
                 padding: const EdgeInsets.symmetric(horizontal: 25),
                 child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                   children: [
                     Text('Forgot Password?',
                           style: TextStyle(
                      color: Colors.grey[600]
                           ),
                           ),
                   ],
                 ),
               ),
               const SizedBox(height: 35,),
              
              // signin button
              CustomButton(
                onTap: signInUser,
                text: 'Sign In',
              ),
        
              const SizedBox(height: 18,),
              
              // continue with btn for fother sign in methods
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  children: [
                    Expanded(child: Divider(
                      thickness: 0.5,
                      color: Colors.grey[400],
                    )),
                    Padding(padding: const EdgeInsets.symmetric(horizontal: 10), 
                    child: Text('Or Continue with',
                    style: TextStyle(color: Colors.grey[700]),
                    ),),
                    Expanded(child: Divider(
                      thickness: 0.5,
                      color: Colors.grey[400],
                    )),
                  ],
                ),
              ),
        
              const SizedBox(height: 18,),
              
              // ggoogle + appe
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SquareTile(imagePath: 'assets/imgs/google.png', onTap: () => AuthService().signInWithGoogle()),
        
                  SizedBox(width: 25,),
        
                  SquareTile(imagePath: 'assets/imgs/apple.png', onTap: () {  },),
                ],
              ),
        
              const SizedBox(height: 18,),
              
              // register now
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Not a member?'),
                  const SizedBox(width: 5,),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: Text('Register now', style: TextStyle(color: Colors.blue),))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}