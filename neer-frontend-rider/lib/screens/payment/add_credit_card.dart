import 'package:flutter/material.dart';
import 'package:awesome_card/awesome_card.dart';
import 'package:credit_card_number_validator/credit_card_number_validator.dart';
import 'package:flutter/services.dart';
import 'package:login/theme/global.dart';

void main() => runApp(AddCreditCard());

class AddCreditCard extends StatefulWidget {
  AddCreditCard({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _AddCreditCardState createState() => _AddCreditCardState();
}

class _AddCreditCardState extends State<AddCreditCard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _formKey = new GlobalKey<FormState>();
  final _autoValidate = false;

  TextEditingController _cardNumberController = TextEditingController();

  String _cardCVV;
  String cardType;
  bool isValid = false;

  String cardNumber = "";
  String cardHolderName = "";
  String expiryDate = "";
  String cvv = "";
  bool showBack = false;

  FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    // _cardNumberController.text = "4111111111111111";
    _focusNode = new FocusNode();
    _focusNode.addListener(
      () {
        setState(
          () {
            _focusNode.hasFocus ? showBack = true : showBack = false;
          },
        );
      },
    );
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  _buildCreditCard() {
    return CreditCard(
      cardNumber: cardNumber,
      cardExpiry: expiryDate,
      cardHolderName: cardHolderName,
      cvv: cvv,
      // bankName: "Axis Bank",
      showBackSide: showBack,
      frontBackground: CardBackgrounds.black,
      backBackground: CardBackgrounds.white,
      showShadow: true,
    );
  }

  _cardNumField() {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: TextFormField(
        controller: _cardNumberController,
        keyboardType: TextInputType.number,
        inputFormatters: [
          WhitelistingTextInputFormatter.digitsOnly,
          new LengthLimitingTextInputFormatter(19),
          // new CardNumberInputFormatter()
        ],
        validator: CardValidation.validateCardNum,
        decoration: InputDecoration(
          labelText: "Card Number",
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
          suffixIcon: IconButton(
            icon: Icon(Icons.camera_alt),
            color: Colors.black,
            onPressed: () {
              print('scan card button pressed');
            },
          ),
        ),
        onChanged: (value) {
          setState(
            () {
              cardNumber = value;
            },
          );
        },
      ),
    );
  }

  _expiredDateField() {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: TextFormField(
        keyboardType: TextInputType.number,
        inputFormatters: [
          WhitelistingTextInputFormatter.digitsOnly,
          new LengthLimitingTextInputFormatter(4),
          new CardMonthInputFormatter()
        ],
        decoration: InputDecoration(
          labelText: "Expired Date",
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
        validator: CardValidation.validateDate,
        onChanged: (value) {
          setState(() {
            expiryDate = value;
          });
        },
      ),
    );
  }

