import 'package:flutter/material.dart';
import 'package:login/screens/payment/payment_method.dart';
import 'package:login/theme/global.dart';

class SignupConfirmation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Montserrat'),
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: blueColor,
          title: Text(
            'Almost done!',
            style: primaryText,
          ),
          leading: new IconTheme(
            data: new IconThemeData(
              color: Colors.black,
            ),
            child: new IconButton(
              icon: new Icon(
                Icons.arrow_back_ios,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Image.network(
                    'https://media.giphy.com/media/26FL4fdR9oRs2tdEA/giphy.gif'),
                screenText,
                new Container(
                  width: 330,
                  margin: EdgeInsets.fromLTRB(0, 25, 0, 25),
                  child: ButtonTheme(
                    height: 50,
                    child: FlatButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PaymentMethod(),
                          ),
                        );
                      },
                      color: blueColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(90),
                      ),
                      child: Text(
                        'Done',
                        style: primaryText,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget screenText = Container(
  padding: const EdgeInsets.all(30),
  child: new Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      new Text(
        'Woohoo! You are signed up!',
        style: primaryText,
      )
    ],
  ),
);
