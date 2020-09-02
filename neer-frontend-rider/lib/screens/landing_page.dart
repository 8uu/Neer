import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
// import 'package:apple_sign_in/apple_sign_in.dart';
import 'package:login/screens/login.dart';
import 'package:login/theme/global.dart';

import 'authenticate/phone_sign_up.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Montserrat',
        textTheme: TextTheme(
          bodyText1: TextStyle(
            fontSize: 16,
          ),
        ),
      ),
      home: Scaffold(
//      appBar: AppBar(
//        title: Text('NEER - taking your family neer and far'),
//        centerTitle: true,
//        backgroundColor: Colors.black,
//      ),
//      body: Center(
//        child: Image(
//          image: AssetImage('assets/background.png'),
//          fit: BoxFit.fill,
//          height: double.infinity,
//          width: double.infinity,
//        ),
//      ),
        body: Center(
          child: Stack(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
//              color: Colors.black.withOpacity(0.5),
                  image: DecorationImage(
                      image: AssetImage('assets/background.png'),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.6), BlendMode.multiply)),
                ),
              ),
              Container(
                alignment: Alignment.topCenter,
                margin: EdgeInsets.only(top: 60.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Text(
                        'neer',
                        style: TextStyle(
                          fontSize: 100.0,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 2.0,
                          color: Colors.grey[100],
                          fontFamily: 'Comfortaa-Variable',
                        ),
                      ),
                    ),
                    Container(
                      child: Text(
                        'Taking your family neer and far.',
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w400,
//                        letterSpacing: 2.0,
                          color: Colors.grey[100],
                          fontFamily: 'Montserrat',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    ButtonTheme(
                      minWidth: 330.0,
                      height: 50.0,
                      child: FlatButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PhoneSignUp(),
                            ),
                          );
                        },
                        color: blueColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(90.0),
                        ),
                        child: Text(
                          'Get Started with Mobile Number',
                          style: primaryText,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    ButtonTheme(
                      minWidth: 330.0,
                      height: 50.0,
                      child: FlatButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ),
                          );
                        },
                        color: blueColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(90.0),
                        ),
                        child: Text(
                          'Sign in',
                          style: primaryText,
                        ),
                      ),
                    ),
                    SizedBox(
                      // width: 10.0,
                      height: 100.0,
                    ),
                    Container(
                      width: 330.0,
                      height: 50.0,
                      child: AppleSignInButton(
                        onPressed: () {},
                        borderRadius: 90.0,
                        textStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      // width: 10.0,
                      height: 20.0,
                    ),
                    Container(
                      width: 330.0,
                      height: 50.0,
                      child: GoogleSignInButton(
                        onPressed: () {},
                        borderRadius: 90.0,
                        textStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        darkMode: true,
                      ),
                    ),
                    SizedBox(
                      // width: 10.0,
                      height: 20.0,
                    ),
                    // ButtonTheme(
                    //   minWidth: 330.0,
                    //   height: 50.0,
                    //   shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.circular(90.0),
                    //   ),
                    //   child: SignInButton(
                    //     Buttons.Google,
                    //     onPressed: () {},
                    //     text: googleButtonText,
                    //   ),
                    // ),
                    Container(
                      width: 330.0,
                      height: 50.0,
                      child: FacebookSignInButton(
                        onPressed: () {},
                        borderRadius: 90.0,
                        textStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    // ButtonTheme(
                    //   minWidth: 330.0,
                    //   height: 50.0,
                    //   shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.circular(90.0),
                    //   ),
                    //   child: SignInButton(
                    //     Buttons.Facebook,
                    //     onPressed: () {},
                    //     text: facebookButtonText,
                    //   ),
                    // ),
                    SizedBox(
                      // width: 10.0,
                      height: 20.0,
                    ),

                    SizedBox(
                      // width: 10.0,
                      height: 20.0,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Button extends StatelessWidget {
  const Button({Key key, @required this.text, @required this.path})
      : super(key: key);
  final String text;
  final String path;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320.0,
      child: FlatButton(
        onPressed: () {
          Navigator.pushNamed(context, path);
        },
        padding: EdgeInsets.symmetric(vertical: 15.0),
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(90.0),
        ),
        child: Text(
          text,
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}
