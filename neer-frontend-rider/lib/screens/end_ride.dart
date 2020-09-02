import 'package:flutter/material.dart';
import 'package:login/screens/rideInvoice.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import '../theme/global.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class EndRide extends StatefulWidget {
  @override
  _EndRideState createState() => _EndRideState();
}

class _EndRideState extends State<EndRide> {
  GoogleMapController mapController;
  LatLng start = new LatLng(37.416780, -122.077430);
  LatLng end = new LatLng(37.426780, -122.077430);
  Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: CameraPosition(
                target: LatLng((start.latitude + end.latitude) / 2,
                    (start.longitude + end.longitude) / 2),
                zoom: 15,
              ),
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              zoomGesturesEnabled: true,
              zoomControlsEnabled: false,
              markers: {
//                Marker(
//                  markerId: MarkerId('From'),
//                  position: start,
//                ),
//                Marker(
//                  markerId: MarkerId('To'),
//                  position: end,
//                ),
              },
            ),
          ),
          EndRideInfo(),
        ],
      ),
    );
  }
}

class EndRideInfo extends StatefulWidget {
  EndRideInfo({Key key}) : super(key: key);

  @override
  _EndRideInfoState createState() => _EndRideInfoState();
}

class _EndRideInfoState extends State<EndRideInfo> {
  var rating = 0.0;

  String driver1 = 'https://tinyurl.com/y8b8f6lr';
  String driverName = 'Tina';

  _starRating() {
    return Container(
      child: SmoothStarRating(
        allowHalfRating: false,
        onRated: (v) {},
        starCount: 5,
        rating: rating,
        size: 50.0,
        isReadOnly: false,
        filledIconData: Icons.star,
        defaultIconData: Icons.star_border,
        color: darkPurpleColor,
        borderColor: darkPurpleColor,
        spacing: 3.0,
      ),
    );
  }

  _submitButton() {
    return Container(
      // width: 330,
      // margin: EdgeInsets.fromLTRB(0, 25, 0, 25),
      margin: EdgeInsets.all(15),
      child: ButtonTheme(
        minWidth: 330,
        height: 40,
        child: FlatButton(
          onPressed: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => AddPaymentIcon(),
            //   ),
            // );
            print('submit button tapped');
          },
          color: blueColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(90),
          ),
          child: Text(
            'Submit',
            style: primaryText,
          ),
        ),
      ),
    );
  }

  Widget paymentIcon = Container(
    child: Icon(
      Icons.credit_card,
      color: Colors.black,
    ),
  );

  Widget cardNumber = Container(
    child: Text(
      '**** 5578',
      style: TextStyle(
        fontFamily: 'Montserrat',
      ),
    ),
  );

  Widget moneyIcon = Container(
    child: Icon(
      Icons.attach_money,
    ),
  );

  Widget tripAmount = Container(
    child: Text(
      '-10.24',
      style: TextStyle(
        fontFamily: 'Montserrat',
      ),
    ),
  );

  _invoiceButton() {
    return Container(
      // width: 330,
      // margin: EdgeInsets.fromLTRB(0, 25, 0, 25),
      margin: EdgeInsets.only(top: 10),
      child: ButtonTheme(
        minWidth: 330,
        height: 40,
        child: FlatButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RideInvoice(),
              ),
            );
            print('invoice button tapped');
          },
          color: blueColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(90),
          ),
          child: Text(
            'Invoice',
            style: primaryText,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 380,
          width: 380,
          child: Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(20),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text:
                          'Your trip ended! Please rate your ride and thank you for using Neer!',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => DriverInfo(
                            name: '$driverName',
                            description:
                                "Hi! 🙋🏻‍♀️ My name is Tina and I am happy to be your Neer driver!",
                            buttonText: "Close",
                          ),
                        );
                        // print('avatar pressed');
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => ),)
                      },
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(driver1),
                      ),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Text(
                      'Driver Name',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _starRating(),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    paymentIcon,
                    SizedBox(
                      width: 10,
                    ),
                    cardNumber,
                    SizedBox(
                      width: 30,
                    ),
                    moneyIcon,
                    tripAmount,
                  ],
                ),
                SizedBox(height: 10),
                Column(
                  children: <Widget>[
                    _invoiceButton(),
                    _submitButton(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DriverInfo extends StatelessWidget {
  final String name, description, buttonText;
  final Image image;
  final String driver1 = 'https://tinyurl.com/y8b8f6lr';
  double rating = 5.0;
  double years = 2.5;

  DriverInfo({
    @required this.name,
    @required this.description,
    @required this.rating,
    @required this.years,
    @required this.buttonText,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Montserrat'),
      home: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Consts.padding),
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        child: dialogContent(context),
      ),
    );
  }

  dialogContent(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            top: Consts.avatarRadius + Consts.padding,
            bottom: Consts.padding,
            left: Consts.padding,
            right: Consts.padding,
          ),
          margin: EdgeInsets.only(top: Consts.avatarRadius),
          decoration: new BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(Consts.padding),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: const Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // To make the card compact
            children: <Widget>[
              Text(
                name,
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 24.0),
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  driverRating(),
                  SizedBox(width: 20),
                  driverYears(),
                ],
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // To close the dialog
                  },
                  child: Text(
                    buttonText.toUpperCase(),
                    style: TextStyle(
                      color: darkPurpleColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          left: Consts.padding,
          right: Consts.padding,
          child: Align(
            alignment: Alignment.center,
            child: CircleAvatar(
              backgroundImage: NetworkImage(driver1),
              backgroundColor: Colors.transparent,
              radius: Consts.avatarRadius,
            ),
          ),
        ),
      ],
    );
  }

  driverRating() {
    return Container(
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: '5.0 ',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 18,
                color: Colors.black,
              ),
            ),
            WidgetSpan(
              child: Icon(
                Icons.star,
                size: 20,
                color: darkPurpleColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  driverYears() {
    return Container(
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: '2.5 Years',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 18,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Consts {
  Consts._();

  static const double padding = 16.0;
  static const double avatarRadius = 66.0;
}
