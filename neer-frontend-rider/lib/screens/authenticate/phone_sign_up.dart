import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:login/screens/authenticate/sms_verification.dart';
import 'package:login/screens/landing_page.dart';
import 'package:login/screens/terms_n_policy.dart';
import 'package:login/theme/global.dart';
import 'package:login/screens/authenticate/phone_sign_up.dart';

void main() => runApp(PhoneSignUp());

class PhoneSignUp extends StatefulWidget {
  @override
  _PhoneSignUpState createState() => _PhoneSignUpState();
}

class _PhoneSignUpState extends State<PhoneSignUp> {
  String _phoneNumber;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _phone = TextEditingController();

  Widget screenInstrucText = Container(
    padding: const EdgeInsets.all(30),
    child: new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        new Text(
          'We need to register your mobile number before getting started!',
          textAlign: TextAlign.center,
          style: primaryText,
        ),
      ],
    ),
  );

  Widget _buildPhoneInputField() {
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
                controller: _phone,
                showCursor: false,
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
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter mobile number';
                  }
                  if (value.length != 14) {
                    return 'Not proper number';
                  }
                  return null;
                },
                onSaved: (String value) {
                  _phoneNumber = value;
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  _termsPolicyText() {
    return Container(
      padding: const EdgeInsets.all(30),
      child: new Column(
        children: [
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: 'By clicking "Next", you are agreeing to our  ',
              style: TextStyle(
                color: Colors.black,
                fontSize: 13,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: 'Terms of Service',
                  style: TextStyle(
                    fontSize: 13,
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TermsOfService(),
                        ),
                      );
                    },
                ),
                TextSpan(
                  text: ' & ',
                  style: TextStyle(
                    fontSize: 13,
                  ),
                ),
                TextSpan(
                  text: 'Privacy Policy',
                  style: TextStyle(
                    fontSize: 13,
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TermsOfService(),
                        ),
                      );
                    },
                ),
                TextSpan(
                  text: '.',
                  style: TextStyle(
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenTitle = 'Enter your mobile number';
    return MaterialApp(
      title: screenTitle,
      theme: ThemeData(fontFamily: 'Montserrat'),
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: blueColor,
          title: Text(
            screenTitle,
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
                children: [
                  Image.asset('assets/phone_signup.png'),
                  screenInstrucText,
                  _buildPhoneInputField(),
                  new Container(
                    width: 330.0,
                    margin: EdgeInsets.only(top: 35),
                    child: ButtonTheme(
                      height: 50.0,
                      child: FlatButton(
                        onPressed: () {
                          if (!_formKey.currentState.validate()) {
                            return 'Please enter mobile number';
                          } else {
                            setState(
                              () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SmsVerification(),
                                  ),
                                );
                              },
                            );
                          }
                          _formKey.currentState.save();

                          print(_phoneNumber);
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
                  _termsPolicyText(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  static private_policy() {}

  static terms_of_services() {}
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