  _cardHolderField() {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: TextFormField(
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          labelText: "Card Holder Name",
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
        validator: (String value) =>
            value.isEmpty ? 'This field is required' : null,
        onChanged: (value) {
          setState(
            () {
              cardHolderName = value;
            },
          );
        },
      ),
    );
  }

  _cvvField() {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        // vertical: 25,
      ),
      child: TextFormField(
        inputFormatters: [
          WhitelistingTextInputFormatter.digitsOnly,
          new LengthLimitingTextInputFormatter(4),
        ],
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: "CVV",
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
        validator: CardValidation.validateCVV,
        onSaved: (String value) {
          _cardCVV = value;
        },
        onChanged: (value) {
          setState(
            () {
              cvv = value;
            },
          );
        },
        focusNode: _focusNode,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Montserrat',
      ),
      home: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: blueColor,
          title: Text(
            'Add Credit Card',
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
            autovalidate: _autoValidate,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _buildCreditCard(),
                  _cardNumField(),
                  _expiredDateField(),
                  _cardHolderField(),
                  _cvvField(),
                  SizedBox(
                    height: 30,
                  ),
                  new Center(
                    child: ButtonTheme(
                      minWidth: 330,
                      height: 50,
                      child: FlatButton(
                        onPressed: () {
                          if (!_formKey.currentState.validate()) {
                            return;
                          }
                          // Get Card Type and Validity Data As Map - @param Card Number
                          Map<String, dynamic> cardData =
                              CreditCardValidator.getCard(
                                  _cardNumberController.text);
                          setState(
                            () {
                              // Set Card Type and Validity
                              cardType = cardData[CreditCardValidator.cardType];
                              isValid =
                                  cardData[CreditCardValidator.isValidCard];
                            },
                          );
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => PaymentMethod(),
                          //   ),
                          // );
                          _snackBar(context);
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
                  SizedBox(
                    height: 15,
                  ),

                  // CreditCardWidget(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _snackBar(BuildContext context) {
    final snackBar = SnackBar(
      content: cardType != null
          // Display Card Type and Validity
          ? Text(
              'Card Type : $cardType \nCard Number Valid: $isValid',
              style: TextStyle(
                  color: isValid ? Colors.green : Colors.red,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w800),
            )
          : Text(' \n '),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }
}

class CardValidation {
  static String validateCardNum(String value) {
    if (value.isEmpty) {
      return 'This field is required';
    }
    if (value.length < 8) {
      return 'Number is invalid';
    }
    return null;
  }

  static String validateCVV(String value) {
    if (value.isEmpty) {
      return 'This field is required';
    }
    if (value.length < 3 || value.length > 4) {
      return "CVV is invalid";
    }
    return null;
  }

  static String validateDate(String value) {
    if (value.isEmpty) {
      return 'This field is required';
    }

    int year;
    int month;
    // The value contains a forward slash if the month and year has been
    // entered.
    if (value.contains(new RegExp(r'(\/)'))) {
      var split = value.split(new RegExp(r'(\/)'));
      // The value before the slash is the month while the value to right of
      // it is the year.
      month = int.parse(split[0]);
      year = int.parse(split[1]);
    } else {
      // Only the month was entered
      month = int.parse(value.substring(0, (value.length)));
      year = -1; // Lets use an invalid year intentionally
    }

    if ((month < 1) || (month > 12)) {
      // A valid month is between 1 (January) and 12 (December)
      return 'Expiry month is invalid';
    }

    var fourDigitsYear = convertYearTo4Digits(year);
    if ((fourDigitsYear < 1) || (fourDigitsYear > 2099)) {
      // We are assuming a valid should be between 1 and 2099.
      // Note that, it's valid doesn't mean that it has not expired.
      return 'Expiry year is invalid';
    }

    if (!hasDateExpired(month, year)) {
      return "Card has expired";
    }
    return null;
  }

  static int convertYearTo4Digits(int year) {
    if (year < 100 && year >= 0) {
      var now = DateTime.now();
      String currentYear = now.year.toString();
      String prefix = currentYear.substring(0, currentYear.length - 2);
      year = int.parse('$prefix${year.toString().padLeft(2, '0')}');
    }
    return year;
  }

  static bool hasDateExpired(int month, int year) {
    return !(month == null || year == null) && isNotExpired(year, month);
  }

  static bool isNotExpired(int year, int month) {
    // It has not expired if both the year and date has not passed
    return !hasYearPassed(year) && !hasMonthPassed(year, month);
  }

  static List<int> getExpiryDate(String value) {
    var split = value.split(new RegExp(r'(\/)'));
    return [int.parse(split[0]), int.parse(split[1])];
  }

  static bool hasMonthPassed(int year, int month) {
    var now = DateTime.now();
    // The month has passed if:
    // 1. The year is in the past. In that case, we just assume that the month
    // has passed
    // 2. Card's month (plus another month) is more than current month.
    return hasYearPassed(year) ||
        convertYearTo4Digits(year) == now.year && (month < now.month + 1);
  }

  static bool hasYearPassed(int year) {
    int fourDigitsYear = convertYearTo4Digits(year);
    var now = DateTime.now();
    // The year has passed if the year we are currently is more than card's
    // year
    return fourDigitsYear < now.year;
  }

  static String getCleanedNumber(String text) {
    RegExp regExp = new RegExp(r"[^0-9]");
    return text.replaceAll(regExp, '');
  }
}

class CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var buffer = new StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 4 == 0 && nonZeroIndex != text.length) {
        buffer.write(' '); // Add single spaces.
      }
    }

    var string = buffer.toString();
    return newValue.copyWith(
        text: string,
        selection: new TextSelection.collapsed(offset: string.length));
  }
}

class CardMonthInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var newText = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var buffer = new StringBuffer();
    for (int i = 0; i < newText.length; i++) {
      buffer.write(newText[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 2 == 0 && nonZeroIndex != newText.length) {
        buffer.write('/');
      }
    }

    var string = buffer.toString();
    return newValue.copyWith(
        text: string,
        selection: new TextSelection.collapsed(offset: string.length));
  }
}
