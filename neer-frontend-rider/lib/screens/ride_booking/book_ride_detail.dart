import 'package:flutter/material.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'dart:math' show cos, sqrt, asin;

import 'package:login/theme/global.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class BookRideDetail extends StatefulWidget {
  @override
  _BookRideDetailState createState() => _BookRideDetailState();
}

class _BookRideDetailState extends State<BookRideDetail> {
  CameraPosition _initialLocation = CameraPosition(target: LatLng(0.0, 0.0));
  GoogleMapController mapController;

  final Geolocator _geolocator = Geolocator();

  Position _currentPosition;
  String _currentAddress;

  final startAddressController = TextEditingController();
  final destinationAddressController = TextEditingController();

  String _startAddress = '';
  String _destinationAddress = '';
  String _placeDistance;

  Set<Marker> markers = {};

  PolylinePoints polylinePoints;
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];

  Animation<double> scaleAnimation;

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final homeScaffoldKey = GlobalKey<ScaffoldState>();

  GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);
  Mode _mode = Mode.overlay;
  Marker marker =
      Marker(markerId: MarkerId("init"), position: LatLng(40.7128, -74.0060));

  Widget _setTimeTextField({
    TextEditingController controller,
    // String label,
    String hint,
    String initialValue,
    double width,
    Icon icon,
    Widget suffixIcon,
    Function(String) locationCallback,
  }) {
    return Container(
      width: 300,
      child: TextFormField(
        // onChanged: (value) {
        //   locationCallback(value);
        // },
        controller: controller,
        initialValue: initialValue,
        textAlign: TextAlign.left,
        style: TextStyle(fontSize: 15),
        decoration: new InputDecoration(
          icon: icon,
          suffixIcon: suffixIcon,
          isDense: true,
          // labelText: label,
          // filled: true,
          // fillColor: Colors.white,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
              width: 2,
            ),
          ),
          contentPadding: EdgeInsets.all(10),
          hintText: hint,
        ),
      ),
    );
  }

  Widget _pickupTextField({
    TextEditingController controller,
    // String label,
    String hint,
    String initialValue,
    double width,
    Icon icon,
    Widget suffixIcon,
    Function(String) locationCallback,
  }) {
    return Container(
      width: 300,
      child: TextFormField(
        // onTap: () {
        //   _handlePickupLoc();
        // },
        onChanged: (value) {
          locationCallback(value);
        },
        controller: controller,
        initialValue: initialValue,
        textAlign: TextAlign.left,
        style: TextStyle(fontSize: 15),
        decoration: new InputDecoration(
          icon: icon,
          suffixIcon: suffixIcon,
          isDense: true,
          // labelText: label,
          // filled: true,
          // fillColor: Colors.white,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
              width: 2,
            ),
          ),
          contentPadding: EdgeInsets.all(10),
          hintText: hint,
        ),
      ),
    );
  }

  Widget _destinationTextField({
    TextEditingController controller,
    // String label,
    String hint,
    String initialValue,
    double width,
    Icon icon,
    Widget suffixIcon,
    Function(String) locationCallback,
  }) {
    return Container(
      width: 300,
      child: TextFormField(
        // onTap: () {
        //   _handleDestinationField();
        // },
        onChanged: (value) {
          locationCallback(value);
        },
        controller: controller,
        initialValue: initialValue,
        textAlign: TextAlign.left,
        style: TextStyle(fontSize: 15),
        decoration: new InputDecoration(
          icon: icon,
          suffixIcon: suffixIcon,
          isDense: true,
          // labelText: label,
          // filled: true,
          // fillColor: Colors.white,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
              width: 2,
            ),
          ),
          contentPadding: EdgeInsets.all(10),
          hintText: hint,
        ),
      ),
    );
  }

  // Method for retrieving the current location
  _getCurrentLocation() async {
    await _geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
      setState(() {
        _currentPosition = position;
        print('CURRENT POS: $_currentPosition');
        mapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(position.latitude, position.longitude),
              zoom: 18.0,
            ),
          ),
        );
      });
      await _getAddress();
    }).catchError((e) {
      print(e);
    });
  }

  // Method for retrieving the address
  _getAddress() async {
    try {
      List<Placemark> p = await _geolocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = p[0];

      setState(() {
        _currentAddress =
            "${place.name}, ${place.locality}, ${place.postalCode}, ${place.country}";
        startAddressController.text = _currentAddress;
        _startAddress = _currentAddress;
      });
    } catch (e) {
      print(e);
    }
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
    displayPickupPrediction(p, homeScaffoldKey.currentState);
  }

  Future<Null> displayPickupPrediction(
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
      this.startAddressController.text = p.description;
      FocusScope.of(context).requestFocus(FocusNode());
    }
  }

  Future<void> _handleDestinationField() async {
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
      this.destinationAddressController.text = p.description;
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
      // travelMode: TravelMode.driving,
    );

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }

    PolylineId id = PolylineId('poly');
    Polyline polyline = Polyline(
      polylineId: id,
      color: darkPurpleColor,
      points: polylineCoordinates,
      width: 6,
    );
    polylines[id] = polyline;
  }

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      height: height,
      width: width,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'Montserrat'),
        home: Scaffold(
          key: _scaffoldKey,
          body: Stack(
            children: <Widget>[
              // Map View
              GoogleMap(
                markers: markers != null ? Set<Marker>.from(markers) : null,
                initialCameraPosition: _initialLocation,
                myLocationEnabled: true,
                myLocationButtonEnabled: false,
                mapType: MapType.normal,
                zoomGesturesEnabled: true,
                zoomControlsEnabled: false,
                polylines: Set<Polyline>.of(polylines.values),
                onMapCreated: (GoogleMapController controller) {
                  mapController = controller;
                },
              ),
              // Show zoom buttons
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Flexible(child: SizedBox(height: 50)),
                      Container(
                        width: 30,
                        height: 30,
                        child: FloatingActionButton(
                          heroTag: "zoomin",
                          onPressed: () {
                            mapController.animateCamera(
                              CameraUpdate.zoomIn(),
                            );
                          },
                          shape: RoundedRectangleBorder(),
                          child: Icon(
                            MdiIcons.plus,
                            size: 16,
                            color: Colors.black,
                          ),
                          backgroundColor: Colors.grey[200],
                        ),
                      ),
                      SizedBox(height: 2),
                      Container(
                        width: 30,
                        height: 30,
                        child: FloatingActionButton(
                          heroTag: "zoomout",
                          shape: RoundedRectangleBorder(),
                          onPressed: () {
                            mapController.animateCamera(
                              CameraUpdate.zoomOut(),
                            );
                          },
                          child: Icon(
                            MdiIcons.minus,
                            size: 16,
                            color: Colors.black,
                          ),
                          backgroundColor: Colors.grey[200],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Show the place input fields & button for
              // showing the route
              SafeArea(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: blueColor,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                      width: width * 0.9,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 3.0, bottom: 3.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                IconButton(
                                  icon: Icon(Icons.arrow_back_ios),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                SizedBox(width: 60),
                                Text(
                                  'Book a Ride',
                                  style: TextStyle(fontSize: 20.0),
                                ),
                              ],
                            ),
                            _setTimeTextField(
                              hint: 'Set Date & Time',
                              icon: Icon(
                                Icons.access_time,
                                color: Colors.grey,
                                size: 24,
                              ),
                              width: width,
                              initialValue: 'Wed July 22, 10:00 AM',
                              locationCallback: (String value) {
                                setState(() {});
                              },
                            ),
                            _pickupTextField(
                                // label: 'Start',
                                hint: 'Pickup Location?',
                                icon: Icon(
                                  Icons.trip_origin,
                                  color: Colors.green,
                                  size: 24,
                                ),
                                // suffixIcon: IconButton(
                                //   icon: Icon(Icons.my_location),
                                //   onPressed: () {
                                //     startAddressController.text = _currentAddress;
                                //     _startAddress = _currentAddress;
                                //   },
                                // ),
                                controller: startAddressController,
                                width: width,
                                locationCallback: (String value) {
                                  setState(() {
                                    _startAddress = value;
                                  });
                                }),

                            // SizedBox(height: 10),
                            _destinationTextField(
                                // label: 'Destination',
                                hint: 'Where to?',
                                icon: Icon(
                                  Icons.place,
                                  color: darkPurpleColor,
                                  size: 24,
                                ),
                                controller: destinationAddressController,
                                width: width,
                                locationCallback: (String value) {
                                  setState(() {
                                    _destinationAddress = value;
                                  });
                                }),

                            SizedBox(height: 5),
                            Visibility(
                              visible: _placeDistance == null ? false : true,
                              child: Text(
                                'Distance: $_placeDistance km',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(height: 5),
                            RaisedButton(
                              onPressed:
                                  // (this.startAddressController.text !=
                                  //             '' &&
                                  //         this.destinationAddressController.text !=
                                  //             '')
                                  //     ?
                                  () async {
                                setState(() {
                                  if (markers.isNotEmpty) markers.clear();
                                  if (polylines.isNotEmpty) polylines.clear();
                                  if (polylineCoordinates.isNotEmpty)
                                    polylineCoordinates.clear();
                                  _placeDistance = null;
                                });

                                _calculateDistance().then((isCalculated) {
                                  if (isCalculated) {
                                    _scaffoldKey.currentState.showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            'Distance Calculated Sucessfully'),
                                      ),
                                    );
                                  } else {
                                    _scaffoldKey.currentState.showSnackBar(
                                      SnackBar(
                                        content:
                                            Text('Error Calculating Distance'),
                                      ),
                                    );
                                  }
                                });
                              },
                              // : null,
                              color: darkPurpleColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Show Route',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // Show current location button
              SafeArea(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10.0, bottom: 10.0),
                    child: ClipOval(
                      child: Material(
                        color: blueColor, // button color
                        child: InkWell(
                          // splashColor: Colors.orange,
                          child: SizedBox(
                            width: 56,
                            height: 56,
                            child: Icon(Icons.my_location),
                          ),
                          onTap: () {
                            mapController.animateCamera(
                              CameraUpdate.newCameraPosition(
                                CameraPosition(
                                  target: LatLng(
                                    _currentPosition.latitude,
                                    _currentPosition.longitude,
                                  ),
                                  zoom: 18.0,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
