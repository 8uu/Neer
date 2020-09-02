import 'package:flutter/material.dart';
import 'package:login/screens/authenticate/name_registration.dart';
import 'package:login/theme/global.dart';

class CreatePassword extends StatefulWidget {
  @override
  _CreatePasswordState createState() => _CreatePasswordState();
}

class _CreatePasswordState extends State<CreatePassword> {
  String _password;
  String _confirmPassword;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();

  Widget _createPwdText() {
    return Container(
      padding: const EdgeInsets.all(30),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          new Text(
            'Create your password',
            textAlign: TextAlign.center,
            style: primaryText,
          ),
          new SizedBox(
            height: 15,
          ),
          new Text(
            'Must contain at least 8 characters, 1 uppercase, 1 lowercase, and 1 number',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: darkPurpleColor,
              fontWeight: FontWeight.w600,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildPwdField() {
    return Container(
      width: 300,
      child: Column(
        children: <Widget>[
          TextFormField(
            obscureText: true,
            controller: _pass,
            keyboardType: TextInputType.visiblePassword,
            decoration: const InputDecoration(
              labelText: 'Password',
              hintText: 'Enter password',
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black,
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black,
                  width: 2,
                ),
              ),
            ),
            validator: (password) {
              Pattern pattern =
                  r'^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?!.*\s).{8,}$';
              RegExp regex = new RegExp(pattern);
              if (password.isEmpty) {
                return 'Please enter password';
              }
              if (!regex.hasMatch(password)) {
                return 'Does not contain required characters';
              }
              return null;
            },
            onSaved: (String value) {
              _password = value;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildConfirmPwdField() {
    return Container(
      width: 300,
      child: Column(
        children: <Widget>[
          TextFormField(
            obscureText: true,
            controller: _confirmPass,
            keyboardType: TextInputType.visiblePassword,
            decoration: const InputDecoration(
              labelText: 'Confirm Password',
              hintText: 'Enter password again',
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
            validator: (String value) {
              if (value.isEmpty) {
                return 'Please re-enter password';
              }
              if (value != _pass.text) {
                return 'Password must match';
              }
              return null;
            },
            onSaved: (String value) {
              _confirmPassword = value;
            },
          ),
        ],
      ),
    );
  }

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
            'Create Password',
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
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Image.asset('assets/create_password.png'),
                  _createPwdText(),
                  _buildPwdField(),
                  _buildConfirmPwdField(),
                  new Container(
                    width: 330.0,
                    margin: EdgeInsets.fromLTRB(0, 25.0, 0, 25.0),
                    child: ButtonTheme(
                      height: 50.0,
                      child: FlatButton(
                        onPressed: () {
                          if (!_formKey.currentState.validate()) {
                            return;
                          } else {
                            setState(
                              () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => NameRegistration(),
                                  ),
                                );
                              },
                            );
                          }
                          _formKey.currentState.save();

                          print(_password);
                          print(_confirmPassword);
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
          ),
        ),
      ),
    );
  }
}
