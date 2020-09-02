import 'dart:async';

import 'package:login/screens/authenticate/email_form.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:login/theme/global.dart';

void main() => runApp(SmsVerification());

class SmsVerification extends StatefulWidget {
  // final String phoneNumber;

  // SmsVerification(this.phoneNumber);

  @override
  _SmsVerificationState createState() => _SmsVerificationState();
}

class _SmsVerificationState extends State<SmsVerification> {
  var onTapRecognizer;

  TextEditingController textEditingController = TextEditingController();

  StreamController<ErrorAnimationType> errorController;

  bool hasError = false;
  String currentText = "";
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    onTapRecognizer = TapGestureRecognizer()
      ..onTap = () {
        Navigator.pop(context);
      };
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController.close();

    super.dispose();
  }

  int _counter = 60;
  Timer _timer;

  void _startTimer() {
    _counter = 60;
    if (_timer != null) {
      _timer.cancel();
    }
    _timer = Timer.periodic(
      Duration(seconds: 1),
      (timer) {
        setState(
          () {
            if (_counter > 0) {
              _counter--;
            } else {
              _timer.cancel();
            }
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenTitle = 'Verify Phone Number';
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Montserrat'),
      home: Scaffold(
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
        backgroundColor: Colors.white,
        key: scaffoldKey,
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: ListView(
              children: <Widget>[
                SizedBox(height: 30),
                Container(
                  height: MediaQuery.of(context).size.height / 3,
                  child: Image.asset('assets/sms_verification.png'),
                ),

                SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    'Enter your code',
                    style: primaryText,
                    textAlign: TextAlign.center,
                  ),
                ),
                // Padding(
                //   padding:
                //       const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8),
                //   child: RichText(
                //     text: TextSpan(
                //         text: "Enter the code sent to ",
                //         children: [
                //           TextSpan(
                //               text: widget.phoneNumber,
                //               style: TextStyle(
                //                   color: Colors.black,
                //                   fontWeight: FontWeight.bold,
                //                   fontSize: 15)),
                //         ],
                //         style: TextStyle(color: Colors.black54, fontSize: 15)),
                //     textAlign: TextAlign.center,
                //   ),
                // ),
                SizedBox(
                  height: 20,
                ),
                Form(
                  key: formKey,
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 30),
                      child: PinCodeTextField(
                        length: 6,
                        obsecureText: false,
                        animationType: AnimationType.fade,
                        validator: (v) {
                          if (v.length != 6) {
                            return 'Please enter boxes properly';
                          } else {
                            return null;
                          }
                        },
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(5),
                          fieldHeight: 50,
                          fieldWidth: 40,
                          selectedFillColor: darkPurpleColor,
                          inactiveFillColor: Colors.grey[400],
                          inactiveColor: Colors.grey[400],
                          activeFillColor:
                              hasError ? Colors.orange : Colors.white,
                        ),
                        animationDuration: Duration(milliseconds: 300),
                        backgroundColor: Colors.white,
                        enableActiveFill: true,
                        errorAnimationController: errorController,
                        controller: textEditingController,
                        onCompleted: (v) {
                          print("Completed");
                        },
                        onChanged: (value) {
                          print(value);
                          setState(() {
                            currentText = value;
                          });
                        },
                        // beforeTextPaste: (text) {
                        //   print("Allowing to paste $text");
                        //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                        //but you can show anything you want here, like your pop up saying wrong paste format or etc
                        //   return true;
                        // },
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Text(
                    hasError ? "*Wrong code, please try again" : "",
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: "Didn't receive the code? ",
                    style: TextStyle(color: Colors.black54, fontSize: 15),
                    children: [
                      TextSpan(
                        text: " Resend Code",
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => _startTimer(),
                        style: TextStyle(
                            color: darkPurpleColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 14,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    'Expires in $_counter s',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 30),
                  child: ButtonTheme(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(90.0),
                    ),
                    height: 50,
                    child: FlatButton(
                      color: blueColor,
                      onPressed: () {
                        formKey.currentState.validate();
                        // conditions for validating
                        if (currentText.length != 6 ||
                            currentText != "123456") {
                          errorController.add(ErrorAnimationType
                              .shake); // Triggering error shake animation
                          setState(
                            () {
                              hasError = true;
                            },
                          );
                        } else {
                          setState(
                            () {
                              hasError = false;
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EmailForm()),
                              );

                              // scaffoldKey.currentState.showSnackBar(
                              //   SnackBar(
                              //     content: Text("Yay!!"),
                              //     duration: Duration(seconds: 3),
                              //   ),
                              // );
                            },
                          );
                        }
                      },
                      child: Center(
                        child: Text(
                          'Verify',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
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
