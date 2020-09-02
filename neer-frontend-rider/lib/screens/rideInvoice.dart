import 'package:flutter/material.dart';
import '../theme/global.dart';

class RideInvoice extends StatefulWidget {
  @override
  _RideInvoiceState createState() => _RideInvoiceState();
}

class _RideInvoiceState extends State<RideInvoice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Your Ride Invoice',
          style: TextStyle(color: Colors.black,
          fontFamily: 'Montserrat'),
        ),

        leading: new IconTheme(data: new IconThemeData(
          color:Colors.black,
        ),
            child: new IconButton(icon: new Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              },
            )),

        centerTitle: true,
        backgroundColor: blueColor,
      ),
      body: Column(
        children: <Widget>[
          firstRow,
          SizedBox(
            width: 30.0,
            height: 10.0,
          ),
          secondRow,
          SizedBox(
            width: 30.0,
            height: 10.0,
          ),
          thirdRow,
          SizedBox(
            width: 30.0,
            height: 5.0,
          ),
          fourthRow,
//          SizedBox(
//            width: 30.0,
//            height: 20.0,
//          ),
//          fifthRow,
//          SizedBox(
//            width: 30.0,
//            height: 20.0,
//          ),
//          sixthRow,
//          SizedBox(
//            width: 30.0,
//            height: 20.0,
//          ),
//          seventhRow,
//          SizedBox(
//            width: 30.0,
//            height: 20.0,
//          ),
//          eighthRow,
//          SizedBox(
//            width: 30.0,
//            height: 20.0,
//          ),
//          ninthRow,
          SizedBox(
            width: 30.0,
            height: 30.0,
          ),
          tenthRow,
          SizedBox(
            width: 30.0,
            height: 10.0,
          ),
          //lastButton,
        ],
      ),
    );
  }
}



Widget firstRow = Container(
  child: Row(
    children: <Widget>[
      Row(
        children: <Widget>[
          Container(
            child: Image.asset(
              'assets/loc.png',
              height: 50,
              width: 40,
            ),
          ),
        ],
      ),
      Container(
        child: Text(
          '8 mi',
        ),
      ),


      Row(
        children: <Widget>[
          Container(
            child: Image.asset(
              'assets/money.jpg',
              height: 50,
              width: 70,
            ),
          ),
          RichText(
            text: TextSpan(
              text: 'Paid through card', style: TextStyle(color: Colors.black, fontSize: 15),
            ),
          ),
        ],
      ),



      Container(
        child: Image.asset(
          'assets/stopwatch.png',
          height: 50,
          width: 70,
        ),
      ),
      RichText(
        text: TextSpan(
          text: '35 min', style: TextStyle(color: Colors.black, fontSize: 15),
        ),
      ),
    ],
  ),


);


Widget secondRow = Container(
  child: RichText(
    text: TextSpan(
      text: 'Ride ID: AURND-573-8GHE', style: TextStyle(
      fontFamily: 'Montserrat',
      color: Colors.black,
      fontSize: 16,
    ),
    ),
  ),
);


Widget thirdRow = Container(
  child: RichText(
    text: TextSpan(
      text: 'Your fare will be the price presented before the trip.', style: TextStyle(
      fontFamily: 'Montserrat',
      color: Colors.black,
      fontSize: 14,
    ),
    ),
  ),
);



Widget fourthRow = new Container(
  child: DataTable(
    columns: [
      DataColumn(label: Text("Article")),
      DataColumn(label: Text("Price")),
    ],

    rows: [
      DataRow(cells: [
        DataCell(Text("Base Price")),
        DataCell(Text("\$15")),
      ]),
      DataRow(cells: [
        DataCell(Text("Minimum Fare")),
        DataCell(Text("\$35")),
      ]),
      DataRow(cells: [
        DataCell(Text("+ Per Minute")),
        DataCell(Text("\$1.03")),
      ]),
      DataRow(cells: [
        DataCell(Text("+ Per Mile")),
        DataCell(Text("\$3.00")),
      ]),
      DataRow(cells: [
        DataCell(Text("Tax")),
        DataCell(Text("\$10")),
      ]),
      DataRow(cells: [
        DataCell(Text("Total Price")),
        DataCell(Text("\$25.00")),
      ]),
    ],
  ),
);



