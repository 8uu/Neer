import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:login/screens/set_pickup_destination.dart';
import 'package:login/theme/global.dart';
import 'dart:async';
import 'dart:math' show cos, sqrt, asin;

class BookRideDetailDialog extends StatefulWidget {
  const BookRideDetailDialog({
    Key key,
    @required this.start,
    @required this.end,
    @required Completer<GoogleMapController> controller,
  })  : _controller = controller,
        super(key: key);

  final LatLng start;
  final LatLng end;
  final Completer<GoogleMapController> _controller;

  @override
  _BookRideDetailDialogState createState() => _BookRideDetailDialogState();
}

class _BookRideDetailDialogState extends State<BookRideDetailDialog>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> scaleAnimation;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GoogleMapController mapController;
  TextEditingController pickupTextController = new TextEditingController();
  TextEditingController whereTotextController = new TextEditingController();

  final startAddressController = TextEditingController();
  final destinationAddressController = TextEditingController();
  final Geolocator _geolocator = Geolocator();
  Position _currentPosition;
  String _currentAddress;
  String _startAddress = '';
  String _destinationAddress = '';
  String _placeDistance;
  Set<Marker> markers = {};
  PolylinePoints polylinePoints;
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];

  GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);
  String pickupAddr;
  String dropOffAddr;
  String username = "John";
  Marker marker =
      Marker(markerId: MarkerId("init"), position: LatLng(40.7128, -74.0060));
  bool mapToggle = false;
  var currentLocation;
  LatLng tappedLoc;
  Address results;
  LatLng home = new LatLng(37.3501544, -122.07633209999999);
  Mode _mode = Mode.overlay;

  @override
  void initState() {
    super.initState();
    Geolocator().getCurrentPosition().then((currloc) {
      setState(() {
        currentLocation = currloc;
        mapToggle = true;
      });
    });

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    var boxSize = 0.42;
    var hBox = h * boxSize;

    return Material(
      color: Colors.transparent,
      child: ScaleTransition(
        scale: scaleAnimation,
        child: MaterialApp(
          theme: ThemeData(fontFamily: 'Montserrat'),
          home: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(190),
              child: AppBar(
                backgroundColor: blueColor,
                centerTitle: true,
                title: Text(
                  'Book a Ride',
                  style: TextStyle(color: Colors.black),
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
                      // Navigator.of(context)
                      //     .popUntil((route) =>
                      //         route.isFirst);
                      // Navigator.pop(context);
                      // Navigator.of(context,
                      //         rootNavigator: true)
                      //     .pop();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SetPickupDestination(),
                        ),
                      );
                    },
                  ),
                ),
                flexibleSpace: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 60),
                    Container(
                      width: 350,
                      child: TextFormField(
                        decoration: InputDecoration(
                          icon: Icon(
                            Icons.access_time,
                            color: Colors.grey,
                            size: 24,
                          ),
                          isDense: true,
                          hintText: 'Set Date & Time',
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 2,
                            ),
                          ),
                        ),
                        initialValue: 'Wed July 22, 10:00 AM',
                      ),
                    ),
                    Container(
                      width: 350,
                      child: TextFormField(
                        // controller: pickupTextController,
                        controller: startAddressController,
                        onTap: () {
                          startAddressController.text = _currentAddress;
                          _startAddress = _currentAddress;
                        },

                        // onChanged: (val) {
                        //   setState(() {
                        //     pickupAddr = val;
                        //   });
                        // },
                        // onTap: () {
                        //   _handlePickupLoc();
                        // },
                        decoration: InputDecoration(
                          icon: Icon(
                            Icons.trip_origin,
                            color: Colors.green,
                            size: 24,
                          ),
                          isDense: true,
                          hintText: 'Pickup Location',
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 2,
                            ),
                          ),
                        ),
                        // initialValue: '420 Taylor St',
                      ),
                    ),
                    Container(
                      width: 350,
                      child: TextFormField(
                        controller: whereTotextController,
                        onChanged: (val) {
                          setState(() {
                            dropOffAddr = val;
                          });
                        },
                        onTap: () {
                          _handleWhereToField();
                        },
                        decoration: InputDecoration(
                          icon: Icon(
                            Icons.place,
                            color: darkPurpleColor,
                            size: 24,
                          ),
                          isDense: true,
                          hintText: 'Where to?',
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 2,
                            ),
                          ),
                        ),
                        // initialValue: '201 Berry St',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            body: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: mapToggle
                  ? GoogleMap(
                      mapType: MapType.normal,
                      initialCameraPosition: CameraPosition(
                        target: LatLng(currentLocation.latitude,
                            currentLocation.longitude),
                        zoom: 15,
                      ),
                      // onTap: _handleTap,
                      onMapCreated: (GoogleMapController controller) {
                        setState(() {
                          mapController = controller;
                        });
//                _controller.complete(controller);
                      },
                      zoomGesturesEnabled: true,
                      zoomControlsEnabled: false,
                      myLocationButtonEnabled: true,
                      myLocationEnabled: true,
                      // markers: {
                      //   marker,
//                Marker(
//                  markerId: MarkerId('From'),
//                  position: ,
//                ),
                      // },
                      markers:
                          markers != null ? Set<Marker>.from(markers) : null,
                      polylines: Set<Polyline>.of(polylines.values),
                    )
                  : Center(
                      child: Text(
                        'Loading.. Please wait..',
                        style: primaryText,
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _handlePickupLoc() async {
    // show input autocomplete with selected mode
    // then get the Prediction selected
    Prediction p = await PlacesAutocomplete.show(
      context: context,
      apiKey: kGoogleApiKey,
      onError: onError,
      mode: _mode,
      language: "en",
      components: [Component(Component.country, "usa")],
      logo: Container(
        width: 0,
        height: 0,
      ),
    );
    displayPrediction(p, homeScaffoldKey.currentState);
  }

  Future<void> _handleWhereToField() async {
    // show input autocomplete with selected mode
    // then get the Prediction selected
    Prediction p = await PlacesAutocomplete.show(
      context: context,
      apiKey: kGoogleApiKey,
      onError: onError,
      mode: _mode,
      language: "en",
      components: [Component(Component.country, "usa")],
      logo: Container(
        width: 0,
        height: 0,
      ),
    );
    displayPredictionWhereTo(p, homeScaffoldKey.currentState);
  }

  Future<Null> displayPrediction(Prediction p, ScaffoldState scaffold) async {
    if (p != null) {
      // get detail (lat/lng)
      PlacesDetailsResponse detail =
          await _places.getDetailsByPlaceId(p.placeId);
      final lat = detail.result.geometry.location.lat;
      final lng = detail.result.geometry.location.lng;
      marker = Marker(
          markerId: MarkerId("${p.description} - $lat/$lng"),
          position: LatLng(lat, lng));
      mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(lat, lng),
        zoom: 15.0,
      )));
      mapController.animateCamera(CameraUpdate.newLatLng(LatLng(lat, lng)));
      this.pickupTextController.text = p.description;
      FocusScope.of(context).requestFocus(FocusNode());
//    scaffold.showSnackBar(
//      SnackBar(content: Text("${p.description} - $lat/$lng")),
//    );
    }
  }

  Future<Null> displayPredictionWhereTo(
      Prediction p, ScaffoldState scaffold) async {
    if (p != null) {
      // get detail (lat/lng)
      PlacesDetailsResponse detail =
          await _places.getDetailsByPlaceId(p.placeId);
      final lat = detail.result.geometry.location.lat;
      final lng = detail.result.geometry.location.lng;
      marker = Marker(
          markerId: MarkerId("${p.description} - $lat/$lng"),
          position: LatLng(lat, lng));
      mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(lat, lng),
        zoom: 15.0,
      )));
      mapController.animateCamera(CameraUpdate.newLatLng(LatLng(lat, lng)));
      this.whereTotextController.text = p.description;
      FocusScope.of(context).requestFocus(FocusNode());
