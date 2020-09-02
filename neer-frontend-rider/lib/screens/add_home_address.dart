import 'package:flutter/material.dart';
import 'package:login/screens/set_pickup_destination.dart';
import '../theme/global.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'customizeable_saves_page.dart';
//import 'map_plugin/zoombuttons_plugin_option.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';

class AddHomeAddress extends StatefulWidget {
  @override
  _AddHomeAddressState createState() => _AddHomeAddressState();
}

class _AddHomeAddressState extends State<AddHomeAddress> {
  GoogleMapController mapController;
  TextEditingController textController = new TextEditingController();
  TextEditingController labelController = new TextEditingController();
  String searchAddr;
  Marker marker =
      Marker(markerId: MarkerId("init"), position: LatLng(40.7128, -74.0060));
  bool mapToggle = false;
  var currentLocation;
  LatLng tappedLoc;
  Address results;

  void initState() {
    super.initState();
    Geolocator().getCurrentPosition().then((currloc) {
      setState(() {
        currentLocation = currloc;
        mapToggle = true;
      });
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CustomizeableSaves(),
                  ),
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
              child: mapToggle
                  ? GoogleMap(
                      mapType: MapType.normal,
                      initialCameraPosition: CameraPosition(
                        target: LatLng(currentLocation.latitude,
                            currentLocation.longitude),
                        zoom: 15,
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
                      markers: {
                        marker,
//                Marker(
//                  markerId: MarkerId('From'),
//                  position: ,
//                ),
                      },
                    )
                  : Center(
                      child: Text(
                        'Loading.. Please wait..',
                        style: primaryText,
                      ),
                    ),
            ),
            DraggableScrollableSheet(
              maxChildSize: 0.36,
              minChildSize: 0.02,
              initialChildSize: 0.36,
              builder: (context, scrollController) {
                return SingleChildScrollView(
                  controller: scrollController,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/scroll_bar.jpg'),
                          fit: BoxFit.fill),
                    ),
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(30.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            "Add home address",
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        Flexible(
                          child: SizedBox(
                            height: 20,
                          ),
                        ),
                        Flexible(
                          child: TextField(
//                                onTap: ()async {
//                                  Prediction p = await PlacesAutocomplete.show(
//                                    context: context,
//                                    apiKey: "AIzaSyDKS-h0fi6CbBFIO4Bd4rt_KkGlqFQxViE",
//                                    language: "pt",
//                                    components: [
//                                      Component(Component.country, "mz")
//                                    ]
//                                  );
//                                },
                            controller: textController,
                            style: primaryText,
                            decoration: InputDecoration(
                              hintText: 'Enter Address',
//                                    hintStyle: primaryText,
                              enabledBorder: new UnderlineInputBorder(
                                  borderSide:
                                      new BorderSide(color: Colors.grey[600])),
//                                    contentPadding: EdgeInsets.all(15),
                              prefixIcon: IconButton(
                                icon: Icon(Icons.search),
                                color: darkPurpleColor,
                                onPressed: searchandNavigate,
                              ),
                            ),
                            onChanged: (val) {
                              setState(() {
                                searchAddr = val;
                              });
                            },
                          ),
                        ),
                        Flexible(
                          child: SizedBox(
                            height: 10,
                          ),
                        ),
                        // Flexible(
                        //   child: TextField(
                        //     controller: labelController,
                        //     style: primaryText,
                        //     decoration: InputDecoration(
                        //       hintText: 'Label(optional)',
                        //       hintStyle: primaryText,
                        //       enabledBorder: new UnderlineInputBorder(
                        //         borderSide: new BorderSide(
                        //           color: Colors.grey[600],
                        //         ),
                        //       ),
                        //       contentPadding: EdgeInsets.all(15),
                        //       prefixIcon: IconButton(
                        //         icon: Icon(Icons.label),
                        //         color: darkPurpleColor,
                        //         onPressed: searchandNavigate,
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        Flexible(
                          child: SizedBox(
                            height: 30,
                          ),
                        ),
                        Flexible(
                          child: saveButton(context),
                        ),
                        Flexible(
                          child: SizedBox(
                            height: 40,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
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
                  child: Icon(
                    MdiIcons.plus,
                    size: 16,
                    color: Colors.black,
                  ),
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
                  child: Icon(
                    MdiIcons.minus,
                    size: 16,
                    color: Colors.black,
                  ),
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
                  child: Icon(
                    Icons.location_on,
                    size: 18,
                    color: Colors.black,
                  ),
                  backgroundColor: blueColor,
                ),
              ),
            ),
          ],
        ));
  }

  _zoomIn() {
    mapController.animateCamera(
      CameraUpdate.zoomBy(
        0.5,
        Offset((MediaQuery.of(context).size.width / 2),
            (MediaQuery.of(context).size.height / 2)),
      ),
    );
  }

  _zoomOut() {
    mapController.animateCamera(
      CameraUpdate.zoomBy(
        -0.5,
        Offset((MediaQuery.of(context).size.width / 2),
            (MediaQuery.of(context).size.height / 2)),
      ),
    );
  }

  searchandNavigate() async {
    try {
      List<Placemark> placemark =
          await Geolocator().placemarkFromAddress(searchAddr);
      Placemark newPlace = placemark[0];
      marker = Marker(
          markerId: MarkerId(searchAddr),
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

  void _currentLocation() async {
    Geolocator().getCurrentPosition().then((currloc) {
      mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(currentLocation.latitude, currentLocation.longitude),
        zoom: 15.0,
      )));
    });
  }

  void _handleTap(LatLng latlng) {
    setState(() {
      marker = Marker(
        markerId: MarkerId(latlng.toString()),
        position: latlng,
        draggable: true,
      );
      tappedLoc = latlng;
      getAddress(tappedLoc).then((response) {
        print(response.coordinates);
        this.textController.text = response.addressLine;
      });
    });
//    print(this.results);
  }

  getAddress(LatLng loc) async {
    try {
      var results = await Geocoder.local.findAddressesFromCoordinates(
          new Coordinates(loc.latitude, loc.longitude));
      return results.first;
//      this.setState(() {
//        this.results = results.first;
//        print(results.first.addressLine);
//      });
    } catch (e) {
      print("Error occured: $e");
    }
  }

  Widget saveButton(BuildContext context) {
    return Container(
      width: 330.0,
      child: ButtonTheme(
        height: 50.0,
        child: FlatButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SetPickupDestination(),
              ),
            );
          },
          color: blueColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(90.0),
          ),
          child: Text(
            'Save',
            style: primaryText,
          ),
        ),
      ),
    );
  }

