import 'dart:async';
import 'package:flutter/material.dart';
import '../theme/global.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoder/geocoder.dart';
import 'confirm_pickup_location.dart';

class OrderconfirmationPage extends StatefulWidget {
  @override
  _OrderconfirmationPageState createState() => _OrderconfirmationPageState();
}

class _OrderconfirmationPageState extends State<OrderconfirmationPage> {
  GoogleMapController mapController;
  LatLng start = new LatLng(37.416780, -122.077430);
  LatLng end = new LatLng(37.426780, -122.077430);
  Completer<GoogleMapController> _controller = Completer();
  static var startAddr = "1625 N Shoreline Blvd, Mountain View, CA 94043, USA";
  static var endAddr = "2621 N Shoreline Blvd, Mountain View, CA 94043, USA";
  static var carType = "Car type and color";
  static var appointmentTime = "May 9 10:00 AM";
  static var gender = "Man";
  static Icon genderIcon = gender == "Woman" ? Icon(MdiIcons.humanFemale) : Icon(MdiIcons.humanMale);
  static var age = "40";
  static var payment = '****5578';
  static var estimatedFare = '10.00';
  static var num = "2";

//  void initState() {
//    super.initState();
//    getAddress();
//  }

  findAddress(LatLng loc) async{
    try{
      var results = await Geocoder.local.findAddressesFromCoordinates(
          new Coordinates(loc.latitude, loc.longitude));
      return results.first;
    }
    catch(e) {
      print("Error occured: $e");
    }
  }

//  getAddress() {
//    findAddress(this.start).then((response) {
//      print(response.addressLine);
//      this.startAddr = response.addressLine;
//    });
//    findAddress(this.end).then((response) {
//      print(response.addressLine);
//      this.endAddr = response.addressLine;
//    });
//  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    var boxSize = 0.5;
    var hBox = h * boxSize;

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
                Navigator.push(
                  context,
                  MaterialPageRoute(),
                );
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
                mapType: MapType.normal,
                initialCameraPosition: CameraPosition(
                    target: LatLng((start.latitude + end.latitude) / 2, (start.longitude + end.longitude) / 2),
                    zoom: 15,
                ),
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
                zoomGesturesEnabled: true,
                zoomControlsEnabled: false,
                markers: {
                  Marker(
                    markerId: MarkerId('From'),
                    position: start,
                  ),
                  Marker(
                    markerId: MarkerId('To'),
                    position: end,
                  ),
                },
              ),
            ),
            Order_Info(context, boxSize, w, hBox),
          ],
        )
    );
  }

  _zoomIn() {
    mapController.animateCamera(
      CameraUpdate.zoomBy(
        0.5,
        Offset((MediaQuery.of(context).size.width / 2), (MediaQuery.of(context).size.height / 2)),
      ),
    );
  }

  _zoomOut() {
    mapController.animateCamera(
      CameraUpdate.zoomBy(
        -0.5,
        Offset((MediaQuery.of(context).size.width / 2), (MediaQuery.of(context).size.height / 2)),
      ),
    );
  }

  Widget Order_Info(context, var boxSize, var w, var h) {
    return DraggableScrollableSheet(
      maxChildSize: boxSize,
      minChildSize: 0.02,
      initialChildSize: boxSize,
      builder: (context, scrollController) {
        return SingleChildScrollView(
          controller: scrollController,
          child: Container(
            height: h,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/scroll_bar.jpg'),
                    fit: BoxFit.fill
                ),
              ),
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(0.04 * w, 0.02 * h, 0.04 * w, 0.01 * h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    FirstLine(startAddr, endAddr, w, h, num),
                    RestLine(
                        Icon(MdiIcons.car),
                        carType,
                        Icon(Icons.calendar_today),
                        appointmentTime,
                        w,h,
                    ),
                    RestLine(
                        genderIcon,
                        gender,
                        Icon(Icons.face),
                        age + ' years old',
                        w,h,
                    ),
                    RestLine(
                        Icon(Icons.credit_card),
                        payment,
                        Icon(Icons.attach_money),
                        estimatedFare + '(Estimated)',
                        w,h,
                    ),
                    Container(
                        height: 20,
                        child: FlatButton(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onPressed: () {},
                          child: Text(
                            'Fare estimated details',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontFamily: 'Montserrat',
                              fontSize: 16,
                            ),
                          ),
                        ),
                    ),
                    Container(
                        height: 15,
                    ),
                    confirmButton(context),
                  ],
                ),

          ),

        );
      },
    );
  }
}

//Start and end location, number of passengers
Widget FirstLine(String from, String to, var w, var h, var num) {
  return Container(
    width: w * 0.85,
      child: Row(
        children: <Widget>[
          Container(
            width: w * 0.65,
            child: Column(
              children: <Widget>[
                Item(Icon(MdiIcons.circleMedium), from, w * 0.08, w * 0.55, w * 0.02),
                Item(Icon(MdiIcons.mapMarker), to, w * 0.08, w * 0.55, w * 0.02),
              ],
            ),
          ),
          Container(
            width: w * 0.03,
          ),
          Container(
              width: w * 0.15,
              child: Item(Icon(Icons.people), num, w * 0.08, w * 0.05, w * 0.02),
          ),
        ],
      ),
    );
}

Widget RestLine(Icon icon1, String str1, Icon icon2, String str2, var w, var h) {
  return Container(
    width: w * 0.85,
    child: Row(
      children: <Widget>[
        Container(
          child: Item(icon1, str1, w * 0.07, w * 0.33, w * 0.02),
          width: w * 0.42,
        ),
        Container(
          width: w * 0.42,
          child: Item(icon2, str2, w * 0.07, w * 0.33, w * 0.02),
        ),
      ],
    ),
  );
}

//One icon with one text
Widget Item(Icon icon, String str, var wIcon, var wText, var wSpace) {
  return Container(
//    height: 30,
    margin: EdgeInsets.symmetric(vertical: 8),
    child: Row(
      children: <Widget>[
        Container(
          width: wIcon,
          child: icon,
        ),
        Container(
          width: wSpace,
        ),
        Container(
          width: wText,
          child: Text(
            str,
            style: primaryText,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
      ],
    ),
//    child: RichText(
//      text: TextSpan(
//        children: [
//          WidgetSpan(
//            child: icon,
//          ),
//          TextSpan(
//            text: '   ',
//          ),
//          TextSpan(
//            text: str,
//            style: primaryText,
//          ),
//        ],
//      ),
//    ),
  );
}

//confirm button
Widget confirmButton(context) {
  return Container(
    width: 330.0,
    child: ButtonTheme(
      height: 50.0,
      child: FlatButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ConfirmPickupLoc(),
            ),
          );
        },
        color: blueColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(90.0),
        ),
        child: Text(
          'Confirm',
          style: primaryText,
        ),
      ),
    ),
  );
}