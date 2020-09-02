import 'package:flutter/material.dart';
//import 'package:landing_page/theme/global.dart';
import '../theme/global.dart';

class BookingCancelled extends StatefulWidget {
  @override
  _BookingCancelledState createState() => _BookingCancelledState();
}
class _BookingCancelledState extends State<BookingCancelled> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Booking Cancellation',
          style: TextStyle(color: Colors.black,
              fontFamily: 'Montserrat'),
        ),
        centerTitle: true,
        backgroundColor: blueColor,
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
      "assets/cancel_booking.png",
    ),
  ),
);
Widget secondText = Container(
  child: RichText(
    text: TextSpan(
      text: 'Your booking has been cancelled as per your request',
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
//          'Back',
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
        'Back',
        style: primaryText,
      ),
    ),
  ),
);