//  MapController mapController = new MapController();
//  LatLng tappedPoints = new LatLng(34.056340, -118.232050);
//  var times = 0;
//  TextEditingController searchController = new TextEditingController();
//  TextEditingController labelController = new TextEditingController();
//  var category = 1;
//
//  getPermission() async{
//    final GeolocationResult result =
//    await Geolocation.requestLocationPermission(
//        permission: const LocationPermission(
//            android: LocationPermissionAndroid.fine,
//            ios: LocationPermissionIOS.always
//        )
//    );
//    return result;
//  }
//
//  getLocation() {
//    return getPermission().then((result) async {
//      if (result.isSuccessful) {
//          final coords =
//          await Geolocation.currentLocation(accuracy: LocationAccuracy.best);
//          times++;
//          return coords;
//        }
//    });
//  }
//
//  buildMap() {
//    if(times == 0) {
//      getLocation().then((response) {
//        response.listen((value) {
//          print(value.location.latitude);
//          print(value.location.longitude);
//          if (value.isSuccessful) {
//            mapController.onReady.then((result) {
//              tappedPoints = new LatLng(value.location.latitude, value.location.longitude);
//              mapController.move(tappedPoints,15.0);
//            });
//          }
//        });
//      });
//    } else {
//      mapController.move(tappedPoints, 15.0);
//    }
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    buildMap();
//
//    var marker_pin =  Marker(
//      width: 80.0,
//      height: 80.0,
//      point: tappedPoints,
//      builder: (ctx) => Container(
//        child: Icon(MdiIcons.mapMarker, color: darkPurpleColor,),
//      ),
//    );
//
//    return Scaffold(
//        appBar: AppBar(
//          backgroundColor: blueColor,
//          centerTitle: true,
//          title: Text(
//            'Pick up a place',
//            style: primaryText,
//          ),
//          leading: new IconTheme(
//            data: new IconThemeData(
//              color: Colors.black,
//            ),
//            child: new IconButton(
//              icon: new Icon(
//                Icons.arrow_back_ios,
//              ),
//              onPressed: () {
//                Navigator.push(
//                  context,
//                  MaterialPageRoute(
//                    builder: (context) => CustomizeableSaves(),
//                  ),
//                );
//              },
//            ),
//          ),
//        ),
//        body: Stack(
//          children: <Widget>[
//            FlutterMap(
//              mapController: mapController,
//              options: new MapOptions(
//                center: tappedPoints,
//                minZoom: 5.0,
//                onTap: _handleTap,
//                plugins: [
//                  ZoomButtonsPlugin(),
//                ],
//              ),
//              layers: [
//                new TileLayerOptions(
//                  urlTemplate: "https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}",
//                  additionalOptions: {
//                    'accessToken': 'pk.eyJ1IjoieHVhbjk5IiwiYSI6ImNrYml2cmJ5ZjBqYmEzMG52ZXMxMm1xYnQifQ.zZmSGVcAQqqQisXRD3sGBw',
//                    'id': 'mapbox/streets-v11',
//                  },
//                ),
//                MarkerLayerOptions(
//                    markers: [
//                      marker_pin,
//                    ]
//                ),
//                ZoomButtonsPluginOption(
//                  minZoom: 4,
//                  maxZoom: 19,
//                  mini: true,
//                  padding: 10,
//                  alignment: Alignment.topRight,
//                ),
//              ],
//            ),
//            DraggableScrollableSheet(
//              maxChildSize: 0.4,
//              minChildSize: 0.05,
//              initialChildSize: 0.4,
//              builder: (context, controller) {
//                return Container(
//                  color: Colors.white,
//                  child: ListView.builder(
//                    itemCount: 1,
//                    controller: controller,
//                    itemBuilder: (BuildContext context,index) {
//                      return Container(
//                          decoration: BoxDecoration(
//                            image: DecorationImage(
//                                image: AssetImage('assets/scroll_bar.jpg'),
//                                fit: BoxFit.fill
//                            ),
//                          ),
//                          alignment: Alignment.center,
//                          padding: EdgeInsets.all(25.0),
//                          child: Column(
//                            mainAxisSize: MainAxisSize.min,
//                            children: <Widget>[
//                              Flexible(
//                                child: TextField(
//                                  controller: searchController,
//                                  style: primaryText,
//                                  decoration: InputDecoration(
//                                    enabledBorder: new UnderlineInputBorder(
//                                        borderSide: new BorderSide(color: Colors.grey[100])
//                                    ),
//                                    prefixIcon: Icon(MdiIcons.mapSearch, color: blueColor,),
//                                    hintText: 'Search destination',
//                                    hintStyle: TextStyle(
//                                      color: Colors.grey[350],
//                                      fontSize: 18.0,
//                                    ),
//                                  ),
//                                ),
//                              ),
//                              Flexible(
//                                child: TextField(
//                                  controller: labelController,
//                                  style: primaryText,
//                                  decoration: InputDecoration(
//                                    enabledBorder: new UnderlineInputBorder(
//                                        borderSide: new BorderSide(color: Colors.grey[100])
//                                    ),
//                                    prefixIcon: Icon(MdiIcons.label, color: blueColor,),
//                                    hintText: 'Label (Option)',
//                                    hintStyle: TextStyle(
//                                      color: Colors.grey[350],
//                                      fontSize: 18.0,
//                                    ),
//                                  ),
//                                ),
//                              ),
//                              Flexible(
//                                child: Theme(
//                                  data: Theme.of(context).copyWith(
//                                      unselectedWidgetColor: blueColor,
////                                      disabledColor: Colors.blue
//                                  ),
//                                  child: Row(
//                                      mainAxisAlignment: MainAxisAlignment.center,
//                                      children: <Widget>[
//                                        Radio(
//                                          value: 1,
//                                          activeColor: blueColor,
//                                          focusColor: blueColor,
//                                          groupValue: this.category,
//                                          onChanged: (value) {
//                                            setState(() {
//                                              this.category = value;
//                                            });
//                                          },
//                                        ),
//                                        Text(
//                                          'Labeled',
//                                          style: primaryText,
//                                        ),
//                                        SizedBox(width: 20,),
//                                        Radio(
//                                          value: 2,
//                                          activeColor: blueColor,
//                                          hoverColor: blueColor,
//                                          focusColor: blueColor,
//                                          groupValue: this.category,
//                                          onChanged: (value) {
//                                            setState(() {
//                                              this.category = value;
//                                            });
//                                          },
//                                        ),
//                                        Text(
//                                          'Want to go',
//                                          style: primaryText,
//                                        ),
//                                      ],
//                                  ),
//                                ),
//                              ),
//                              Flexible(
//                                child: saveButton(context),
//                              ),
//                            ],
//                          )
//                      );
//                    },
//                  ),
//                );
//              },
//            ),
//          ],
//        )
//    );
//  }
//
//  void _handleTap(LatLng latlng) {
//    setState(() {
//      tappedPoints = latlng;
//    });
//  }
}
