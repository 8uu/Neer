import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:login/theme/global.dart';

class EditAccount extends StatefulWidget {
  @override
  _EditAccountState createState() => _EditAccountState();
}

class _EditAccountState extends State<EditAccount> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  _avatar() {
    return Container(
      padding: EdgeInsets.all(10),
      child: GestureDetector(
        onTap: () {
          _showAlertDialog(context);
        },
        child: CircleAvatar(
          backgroundImage: AssetImage('assets/avatar.png'),
          radius: 60,
        ),
      ),
    );
  }

  _firstName() {
    return Container(
      width: 360,
      child: Column(
        children: <Widget>[
          TextFormField(
            // controller: _first,
            readOnly: true,
            initialValue: 'John',
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
            // onSaved: (String value) {
            //   _firstName = value;
            // },
            onTap: () {
              _showAlertDialog(context);
            },
          ),
        ],
      ),
    );
  }

  _lastName() {
    return Container(
      width: 360,
      child: Column(
        children: <Widget>[
          TextFormField(
            // controller: _last,
            readOnly: true,
            initialValue: 'Doe',
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
            // onSaved: (String value) {
            //   _lastName = value;
            // },
            onTap: () {
              _showAlertDialog(context);
            },
          ),
        ],
      ),
    );
  }

  _phoneInputField() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Flexible(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 0, 0),
              child: CountryCodePicker(
                initialSelection: 'US',
                showCountryOnly: false,
                alignLeft: true,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              width: 80,
              margin: EdgeInsets.only(
                right: 60,
              ),
              child: TextFormField(
                // controller: _phone,
                initialValue: '1234567890',
                // showCursor: false,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.phone,
                style: TextStyle(
                  fontSize: 20,
                ),
                inputFormatters: <TextInputFormatter>[
                  WhitelistingTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(10),
                  _UsNumberTextInputFormatter(),
                ],
                decoration: InputDecoration(
                  hintStyle: TextStyle(
                    fontSize: 14,
                  ),
                  hintText: 'Enter your mobile number',
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
                // validator: (value) {
                //   if (value.isEmpty) {
                //     return 'Please enter mobile number';
                //   }
                //   if (value.length != 14) {
                //     return 'Not proper number';
                //   }
                //   return null;
                // },
                // onSaved: (String value) {
                //   _phoneNumber = value;
                // },
              ),
            ),
          ),
        ],
      ),
    );
  }

  _emailField() {
    return Container(
      width: 360,
      child: TextFormField(
        initialValue: 'johndoe@gmail.com',
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
        // validator: (email) {
        //   if (!EmailValidator.validate(email)) {
        //     return 'Please enter a vaild email';
        //   }
        // },
      ),
    );
  }

  _pwdField() {
    return Container(
      width: 360,
      child: Column(
        children: <Widget>[
          TextFormField(
            obscureText: true,
            initialValue: '(123) 456-7890',
            // controller: _pass,
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
            // validator: (password) {
            //   Pattern pattern =
            //       r'^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?!.*\s).{8,}$';
            //   RegExp regex = new RegExp(pattern);
            //   if (password.isEmpty) {
            //     return 'Please enter password';
            //   }
            //   if (!regex.hasMatch(password)) {
            //     return 'Does not contain required characters';
            //   }
            //   return null;
            // },
            // onSaved: (String value) {
            //   _password = value;
            // },
          ),
        ],
      ),
    );
  }

  _showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text(
        "Cancel",
        style: TextStyle(
          fontFamily: 'Montserrat',
          color: darkPurpleColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      onPressed: () => Navigator.of(context, rootNavigator: true).pop('dialog'),
    );
    Widget contactUsButton = FlatButton(
      child: Text(
        "Contact Us",
        style: TextStyle(
          fontFamily: 'Montserrat',
          color: darkPurpleColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      onPressed: () {
        print('contact us button pressed');
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        "Field Can't Be Edited",
        style: TextStyle(fontFamily: 'Montserrat'),
      ),
      content: Text("Contact us if you want to update field."),
      actions: [
        cancelButton,
        contactUsButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Montserrat'),
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: blueColor,
          title: Text(
            'Edit Account',
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
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  _avatar(),
                  _firstName(),
                  _lastName(),
                  _phoneInputField(),
                  _emailField(),
                  _pwdField(),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 25.0, 0, 25.0),
                    child: new ButtonTheme(
                      minWidth: 330,
                      height: 50,
                      child: FlatButton(
                        onPressed: () {
                          // if (!_formKey.currentState.validate()) {
                          //   return;
                          // } else {
                          //   setState(
                          //     () {
                          //       Navigator.push(
                          //         context,
                          //         MaterialPageRoute(
                          //           builder: (context) => SignupConfirmation(),
                          //         ),
                          //       );
                          //     },
                          //   );
                          // }
                          // _formKey.currentState.save();

                          // print(_firstName);
                          // print(_lastName);
                        },
                        color: blueColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(90),
                        ),
                        child: Text(
                          'Save',
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

/// Format incoming numeric text to fit the format of (###) ###-#### ##...
class _UsNumberTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final int newTextLength = newValue.text.length;
    int selectionIndex = newValue.selection.end;
    int usedSubstringIndex = 0;
    final StringBuffer newText = StringBuffer();
    if (newTextLength >= 1) {
      newText.write('(');
      if (newValue.selection.end >= 1) selectionIndex++;
    }
    if (newTextLength >= 4) {
      newText.write(newValue.text.substring(0, usedSubstringIndex = 3) + ') ');
      if (newValue.selection.end >= 3) selectionIndex += 2;
    }
    if (newTextLength >= 7) {
      newText.write(newValue.text.substring(3, usedSubstringIndex = 6) + '-');
      if (newValue.selection.end >= 6) selectionIndex++;
    }
    if (newTextLength >= 11) {
      newText.write(newValue.text.substring(6, usedSubstringIndex = 10) + ' ');
      if (newValue.selection.end >= 10) selectionIndex++;
    }
    // Dump the rest.
    if (newTextLength >= usedSubstringIndex)
      newText.write(newValue.text.substring(usedSubstringIndex));
    return TextEditingValue(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