//    scaffold.showSnackBar(
//      SnackBar(content: Text("${p.description} - $lat/$lng")),
//    );
    }
  }

  void onError(PlacesAutocompleteResponse response) {
    homeScaffoldKey.currentState.showSnackBar(
      SnackBar(content: Text(response.errorMessage)),
    );
  }

  // _zoomIn() {
  //   mapController.animateCamera(
  //     CameraUpdate.zoomBy(
  //       0.5,
  //       Offset((MediaQuery.of(context).size.width / 2),
  //           (MediaQuery.of(context).size.height / 2)),
  //     ),
  //   );
  // }

  // _zoomOut() {
  //   mapController.animateCamera(
  //     CameraUpdate.zoomBy(
  //       -0.5,
  //       Offset((MediaQuery.of(context).size.width / 2),
  //           (MediaQuery.of(context).size.height / 2)),
  //     ),
  //   );
  // }

  searchandNavigate() async {
    try {
      List<Placemark> placemark =
          await Geolocator().placemarkFromAddress(pickupAddr);
      Placemark newPlace = placemark[0];
      marker = Marker(
          markerId: MarkerId(pickupAddr),
          position:
              LatLng(newPlace.position.latitude, newPlace.position.longitude));
      mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(newPlace.position.latitude, newPlace.position.longitude),
        zoom: 15.0,
      )));
      mapController.animateCamera(CameraUpdate.newLatLng(
          LatLng(newPlace.position.latitude, newPlace.position.longitude)));
    } catch (e) {
      print(e);
    }
  }

  // searchDropOffAddr() async {
  //   try {
  //     List<Placemark> placemark =
  //         await Geolocator().placemarkFromAddress(dropOffAddr);
  //     Placemark newPlace = placemark[0];
  //     marker = Marker(
  //         markerId: MarkerId(dropOffAddr),
  //         position:
  //             LatLng(newPlace.position.latitude, newPlace.position.longitude));
  //     mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
  //       target: LatLng(newPlace.position.latitude, newPlace.position.longitude),
  //       zoom: 15.0,
  //     )));
  //     mapController.animateCamera(CameraUpdate.newLatLng(
  //         LatLng(newPlace.position.latitude, newPlace.position.longitude)));
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  void _currentLocation() async {
    Geolocator().getCurrentPosition().then((currloc) {
      mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(currentLocation.latitude, currentLocation.longitude),
        zoom: 15.0,
      )));
    });
  }

