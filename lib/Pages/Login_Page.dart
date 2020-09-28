import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kitaplik/Services/firebase_auth.dart';
import '../Services/global_veriable.dart';
import 'Dashboard_Page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  void onGoogleSignIn(BuildContext context) async {
    FirebaseUser user = await handleSignIn();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => DashboardPage()));
    my_user = user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Kitaplığımı Eleştir"),
          leading: Text(""),
        ),
        body: Center(child: _signInButton(context)));
  }

  Widget _signInButton(context) {
    return OutlineButton(
      splashColor: Colors.grey,
      onPressed: () {
        onGoogleSignIn(context);
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.grey),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset("assets/images/google_logo.png",height: 35,),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Google ile devam et.',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
