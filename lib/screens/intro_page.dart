import 'package:eccomercelive/screens/home/home_screen.dart';
import 'package:connectivity/connectivity.dart';
import 'package:eccomercelive/screens/login_page.dart';
import 'package:eccomercelive/utils/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/auth_page.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // logo
            Icon(Icons.trolley,
            size: 50,
            color: Theme.of(context).colorScheme.inversePrimary,
            ),
            const SizedBox(height: 25,),

            // title
            Text("Ecommerce App",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
            ),
            const SizedBox(height: 15,),
      
            // subtitle
            Text("Get Started",
            style: TextStyle(
              color: Theme.of(context).colorScheme.inversePrimary
            ),),
            const SizedBox(height: 15,),
      
            // button
            MyButton(
              child: const Icon(Icons.arrow_forward),
              onTap: () async {
               var connectivityResult = await Connectivity().checkConnectivity();
                if (connectivityResult == ConnectivityResult.none) {
                  // If not connected, show a SnackBar
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      duration: Duration(seconds: 4),
                      content: Text('Please connect to the internet.'),
                    ),
                  );
                } else {
                  // If connected, navigate to HomeScreen
                  Get.to(AuthPage());
                  //Get.to(HomeScreen());
                   ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      duration: Duration(seconds: 4),
                      backgroundColor: Colors.teal,
                      content: Text('Welcome!'),
                    ),
                  );
                }
              },
            ),
          ],),
      ),
    );
  }
}