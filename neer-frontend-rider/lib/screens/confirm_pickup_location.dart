import 'package:flutter/material.dart';
import '../theme/global.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart';
import 'wait_driver_accept_booking.dart';

class ConfirmPickupLoc extends StatefulWidget {
  @override
  _ConfirmPickupLocState createState() => _ConfirmPickupLocState();
}

class _ConfirmPickupLocState extends State<ConfirmPickupLoc> {
  GoogleMapController mapController;
  LatLng fromLoc = new LatLng(37.3501544,-122.07633209999999);
  Marker marker;

  void initState() {
    super.initState();
    setState(() {
      marker = Marker(
        markerId: MarkerId("init"),
        position: fromLoc,
      );
    });
  }

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
                mapType: MapType.normal,
                initialCameraPosition: CameraPosition(
                  target: fromLoc,
                  zoom: 20,
                ),
                onTap: _handleTap,
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
                  marker,
//                Marker(
//                  markerId: MarkerId('From'),
//                  position: ,
//                ),
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
            Positioned(
              bottom: 50,
              left: (MediaQuery.of(context).size.width - 330) / 2,
              child: confirmButton(context),
            ),
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

  void _currentLocation() async {
    Geolocator().getCurrentPosition().then((currloc) {
      mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(currloc.latitude, currloc.longitude),
        zoom: 20.0,
      )));
      setState(() {
        fromLoc = LatLng(currloc.latitude, currloc.longitude);
      });
    });
  }

  void _handleTap(LatLng latlng) {
    setState(() {
      fromLoc = latlng;
      marker = Marker(
        markerId: MarkerId(latlng.toString()),
        position: latlng,
      );
    });
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
                builder: (context) => WaitDriverAcceptBooking(),
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
}
