import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:krsik_info_sm/services/facebookSignIn.dart';
import 'package:krsik_info_sm/services/googleSignIn.dart';
import 'package:provider/provider.dart';

class afterLogIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    print((user == null).toString());
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('logged in succesfully'),
            Text(user.email),
            Text(user.displayName),
            SignInButton(
              Buttons.Google,
              text: "logout",
              onPressed: () {
                final provider = GoogleSignInProvider();
                provider.logout(context);
              },
            ),
            SignInButton(
              Buttons.FacebookNew,
              text: "logout",
              onPressed: () {
                final provider = facebook();
                provider.logout(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
