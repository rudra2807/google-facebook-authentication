import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInProvider {
  final googleSignIn = GoogleSignIn();

  Future login(BuildContext context) async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    final user = await googleSignIn.signIn();
    if (user == null) {
      return;
    } else {
      final googleAuth = await user.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await firebaseAuth.signInWithCredential(credential);
      Navigator.popAndPushNamed(context, '/afterLogin');
    }
  }

  void logout(BuildContext context) async {
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
    Navigator.popAndPushNamed(context, '/main');
  }
}
