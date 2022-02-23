import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:http/http.dart' as http;

class facebook {
  final FirebaseAuth auth = FirebaseAuth.instance;
  FacebookLogin facebookLogin = FacebookLogin();

  void signInWithFacebook(BuildContext context) async {
    final result = await facebookLogin.logIn(permissions: [
      FacebookPermission.email,
      FacebookPermission.publicProfile,
    ]);

    final token = result.accessToken.token;
    final graphResponse = await http.get(
      Uri.parse(
        'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=$token',
      ),
    );

    print(graphResponse.body);

    if (result.status == FacebookLoginStatus.success) {
      final credential = FacebookAuthProvider.credential(token);
      await auth.signInWithCredential(credential);
      print('login successful');
      Navigator.popAndPushNamed(context, '/afterLogin');
    }
  }

  void logout(BuildContext context) async {
    await facebookLogin.logOut();
    FirebaseAuth.instance.signOut();
    Navigator.popAndPushNamed(context, '/main');
  }
}
