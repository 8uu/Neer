import 'package:flutter/material.dart';
import 'package:login/theme/global.dart';
import 'package:login/screens/landing_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double margin = 10.0;
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
        body: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
//              color: Colors.black.withOpacity(0.5),
            image: DecorationImage(
                image: AssetImage('assets/wallpaper.jpeg'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.5), BlendMode.multiply)),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                NeerLogo(),
                sloganText,
                LoginBox(),
                SizedBox(height: 10),
                socialLoginText,
                SocialLogins(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NeerLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 80),
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
    );
  }
}

Widget sloganText = Container(
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
);

Widget socialLoginText = Container(
  child: Text(
    'Or sign in using',
    style: TextStyle(
      fontSize: 15.0,
      fontWeight: FontWeight.w400,
      color: Colors.grey[100],
      fontFamily: 'Montserrat',
    ),
  ),
);

class LoginBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController accountController = TextEditingController();
    TextEditingController pwdController = TextEditingController();
    return Container(
//        decoration: BoxDecoration(
//          color: Colors.grey[100],
//          borderRadius: BorderRadius.circular(6.0),
//        ),
        width: 300,
        margin: EdgeInsets.only(top: 40),
        child: Column(
          children: <Widget>[
            LoginTextField(
              controller: accountController,
              icon: Icon(
                Icons.person,
                color: Colors.grey[300],
                size: 25.0,
              ),
              hintText: "Phone/Email",
              obs: false,
            ),
            LoginTextField(
              controller: pwdController,
              icon: Icon(
                Icons.lock,
                color: Colors.grey[300],
                size: 20.0,
              ),
              hintText: "Password",
              obs: true,
            ),
            LoginButton(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                LoginSignup(),
                LoginFpwd(),
              ],
            ),
          ],
        ));
  }
}

class LoginTextField extends StatelessWidget {
  const LoginTextField(
      {Key key,
      @required this.controller,
      @required this.icon,
      @required this.obs,
      @required this.hintText})
      : super(key: key);
  final TextEditingController controller;
  final Icon icon;
  final String hintText;
  final bool obs;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 300,
//          margin: EdgeInsets.all(15.0),
          child: TextField(
            controller: controller,
            obscureText: obs,
            style: TextStyle(
              color: Colors.grey[300],
              fontSize: 18.0,
            ),
            decoration: InputDecoration(
              enabledBorder: new UnderlineInputBorder(
                  borderSide: new BorderSide(color: Colors.grey[100])),
              prefixIcon: icon,
              hintText: hintText,
              hintStyle: TextStyle(
                color: Colors.grey[350],
                fontSize: 16.0,
              ),
            ),
//            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}

class LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 35),
      child: ButtonTheme(
        minWidth: 330.0,
        height: 50.0,
        child: FlatButton(
          onPressed: () {},
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
    );
  }
}

class LoginFpwd extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FlatButton(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onPressed: () {},
        child: Text(
          'Forgot password?',
          style: TextStyle(
              color: Colors.grey[100],
              fontSize: 16.0,
              fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}

class LoginSignup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FlatButton(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LandingPage(),
            ),
          );
        },
        child: Text(
          'Get started',
          style: TextStyle(
              color: Colors.grey[100],
              fontSize: 16.0,
              fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}

class SocialLogins extends StatelessWidget {
  final fbColor = const Color(0xFF3b5998);

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.only(top: 80),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          IconButton(
            iconSize: 70,
            onPressed: () {
              print("google pressed");
            },
            icon: Image(
              image: AssetImage(
                'assets/google_icon.png',
              ),
              color: null,
            ),
          ),
          IconButton(
            iconSize: 40,
            onPressed: () {
              print("facebook pressed");
            },
            icon: Image(
              image: AssetImage('assets/fb_logo.png'),
              color: fbColor,
            ),
          ),
        ],
      ),
    );
  }
}
