import 'package:flutter/material.dart';
import 'package:login/screens/payment/add_credit_card.dart';
import 'package:login/theme/global.dart';

class AddPayment extends StatefulWidget {
  @override
  _AddPaymentState createState() => _AddPaymentState();
}

class _AddPaymentState extends State<AddPayment> {
  final List<String> entries = <String>['A', 'B', 'C'];
  final List<int> colorCodes = <int>[600, 500, 100];

  Widget screenText = Container(
    padding: const EdgeInsets.all(30),
    child: new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Text(
          'Select type of payment method to add',
          textAlign: TextAlign.center,
          style: primaryText,
        )
      ],
    ),
  );

  _paypalCard() {
    return Center(
      child: Card(
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            print('paypal card tapped');
          },
          child: Container(
            width: 330,
            height: 90,
            child: Image.asset('assets/payment_logos/paypal_card_logo.png'),
            decoration: BoxDecoration(
              borderRadius: new BorderRadius.all(
                Radius.circular(5),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _venmo() {
    return new Stack(
      children: [
        Center(
          child: Card(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap: () {
                  print('venmo tapped');
                },
                child: Ink(
                  width: 330,
                  height: 90,
                  child: Image.asset('assets/payment_logos/venmo_logo.png'),
                  decoration: BoxDecoration(
                    // color: Colors.black,
                    borderRadius: new BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  _creditCard() {
    return Center(
      child: Card(
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddCreditCard(),
              ),
            );
          },
          child: Container(
            width: 330,
            height: 90,
            decoration: BoxDecoration(
              borderRadius: new BorderRadius.all(
                Radius.circular(5),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Credit/Debit Card',
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
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
            'Add Payment',
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
                screenText,
                _paypalCard(),
                SizedBox(
                  height: 30,
                ),
                _venmo(),
                SizedBox(
                  height: 30,
                ),
                _creditCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