//   void _handleTap(LatLng latlng) {
//     FocusScope.of(context).requestFocus(FocusNode());
//     setState(() {
//       marker = Marker(
//         markerId: MarkerId(latlng.toString()),
//         position: latlng,
// //        draggable: true,
//       );
//       tappedLoc = latlng;
//       getAddress(tappedLoc).then((response) {
//         print(response.coordinates);
//         this.textController.text = response.addressLine;
//       });
//     });
//    print(this.results);
  // }

  // getAddress(LatLng loc) async {
  //   try {
  //     var results = await Geocoder.local.findAddressesFromCoordinates(
  //         new Coordinates(loc.latitude, loc.longitude));
  //     return results.first;
//      this.setState(() {
//        this.results = results.first;
//        print(results.first.addressLine);
//      });
  //   } catch (e) {
  //     print("Error occured: $e");
  //   }
  // }

  _getStartAddress() async {
    try {
      // Places are retrieved using the coordinates
      List<Placemark> p = await _geolocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      // Taking the most probable result
      Placemark place = p[0];

      setState(() {
        // Structuring the address
        _currentAddress =
            "${place.name}, ${place.locality}, ${place.postalCode}, ${place.country}";

        // Update the text of the TextField
        startAddressController.text = _currentAddress;

        // Setting the user's present location as the starting address
        _startAddress = _currentAddress;
      });
    } catch (e) {
      print(e);
    }
  }

  _getDestinationAddress() async {
    try {
      // Places are retrieved using the coordinates
      List<Placemark> p = await _geolocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      // Taking the most probable result
      Placemark place = p[0];

      setState(() {
        // Structuring the address
        _currentAddress =
            "${place.name}, ${place.locality}, ${place.postalCode}, ${place.country}";

        // Update the text of the TextField
        destinationAddressController.text = _currentAddress;

        // Setting the user's present location as the starting address
        _destinationAddress = _currentAddress;
      });
    } catch (e) {
      print(e);
    }
  }

  // Method for calculating the distance between two places
  Future<bool> _calculateDistance() async {
    try {
      // Retrieving placemarks from addresses
      List<Placemark> startPlacemark =
          await _geolocator.placemarkFromAddress(_startAddress);
      List<Placemark> destinationPlacemark =
          await _geolocator.placemarkFromAddress(_destinationAddress);

      if (startPlacemark != null && destinationPlacemark != null) {
        // Use the retrieved coordinates of the current position,
        // instead of the address if the start position is user's
        // current position, as it results in better accuracy.
        Position startCoordinates = _startAddress == _currentAddress
            ? Position(
                latitude: _currentPosition.latitude,
                longitude: _currentPosition.longitude)
            : startPlacemark[0].position;
        Position destinationCoordinates = destinationPlacemark[0].position;

        // Start Location Marker
        Marker startMarker = Marker(
          markerId: MarkerId('$startCoordinates'),
          position: LatLng(
            startCoordinates.latitude,
            startCoordinates.longitude,
          ),
          infoWindow: InfoWindow(
            title: 'Start',
            snippet: _startAddress,
          ),
          icon: BitmapDescriptor.defaultMarker,
        );

        // Destination Location Marker
        Marker destinationMarker = Marker(
          markerId: MarkerId('$destinationCoordinates'),
          position: LatLng(
            destinationCoordinates.latitude,
            destinationCoordinates.longitude,
          ),
          infoWindow: InfoWindow(
            title: 'Destination',
            snippet: _destinationAddress,
          ),
          icon: BitmapDescriptor.defaultMarker,
        );

        // Adding the markers to the list
        markers.add(startMarker);
        markers.add(destinationMarker);

        print('START COORDINATES: $startCoordinates');
        print('DESTINATION COORDINATES: $destinationCoordinates');

        Position _northeastCoordinates;
        Position _southwestCoordinates;

        // Calculating to check that
        // southwest coordinate <= northeast coordinate
        if (startCoordinates.latitude <= destinationCoordinates.latitude) {
          _southwestCoordinates = startCoordinates;
          _northeastCoordinates = destinationCoordinates;
        } else {
          _southwestCoordinates = destinationCoordinates;
          _northeastCoordinates = startCoordinates;
        }

        // Accommodate the two locations within the
        // camera view of the map
        mapController.animateCamera(
          CameraUpdate.newLatLngBounds(
            LatLngBounds(
              northeast: LatLng(
                _northeastCoordinates.latitude,
                _northeastCoordinates.longitude,
              ),
              southwest: LatLng(
                _southwestCoordinates.latitude,
                _southwestCoordinates.longitude,
              ),
            ),
            100.0,
          ),
        );

        // Calculating the distance between the start and the end positions
        // with a straight path, without considering any route
        // double distanceInMeters = await Geolocator().bearingBetween(
        //   startCoordinates.latitude,
        //   startCoordinates.longitude,
        //   destinationCoordinates.latitude,
        //   destinationCoordinates.longitude,
        // );

        await _createPolylines(startCoordinates, destinationCoordinates);

        double totalDistance = 0.0;

        // Calculating the total distance by adding the distance
        // between small segments
        for (int i = 0; i < polylineCoordinates.length - 1; i++) {
          totalDistance += _coordinateDistance(
            polylineCoordinates[i].latitude,
            polylineCoordinates[i].longitude,
            polylineCoordinates[i + 1].latitude,
            polylineCoordinates[i + 1].longitude,
          );
        }

        setState(() {
          _placeDistance = totalDistance.toStringAsFixed(2);
          print('DISTANCE: $_placeDistance km');
        });

        return true;
      }
    } catch (e) {
      print(e);
    }
    return false;
  }

  // Formula for calculating distance between two coordinates
  // https://stackoverflow.com/a/54138876/11910277
  double _coordinateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  // Create the polylines for showing the route between two places
  _createPolylines(Position start, Position destination) async {
    polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      kGoogleApiKey, // Google Maps API Key
      PointLatLng(start.latitude, start.longitude),
      PointLatLng(destination.latitude, destination.longitude),
      // travelMode: TravelMode.transit,
    );

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }

    PolylineId id = PolylineId('poly');
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.red,
      points: polylineCoordinates,
      width: 3,
    );
    polylines[id] = polyline;
  }
}
