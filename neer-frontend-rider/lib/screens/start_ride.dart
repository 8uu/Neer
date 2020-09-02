import 'package:flutter/material.dart';
import '../theme/global.dart';
import 'dart:async';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'bookingCancellation.dart';
import 'package:url_launcher/url_launcher.dart';

class StartRide extends StatefulWidget {
  @override
  _StartRideState createState() => _StartRideState();
}

class _StartRideState extends State<StartRide> {
  GoogleMapController mapController;
  LatLng start = new LatLng(37.416780, -122.077430);
  LatLng end = new LatLng(37.426780, -122.077430);
  Completer<GoogleMapController> _controller = Completer();
  static var endAddr = "2621 N Shoreline Blvd, Mountain View, CA 94043, USA";
  var arriveTime = '10'; //minutes
  static var driverName = "John Doe";
  static var phoneNum = "123-456-7890";
  LatLng fromLoc = new LatLng(40.7128, -74.0060);
  ValueNotifier<bool> _valueNotifier = new ValueNotifier(true);

  void initState() {
    super.initState();
    _valueNotifier.addListener(update);
  }

  @override
  void dispose() {
    super.dispose();
    _valueNotifier.removeListener(update);
  }

  void update() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    var boxSize = 0.38;
    var hBox = h * boxSize;

    return Scaffold(
      body: Stack(
        children: <Widget>[
//          Container(
//            height: MediaQuery.of(context).size.height,
//            width: MediaQuery.of(context).size.width,
//            child: GoogleMap(
//              mapType: MapType.normal,
//              initialCameraPosition: CameraPosition(
//                target: LatLng((start.latitude + end.latitude) / 2, (start.longitude + end.longitude) / 2),
//                zoom: 15,
//              ),
//              onMapCreated: (GoogleMapController controller) {
//                _controller.complete(controller);
//              },
//              zoomGesturesEnabled: true,
//              zoomControlsEnabled: false,
//              markers: {
////                Marker(
////                  markerId: MarkerId('From'),
////                  position: start,
////                ),
////                Marker(
////                  markerId: MarkerId('To'),
////                  position: end,
////                ),
//              },
//            ),
//          ),
//          showAlertDialog(w, h),
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: CameraPosition(
                target: fromLoc,
                zoom: 20,
              ),
              onMapCreated: (GoogleMapController controller) {
                setState(() {
                  mapController = controller;
                });
//                _controller.complete(controller);
              },
              zoomGesturesEnabled: true,
              zoomControlsEnabled: false,
              myLocationButtonEnabled: true,
              markers:
              {
                Marker(
                  markerId: MarkerId("waitLoc"),
                  position: fromLoc,
                ),
              },
            ),
          ),
          Positioned(
            top: 160,
            left: 20,
            child: Container(
              width: 30,
              height: 30,
              child: FloatingActionButton(
                heroTag: "zoomin",
                shape: RoundedRectangleBorder(),
                onPressed: _zoomIn,
                child: Icon(MdiIcons.plus, size: 16, color: Colors.black,),
                backgroundColor: Colors.grey[200],
              ),
            ),
          ),
          Positioned(
            top: 191,
            left: 20,
            child: Container(
              width: 30,
              height: 30,
              child: FloatingActionButton(
                heroTag: "zoomout",
                onPressed: _zoomOut,
                shape: RoundedRectangleBorder(),
                child: Icon(MdiIcons.minus, size: 16,color: Colors.black,),
                backgroundColor: Colors.grey[200],
              ),
            ),
          ),
          Positioned(
            top: 80,
            right: 18,
            child: Container(
              width: 35,
              height: 35,
              child: FloatingActionButton(
                heroTag: "curloc",
                onPressed: _currentLocation,
                child: Icon(Icons.location_on, size: 18, color: Colors.black,),
                backgroundColor: blueColor,
              ),
            ),
          ),
          DraggableScrollableSheet(
            maxChildSize: boxSize,
            minChildSize: 0.02,
            initialChildSize: boxSize,
            builder: (context, scrollController) {
              return SingleChildScrollView(
                controller: scrollController,
                child: Container(
                    height: hBox,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/scroll_bar.jpg'),
                          fit: BoxFit.fill
                      ),
                    ),
                    alignment: Alignment.center,
                    padding: EdgeInsets.fromLTRB(0.04 * w, 0.02 * hBox, 0.04 * w, 0.01 * hBox),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            ridingInfo(w, hBox),
                            driverInfo(context, w, hBox),
                          ],
                        ),
                        SizedBox(
                          height: hBox * 0.05,
                        ),
                        confirmButton(context, w, h),
                        SizedBox(
                          height: hBox * 0.05,
                        ),
                        cancellation(context, w, h),
                      ],
                    )
                ),
              );
            },
          ),
          ValueListenableBuilder(
            valueListenable: _valueNotifier,
            builder: (BuildContext context, bool flag, Widget child) {
              if(flag == true) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  elevation: 16,
                  title: Text(
                    'Alert',
                    style: primaryText,
                  ),
                  content: Container(
//                      height: h * 0.04,
//                    width: w * 0.2,
                    child: Text(
                      'Abnormal stop / Route deviation',
                      style: primaryText,
                    ),
                  ),
                  actions: <Widget>[
                    Container(
                      child: Row(
                        children: <Widget>[
                          FlatButton(
                            child: Text(
                              'Contact driver',
                              style: primaryText,
                            ),
                            onPressed: (){
                              String url = 'tel://' + phoneNum;
                              launch((url));
                            },
                          ),
                          FlatButton(
                            child: Text(
                              'Close',
                              style: primaryText,
                            ),
                            onPressed: () {
                              setState(() {
                                _valueNotifier.value = false;
                              });
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => build(context),
                                ),
                              );
                            },
                          )
                        ],
                      ),
                    ),

                  ],
                );
              }
              return Container(width: 0.0, height: 0.0);
            },
          ),
        ],
      ),
    );
  }

