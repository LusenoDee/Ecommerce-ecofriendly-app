import 'package:eccomercelive/screens/home/home_screen.dart';
import 'package:eccomercelive/screens/login_page.dart';
import 'package:eccomercelive/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/custom_button.dart';
import '../utils/custom_text_field.dart';
import '../utils/square_tile.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
   RegisterPage({
    super.key,
    required this.onTap
    });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final username = TextEditingController();

  final password = TextEditingController();
  final confirmPasword = TextEditingController();

  // sign in user
  void registerUser( ) async {
    //bool? success;
    showDialog(context: context, builder: (context) {
      return Center(child: CircularProgressIndicator(),);
    });
    try {

      if (password.text == confirmPasword.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: username.text, 
        password: password.text);
        Get.snackbar('Success!', 'Registration Successful');
       
      } else {
        Get.snackbar('Error!', 'Password did not match!');
      }
      
      


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
                  size: 50,
                  ),
              ),
        
        
              const SizedBox(height: 15,),
              Text(
                "Let's create an account for you!",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
                ),
        
                const SizedBox(height: 45,),
              
              // username textfield
              CustomTextField(
                controller: username,
                hintText: 'Enter your email',
                obscureText: false,
              ),
        
              const SizedBox(height: 18,),
              
              // password
              CustomTextField(
                controller: password,
                hintText: 'Create Password',
                obscureText: true,
              ),
        
              const SizedBox(height: 18,),

              CustomTextField(
                controller: confirmPasword,
                hintText: 'Confirm Password',
                obscureText: true,
              ),
        
              //const SizedBox(height: 18,),
        
              //forgot password 
            /*   Padding(
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
              */ const SizedBox(height: 35,),
              
              // signin button
              CustomButton(
                onTap: registerUser,
                text: 'Register',
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
                  SquareTile(imagePath: 'assets/imgs/google.png', onTap: () => AuthService().signInWithGoogle(),),
        
                  SizedBox(width: 25,),
        
                  SquareTile(imagePath: 'assets/imgs/apple.png', onTap: () {  },),
                ],
              ),
        
              const SizedBox(height: 18,),
              
              // register now
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Already a member?'),
                  const SizedBox(width: 5,),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: Text('Click here to login', style: TextStyle(color: Colors.blue),))
                ],
              ),
              const SizedBox(height: 18,),
            ],
          ),
        ),
      ),
    );
  }
}