import 'package:flutter/material.dart';
import '../theme/global.dart';

class BookingConfirmation extends StatefulWidget {
  @override
  _BookingConfirmationState createState() => _BookingConfirmationState();
}

class _BookingConfirmationState extends State<BookingConfirmation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Booking Confirmed',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Montserrat',
          ),
        ),
        backgroundColor: blueColor,
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            width: 30.0,
            height: 30.0,
          ),
          firstPic,
          SizedBox(
            width: 30.0,
            height: 40.0,
          ),
          secondText,
          SizedBox(
            width: 30.0,
            height: 130.0,
          ),
          lastButton,
        ],
      ),
    );
  }
}

Widget firstPic = Container(
  child: Image(
    image: AssetImage(
      "assets/booking_confirmation.png",
    ),
  ),
);
Widget secondText = Container(
  child: RichText(
    text: TextSpan(
      text: 'Hooray! Your booking has been confirmed. Enjoy your ride!',
      style: TextStyle(
        fontFamily: 'Montserrat',
        color: Colors.black,
        fontSize: 14,
      ),
    ),
  ),
);

//Widget lastButton = Container(
//  child: Row(
//    mainAxisAlignment: MainAxisAlignment.center,
//    children: <Widget>[
//      FlatButton(
//        shape: RoundedRectangleBorder(
//          borderRadius: BorderRadius.circular(18.0),
//          side: BorderSide(color: blueColor),
//        ),
//        color: blueColor,
//        textColor: Colors.black,
//        padding: EdgeInsets.all(8.0),
//        onPressed: () {},
//        child: Text(
//          'Done',
//          style: TextStyle(
//            fontSize: 14.0,
//          ),
//        ),
//      ),
//    ],
//  ),
//);

Widget lastButton = Container(
  width: 330.0,
  margin: EdgeInsets.only(top: 35),
  child: ButtonTheme(
    height: 50.0,
    child: FlatButton(
      onPressed: () {},
      color: blueColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(90.0),
      ),
      child: Text(
        'Done',
        style: primaryText,
      ),
    ),
  ),
);
