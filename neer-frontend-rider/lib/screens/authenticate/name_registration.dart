import 'package:flutter/material.dart';
import 'package:login/screens/authenticate/signup_confirmation.dart';
import 'package:login/theme/global.dart';

class NameRegistration extends StatefulWidget {
  @override
  _NameRegistrationState createState() => _NameRegistrationState();
}

class _NameRegistrationState extends State<NameRegistration> {
  String _firstName;
  String _lastName;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _first = TextEditingController();
  final TextEditingController _last = TextEditingController();

  Widget nameText = Container(
    padding: const EdgeInsets.all(30),
    child: new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        new Text(
          'What\'s your name?',
          style: primaryText,
        ),
      ],
    ),
  );

  Widget _buildFirstName() {
    return Container(
      width: 300,
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: _first,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              labelText: 'First name',
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
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter your first name';
              }
              return null;
            },
            onSaved: (String value) {
              _firstName = value;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLastName() {
    return Container(
      width: 300,
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: _last,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              labelText: 'Last name',
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
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter your last name';
              }
              return null;
            },
            onSaved: (String value) {
              _lastName = value;
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
            'Your Name',
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
                  Image.asset('assets/name_reg.png'),
                  nameText,
                  _buildFirstName(),
                  _buildLastName(),
                  new Container(
                    width: 330,
                    margin: EdgeInsets.fromLTRB(0, 25.0, 0, 25.0),
                    child: ButtonTheme(
                      height: 50,
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
                                    builder: (context) => SignupConfirmation(),
                                  ),
                                );
                              },
                            );
                          }
                          _formKey.currentState.save();

                          print(_firstName);
                          print(_lastName);
                        },
                        color: blueColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(90),
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