//  showAlertDialog(var w, var h) {
//    if(abnormal) {
//      showDialog(
//          context: context,
//          builder: (context) {
//            return AlertDialog(
//              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//              elevation: 16,
//              title: Text(
//                'Cancellation fee',
//                style: primaryText,
//              ),
//              content: Container(
//                height: h * 0.2,
//                width: w * 0.6,
//                child: Text(
//                  'Cancellation fee' + '\n' + '...',
//                  style: primaryText,
//                ),
//              ),
//              actions: <Widget>[
//                FlatButton(
//                  child: Text(
//                    'Close',
//                    style: primaryText,
//                  ),
//                  onPressed: () {
//                    Navigator.of(context).pop();
//                  },
//                )
//              ],
//            );
//          }
//      );
//    }
//  }

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

  void _currentLocation() async {
    Geolocator().getCurrentPosition().then((currloc) {
      mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(currloc.latitude, currloc.longitude),
        zoom: 20.0,
      )));
    });
  }

  Widget ridingInfo(var w, var h) {
    return Container(
      width: 0.64 * w,
      height: 0.45 * h,
      alignment: Alignment.center,
      child: Column(
        children: <Widget>[
          Container(
            height: 0.2 * h,
            alignment: Alignment.center,
            child: riding
          ),
          Container(
            height: 0.12 * h,
            alignment: Alignment.center,
            margin: EdgeInsets.only(left: 0.02 * w),
            child: Item(Icon(MdiIcons.mapMarker, size: 16,), endAddr, w * 0.07, w * 0.54, w * 0.01),
          ),
          Container(
            height: 0.12 * h,
            alignment: Alignment.center,
            margin: EdgeInsets.only(left: 0.02 * w),
            child: Item(Icon(Icons.timer, size: 16,), "Arriving in $arriveTime minutes", w * 0.07, w * 0.54, w * 0.01),
          )
        ],
      ),
    );
  }

  Widget riding = RichText(
      text: TextSpan(
        text: 'You are riding with $driverName',
        style: TextStyle(
          fontFamily: 'Montserrat',
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
  );

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

  Widget driverInfo(BuildContext context, var w, var h) {
    return Container(
      alignment: Alignment.center,
      width: 0.28 * w,
      height: 0.45 * h,
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            height: 0.25 * h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(90),
            ),
            child: driver,
          ),
          Container(
            alignment: Alignment.center,
            height: 0.2 * h,
            child: FlatButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onPressed: () {
//                String url = 'tel://' + phoneNum;
//                launch((url));
              },
              child: Text(
                'Live Cam',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  fontFamily: 'Montserrat',
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget driver = IconButton(
    icon: Image.asset('assets/maleIcon.png'),
  );

  Widget cancellation(context, var w, var h) {
    return Column(
      children: <Widget>[
        Text(
          'Cancellation fee of 5 applies within 3 minutes',
          style: TextStyle(
            fontFamily: 'Montserrat',
            color: Colors.black,
            fontSize: 15,
          ),
        ),
        Container(
          height: 17,
          child: FlatButton(
//            splashColor: Colors.transparent,
//            highlightColor: Colors.transparent,
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      elevation: 16,
                      title: Text(
                        'Cancellation fee',
                        style: primaryText,
                      ),
                      content: Container(
                        height: h * 0.2,
                        width: w * 0.6,
                        child: Text(
                          'Cancellation fee' + '\n' + '...',
                          style: primaryText,
                        ),
                      ),
                      actions: <Widget>[
                        FlatButton(
                          child: Text(
                            'Close',
                            style: primaryText,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        )
                      ],
                    );
                  }
              );
            },
            child: Text(
              'Learn More',
              style: TextStyle(
                decoration: TextDecoration.underline,
                fontFamily: 'Montserrat',
                color: Colors.black,
                fontSize: 15,
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget confirmButton(BuildContext context, var w, var h) {
    return Container(
      width: 330.0,
      child: ButtonTheme(
        height: 50.0,
        child: FlatButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    elevation: 16,
                    title: Text(
                      'Are you sure to cancel this order?',
                      style: primaryText,
                    ),
                    content: Container(
//                      height: h * 0.04,
                      width: w * 0.6,
                      child: Text(
                        'Cancellation fee: ...',
                        style: primaryText,
                      ),
                    ),
                    actions: <Widget>[
                      FlatButton(
                        child: Text(
                          'Confirm',
                          style: primaryText,
                        ),
                        onPressed: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BookingCancelled(),
                            ),
                          );
                        },
                      ),
                      FlatButton(
                        child: Text(
                          'Close',
                          style: primaryText,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      )
                    ],
                  );
                }
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


