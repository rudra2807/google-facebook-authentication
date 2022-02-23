import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:krsik_info_sm/afterLogIn.dart';
import 'package:krsik_info_sm/services/facebookSignIn.dart';
import 'package:provider/provider.dart';
import 'services/googleSignIn.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

bool isSigningIn = false;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      routes: {
        '/afterLogin': (context) => afterLogIn(),
        '/main': (context) => LoginPage(),
      },
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPage createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isSigningIn = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(children: [
        Align(
          alignment: Alignment.center,
          // top: 0,
          // right: 0,
          // bottom: 0,
          // left: 0,
          // height: 2.0,
          // width: 2.0,
          child: isSigningIn ? CircularProgressIndicator() : Text(''),
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Login',
                style: TextStyle(fontSize: 35.0),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SignInButton(
                Buttons.Google,
                text: "Sign up with Google",
                onPressed: () async {
                  setState(() {
                    isSigningIn = true;
                  });
                  final provider = GoogleSignInProvider();
                  await provider.login(context);
                },
              ),
              SignInButton(
                Buttons.FacebookNew,
                text: "Continue with Facebook",
                onPressed: () {
                  final provider = facebook();
                  provider.signInWithFacebook(context);
                  setState(() {
                    isSigningIn = true;
                  });
                },
              )
            ],
          ),
        ),
      ]),
    );
  }
}
