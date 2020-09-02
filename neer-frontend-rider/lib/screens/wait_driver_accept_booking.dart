import 'package:flutter/material.dart';
import '../theme/global.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart';
import 'bookingCancellation.dart';

class WaitDriverAcceptBooking extends StatefulWidget {
  @override
  _WaitDriverAcceptBookingState createState() => _WaitDriverAcceptBookingState();
}

class _WaitDriverAcceptBookingState extends State<WaitDriverAcceptBooking> {
  GoogleMapController mapController;
  LatLng fromLoc = new LatLng(37.3501544,-122.07633209999999);
  var numOfCars = 8;
//  List<Marker> cars = new List<Marker>.generate(
//      8, (i) => new Marker(
//      markerId: MarkerId("car$i"),
//      position: new LatLng(37.3502544, -122.07633209999999),
////      icon: BitmapDescriptor.defaultMarker,
//  ));

  @override
  Widget build(BuildContext context) {
//    Marker _marker = Marker(
//      markerId: marker
//    )
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
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
        body: Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: GoogleMap(
                scrollGesturesEnabled: false,
                zoomGesturesEnabled: false,
                mapType: MapType.normal,
                zoomControlsEnabled: false,
                initialCameraPosition: CameraPosition(
                  target: fromLoc,
                  zoom: 15,
                ),
//                markers: Set.from(cars),
              ),
            ),
            Center(
              child: Container(
                width: 180,
                height: 180,
//                color: blueColor,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(90),
                  color: blueColor,
                ),
                child: Center(
                  child: Text(
                    '$numOfCars' + '\n' + 'cars around you',
                    style: primaryText,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 50,
              left: (MediaQuery
                  .of(context)
                  .size
                  .width - 330) / 2,
              child: confirmButton(context),
            ),
          ],
        )
    );
  }

  Widget confirmButton(BuildContext context) {
    return Container(
      width: 330.0,
      child: ButtonTheme(
        height: 50.0,
        child: FlatButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BookingCancelled(),
              ),
            );
          },
          color: blueColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(90.0),
          ),
          child: Text(
            'Cancel',
            style: primaryText,
          ),
        ),
      ),
    );
  }
}
