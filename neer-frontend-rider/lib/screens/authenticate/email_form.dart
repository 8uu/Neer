import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:login/screens/authenticate/create_password.dart';
import 'package:login/theme/global.dart';

class EmailForm extends StatelessWidget {
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
            'Email Address',
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
                Image.asset('assets/email_form.png'),
                screenInstrucText,
                EmailValid(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget screenInstrucText = Container(
  padding: const EdgeInsets.all(30),
  child: new Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      new Text(
        'Enter your email address',
        textAlign: TextAlign.center,
        style: primaryText,
      ),
    ],
  ),
);

class EmailValid extends StatefulWidget {
  @override
  _EmailValidState createState() => _EmailValidState();
}

class _EmailValidState extends State<EmailValid> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String email = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 330,
      child: Form(
        autovalidate: true,
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Email',
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                    width: 2,
                  ),
                ),
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (email) {
                if (!EmailValidator.validate(email)) {
                  return 'Please enter a vaild email';
                }
              },
            ),
            new Container(
              width: 330.0,
              margin: EdgeInsets.only(top: 35),
              child: ButtonTheme(
                height: 50.0,
                child: FlatButton(
                  onPressed: () {
                    _formKey.currentState.validate();
                    if (!_formKey.currentState.validate()) {
                      return 'Please enter a valid email';
                    } else {
                      setState(
                        () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CreatePassword(),
                            ),
                          );
                        },
                      );
                    }

                    _formKey.currentState.save();
                  },
                  color: blueColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(90.0),
                  ),
                  child: Text(
                    'Next',
                    style: primaryText,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
