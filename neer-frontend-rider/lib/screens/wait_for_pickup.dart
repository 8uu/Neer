import 'package:flutter/material.dart';
import '../theme/global.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:url_launcher/url_launcher.dart';
import 'bookingCancellation.dart';

class WaitForPickup extends StatefulWidget {
  @override
  _WaitForPickupState createState() => _WaitForPickupState();
}

class _WaitForPickupState extends State<WaitForPickup> {
  GoogleMapController mapController;
  LatLng fromLoc = new LatLng(40.7128, -74.0060);

  //driver's info
  static var driverName = "John Doe";
  static var carType = "Car type and color";
  static var rating = 4.2;
  static var plate = "Plate";
  static var phoneNum = "123-456-7890";


  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    var boxSize = 0.33;
    var hBox = h * boxSize;

    return Scaffold(
        body: Stack(
          children: <Widget>[
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
                              driverAvatar(w, hBox),
                              SizedBox(
                                width: 0.015 * w,
                              ),
                              driverInfo(w, hBox),
                              SizedBox(
                                width: 0.01 * w,
                              ),
                              driverContact(context, w, hBox),
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
          ],
        )
    );
  }

  Widget driverInfo(var w, var h) {
    return Container(
        width: w * 0.38,
        height: h * 0.28,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              '$driverName',
              style: primaryText,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            Text(
              '$carType',
              style: primaryText,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            Row(
              children: <Widget>[
                SmoothStarRating(
                  starCount: 5,
                  rating: rating,
                  size: 16.0,
                  isReadOnly: true,
                  filledIconData: Icons.star,
                  halfFilledIconData: Icons.star_half,
                  defaultIconData: Icons.star_border,
                  color: darkPurpleColor,
                  borderColor: darkPurpleColor,
                  spacing: 3.0,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  '$rating',
                  style: primaryText,
                )
              ],
            ),

          ],
        )
    );
  }

  Widget driverAvatar(var w, var h) {
    return Container(
        width: w * 0.18,
        height: h * 0.2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(90),
        ),
        child: IconButton(
          icon: Image.asset('assets/maleIcon.png'),
        )
    );
  }

  Widget driverContact(context, var w, var h){
    return Container(
      width: w * 0.25,
      height: h * 0.25,
        child: Column(
          children: <Widget>[
            Text(
              '$plate',
              style: primaryText,
            ),
            Container(
              height: 30,
              child: FlatButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: () {
                  String url = 'tel://' + phoneNum;
                  launch((url));
                },
                child: Text(
                  'Contact',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontFamily: 'Montserrat',
                    color: Colors.black,
                    fontSize: 16,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            )
          ],
      ),
    );
  }

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
