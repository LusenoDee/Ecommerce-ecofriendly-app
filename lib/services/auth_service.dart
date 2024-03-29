import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  signInWithGoogle () async {
    try {
      // begin sign in
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();


    // get auth details from request
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;
    

    // create new credential for user
    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken
    );

    // sign in
    return await FirebaseAuth.instance.signInWithCredential(credential);
    
    } catch (e) {
      Get.snackbar('Something Went Wrong!', e.toString());
    }
  }
}