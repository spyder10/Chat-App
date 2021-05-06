import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/class-RoundButton.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email;
  String password;
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Flexible(
              child: Container(
                height: 200,
                child: Image.asset('images/logo.png'),
              ),
            ),
            SizedBox(
              height: 48.0,
            ),
            TextField(
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email = value;
                },
                decoration:
                    kEnterDetailsButton.copyWith(hintText: 'Enter your Email')),
            SizedBox(
              height: 8.0,
            ),
            TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  password = value;
                },
                decoration: kEnterDetailsButton.copyWith(
                    hintText: 'Enter your password')),
            SizedBox(
              height: 24.0,
            ),
            RoundButton(
                text: 'Log In',
                onPressed: () async {
                  try {
                    await _auth.signInWithEmailAndPassword(
                        email: email, password: password);
                    User user = _auth.currentUser;
                    if (user != null) {
                      print('User is signed in');
                      Navigator.pushNamed(context, ChatScreen.id);
                    }
                  } catch (error) {
                    print('User is not signed in...Try Again ');
                    Alert(
                      context: context,
                      title: 'Incorrect Credentials',
                      desc: 'Either username or password is not correct',
                      buttons: [
                        DialogButton(
                          child: Text(
                            'Try Again',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          onPressed: () {
                            setState(() {
                              Navigator.pop(context);
                            });
                          },
                          width: 120,
                        )
                      ],
                    ).show();
                  }
                })
          ],
        ),
      ),
    );
  }
}