//Widget fourthRow = Container(
//  child: Row(
//    mainAxisAlignment: MainAxisAlignment.center,
//    children: <Widget>[
//      Row(
//        children: <Widget>[
//          RichText(
//            text: TextSpan(
//              text: 'Base Price: ', style: TextStyle(
//              fontFamily: 'Montserrat',
//              color: Colors.black,
//              fontSize: 16,
//            ),
//            ),
//          ),
//          RichText(
//            text: TextSpan(
//              text: '\$15', style: TextStyle(
//              fontFamily: 'Montserrat',
//              color: Colors.black,
//              fontSize: 16,
//            ),
//            ),
//          ),
//        ],
//      ),
//    ],
//  ),
//);
//
//
//Widget fifthRow = Container(
//  child: Row(
//    mainAxisAlignment: MainAxisAlignment.center,
//    children: <Widget>[
//      Row(
//        children: <Widget>[
//          RichText(
//            text: TextSpan(
//              text: 'Minimum Fare: ', style: TextStyle(
//              fontFamily: 'Montserrat',
//              color: Colors.black,
//              fontSize: 16,
//            ),
//            ),
//          ),
//          RichText(
//            text: TextSpan(
//              text: '\$35', style: TextStyle(
//              fontFamily: 'Montserrat',
//              color: Colors.black,
//              fontSize: 16,
//            ),
//            ),
//          ),
//        ],
//      ),
//    ],
//  ),
//);
//
//
//Widget sixthRow = Container(
//  child: Row(
//    mainAxisAlignment: MainAxisAlignment.center,
//    children: <Widget>[
//      Row(
//        children: <Widget>[
//          RichText(
//            text: TextSpan(
//              text: '+ Per Minute: ', style: TextStyle(
//              fontFamily: 'Montserrat',
//              color: Colors.black,
//              fontSize: 16,
//            ),
//            ),
//          ),
//          RichText(
//            text: TextSpan(
//              text: '\$1.03', style: TextStyle(
//              fontFamily: 'Montserrat',
//              color: Colors.black,
//              fontSize: 16,
//            ),
//            ),
//          ),
//        ],
//      ),
//    ],
//  ),
//);
//
//
//Widget seventhRow = Container(
//  child: Row(
//    mainAxisAlignment: MainAxisAlignment.center,
//    children: <Widget>[
//      Row(
//        children: <Widget>[
//          RichText(
//            text: TextSpan(
//              text: '+ Per Mile: ', style: TextStyle(
//              fontFamily: 'Montserrat',
//              color: Colors.black,
//              fontSize: 16,
//            ),
//            ),
//          ),
//          RichText(
//            text: TextSpan(
//              text: '\$3', style: TextStyle(
//              fontFamily: 'Montserrat',
//              color: Colors.black,
//              fontSize: 16,
//            ),
//            ),
//          ),
//        ],
//      ),
//    ],
//  ),
//);
//
//
//Widget eighthRow = Container(
//  child: Row(
//    mainAxisAlignment: MainAxisAlignment.center,
//    children: <Widget>[
//      Row(
//        children: <Widget>[
//          RichText(
//            text: TextSpan(
//              text: 'Tax: ', style: TextStyle(
//              fontFamily: 'Montserrat',
//              color: Colors.black,
//              fontSize: 16,
//            ),
//            ),
//          ),
//          RichText(
//            text: TextSpan(
//              text: '\$10', style: TextStyle(
//              fontFamily: 'Montserrat',
//              color: Colors.black,
//              fontSize: 16,
//            ),
//            ),
//          ),
//        ],
//      ),
//    ],
//  ),
//);
//
//
//Widget ninthRow = Container(
//  child: Row(
//    mainAxisAlignment: MainAxisAlignment.center,
//    children: <Widget>[
//      Row(
//        children: <Widget>[
//          RichText(
//            text: TextSpan(
//              text: 'Total Price: ', style: TextStyle(
//              fontFamily: 'Montserrat',
//              color: Colors.black,
//              fontSize: 16,
//            ),
//            ),
//          ),
//          RichText(
//            text: TextSpan(
//              text: '\$25', style: TextStyle(
//              fontFamily: 'Montserrat',
//              color: Colors.black,
//              fontSize: 16,
//            ),
//            ),
//          ),
//        ],
//      ),
//    ],
//  ),
//);


Widget tenthRow = Container(
  child: RichText(
    text: TextSpan(
      text: 'Additional Wait time charges may apply on your ride if the driver has waited 2 minutes: \$2 per minute.', style: TextStyle(
      fontFamily: 'Montserrat',
      color: Colors.black,
      fontSize: 14,
    ),
    ),
  ),
);

//Color blueColor = new Color(0xFFD4E3E6);
//Color darkPurpleColor = new Color(0xFF7679B4);

//Widget lastButton = Container(
//  child: Row(
//    mainAxisAlignment: MainAxisAlignment.center,
//    children: <Widget>[
//      FlatButton(
//        shape: RoundedRectangleBorder(
//          borderRadius: BorderRadius.circular(18.0),
//          side: BorderSide(color: Colors.black),
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


//Widget lastButton = Container(
//  width: 330.0,
//  margin: EdgeInsets.only(top: 35),
//  child: ButtonTheme(
//    height: 50.0,
//    child: FlatButton(
//      onPressed: () {},
//      color: blueColor,
//      shape: RoundedRectangleBorder(
//        borderRadius: BorderRadius.circular(90.0),
//      ),
//      child: Text(
//        'Back',
//        style: primaryText,
//      ),
//    ),
//  ),
//);