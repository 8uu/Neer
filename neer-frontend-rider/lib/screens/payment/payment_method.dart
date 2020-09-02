import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:login/screens/payment/add_payment.dart';
import 'package:login/screens/set_pickup_destination.dart';
import 'package:login/theme/global.dart';

class PaymentMethod extends StatefulWidget {
  @override
  _PaymentMethodState createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod>
    with SingleTickerProviderStateMixin {
  _header() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Saved Cards',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 16.0,
          ),
        ),
        // SizedBox(height: 10.0),
      ],
    );
  }

  _savedCards({List<Color> colors}) {
    return Container(
      height: 180.0,
      width: 300.0,
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: colors,
          stops: [0.0, 1.0],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Image.asset('assets/payment_logos/visa-pay-logo.png'),
              Spacer(),
              Icon(Icons.more_horiz, color: Colors.white)
            ],
          ),
          Text(
            '* * * *  * * * *  * * * *  7822',
            style: TextStyle(
                fontSize: 21.5,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
          Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'CARD HOLDER',
                    style: TextStyle(color: Colors.white70),
                  ),
                  Text(
                    'EXPIRES',
                    style: TextStyle(color: Colors.white70),
                  )
                ],
              ),
              SizedBox(height: 7.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'John Doe',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.4,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '08/21',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.4,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  _carouselSlider() {
    return CarouselSlider(
      items: <Widget>[
        _savedCards(colors: [Color(0xFF5AD9B3), Color(0xFF5EDDB7)]),
        _savedCards(colors: [Color(0xFF8676FB), Color(0xFFAB7BFF)]),
        _savedCards(colors: [Color(0xFFF5A25F), Color(0xFFFAA865)]),
      ],
      options: CarouselOptions(
        height: 180.0,
        initialPage: 1,
        enableInfiniteScroll: false,
        enlargeCenterPage: true,
      ),
    );
  }

  _paymentTypes({Image icon, String number}) {
    return Card(
      child: ListTile(
        leading: Container(
          height: 40.0,
          child: icon,
        ),
        title: Row(
          children: <Widget>[
            Text(
              number,
              style: TextStyle(
                fontWeight: FontWeight.normal,
              ),
            )
          ],
        ),
      ),
    );
  }

  _labelHeader(String title) {
    return Padding(
      padding: EdgeInsets.only(top: 15.0, bottom: 10.0),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.grey,
          fontSize: 16.0,
        ),
      ),
    );
  }

  _paymentTypeList() {
    return Center(
      child: Container(
        width: 330,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _labelHeader('Current Method'),
            _paymentTypes(
              icon: Image.asset('assets/payment_logos/visa_logo.png'),
              number: '* * * *  * * * *  * * * *  5578',
            ),
            _labelHeader('Other saved methods'),
            _paymentTypes(
              icon: Image.asset('assets/payment_logos/paypal_logo.png'),
              number: 'john_doe@gmail.com',
            ),
            // _paymentTypes(
            //   icon: Image.asset('assets/payment_logos/apple_pay_logo.png'),
            //   number: 'Apple Pay',
            // ),
          ],
        ),
      ),
    );
  }

  _skipButton() {
    return Center(
      child: Container(
        child: Column(
          children: <Widget>[
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SetPickupDestination(),
                    ));
              },
              child: Text(
                'Skip',
                style: TextStyle(
                  fontSize: 16,
                  decoration: TextDecoration.underline,
                ),
              ),
            )
          ],
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
            'Payment Method',
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
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: _header(),
                ),
                _carouselSlider(),
                // SizedBox(height: 20.0),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // SizedBox(height: 10.0),
                      _paymentTypeList(),
                      SizedBox(
                        height: 10.0,
                      ),
                      _skipButton(),
                      Center(
                        child: new Container(
                          width: 330,
                          margin: EdgeInsets.fromLTRB(0, 25, 0, 25),
                          child: ButtonTheme(
                            height: 50,
                            child: FlatButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddPayment(),
                                  ),
                                );
                              },
                              color: blueColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(90),
                              ),
                              child: Text(
                                'Add Payment',
                                style: primaryText,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
