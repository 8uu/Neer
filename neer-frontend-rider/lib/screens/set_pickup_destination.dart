import 'package:flutter/material.dart';
import 'ride_booking/set_appointment.dart';
import '../widget/menu_drawer.dart';
import '../theme/global.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'customizeable_saves_page.dart';
import 'package:geocoder/geocoder.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';

class SetPickupDestination extends StatefulWidget {
  @override
  _SetPickupDestinationState createState() => _SetPickupDestinationState();
}

final homeScaffoldKey = GlobalKey<ScaffoldState>();
final searchScaffoldKey = GlobalKey<ScaffoldState>();
GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);

class _SetPickupDestinationState extends State<SetPickupDestination> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GoogleMapController mapController;
  TextEditingController textController = new TextEditingController();
  String searchAddr;
  String username = "John";
  Marker marker =
      Marker(markerId: MarkerId("init"), position: LatLng(40.7128, -74.0060));
  bool mapToggle = false;
  var currentLocation;
  LatLng tappedLoc;
  Address results;
  LatLng home = new LatLng(37.3501544, -122.07633209999999);
  Mode _mode = Mode.overlay;

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
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    var boxSize = 0.42;
    var hBox = h * boxSize;
//    Marker _marker = Marker(
//      markerId: marker
//    )
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Montserrat'),
      home: Scaffold(
          key: _scaffoldKey,
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: new Container(
              margin: EdgeInsets.only(left: 10),
              child: new IconTheme(
                data: new IconThemeData(
                  color: Colors.black,
                ),
                child: new IconButton(
                  icon: Icon(
                    Icons.menu,
                    size: 35,
                  ),
                  onPressed: () {
                    _scaffoldKey.currentState.openDrawer();
                  },
                ),
              ),
            ),
          ),
          resizeToAvoidBottomPadding: false,
          drawer: MenuDrawer(),
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
                              fit: BoxFit.fill),
                        ),
                        alignment: Alignment.center,
                        padding: EdgeInsets.fromLTRB(
                            0.08 * w, 0.02 * hBox, 0.08 * w, 0.01 * hBox),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              height: hBox * 0.06,
                              child: Text(
                                "Hello, $username",
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                Container(
                                  height: hBox * 0.1,
                                  child: Text(
                                    "Where are you going?",
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      color: Colors.black,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                Spacer(),
                                SetAppt(),
                              ],
                            ),
                            Container(
                              height: hBox * 0.2,
                              child: TextField(
                                onTap: _handlePressButton,
                                controller: textController,
                                style: primaryText,
                                decoration: InputDecoration(
                                  hintText: 'Search',
//                                    hintStyle: primaryText,
                                  enabledBorder: new UnderlineInputBorder(
                                      borderSide:
                                          new BorderSide(color: Colors.black)),
//                                    contentPadding: EdgeInsets.all(15),
//                                  suffixIcon: IconButton(
//                                    icon: Icon(Icons.search),
//                                    color: darkPurpleColor,
//                                    onPressed: searchandNavigate,
//                                  ),
                                ),
                                onChanged: (val) {
                                  setState(() {
                                    searchAddr = val;
                                  });
                                },
                              ),
                            ),
                            Container(
                              height: hBox * 0.12,
                              child: savedButton(context),
                            ),
                            Container(
                              height: hBox * 0.15,
                              child: homeButton(context),
                            ),
                            Container(
                              alignment: Alignment.center,
                              height: hBox * 0.2,
                              child: confirmButton(context),
                            ),
                          ],
                        )),
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
          )),
    );
  }

  Future<void> _handlePressButton() async {
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
      this.textController.text = p.description;
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
    FocusScope.of(context).requestFocus(FocusNode());
    setState(() {
      marker = Marker(
        markerId: MarkerId(latlng.toString()),
        position: latlng,
//        draggable: true,
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

  Widget savedButton(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: FlatButton.icon(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        icon: Icon(
          MdiIcons.bookmark,
          color: darkPurpleColor,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CustomizeableSaves(),
            ),
          );
        },
        label: Text(
          'Customizable Saves',
          style: primaryText,
        ),
      ),
    );
  }

  Widget homeButton(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: FlatButton.icon(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        icon: Icon(
          MdiIcons.home,
          color: darkPurpleColor,
        ),
        onPressed: () {
          mapController
              .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
            target: LatLng(this.home.latitude, this.home.longitude),
            zoom: 15.0,
          )));
          setState(() {
            marker = Marker(
              markerId: MarkerId(home.toString()),
              position: home,
//        draggable: true,
            );
            getAddress(home).then((response) {
              print(response.coordinates);
              this.textController.text = response.addressLine;
            });
          });
        },
        label: Text(
          'Home',
          style: primaryText,
        ),
      ),
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
//                builder: (context) => OrderconfirmationPage(),
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
