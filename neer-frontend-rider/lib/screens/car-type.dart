import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import '../theme/global.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class CarType extends StatefulWidget {
  @override
  _CarTypeState createState() => _CarTypeState();
}

class _CarTypeState extends State<CarType> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Select Car Type',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Montserrat',
          ),
        ),
        leading: new IconTheme(data: new IconThemeData(
          color:Colors.black,
        ),
            child: new IconButton(icon: new Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.pop(context);
                },
            )),
        centerTitle: true,
        backgroundColor: blueColor,

//        backgroundColor: blueColor,
//        centerTitle: true,
//        title: Text(
//          'Select Car Type',
//        ),

      ),

      body: Stack(
        children: <Widget>[
          LocationMap(),
          //VehicleInfo(),
          VehicleInformation(),
        ],
      ),
    );
  }
}


class LocationMap extends StatefulWidget {
  @override
  _LocationMapState createState() => _LocationMapState();
}

class _LocationMapState extends State<LocationMap> {
  @override
  Widget build(BuildContext context) {
    return new FlutterMap(
      options: new MapOptions(
        center: new LatLng(34.056340, -118.232050),
        zoom: 13.0,
      ),
      layers: [
        new TileLayerOptions(
          urlTemplate: "https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}",
          additionalOptions: {
            'accessToken': 'pk.eyJ1IjoieHVhbjk5IiwiYSI6ImNrYml2cmJ5ZjBqYmEzMG52ZXMxMm1xYnQifQ.zZmSGVcAQqqQisXRD3sGBw',
            'id': 'mapbox/streets-v11',
          },
        ),
        new MarkerLayerOptions(
          markers: [
            new Marker(
              width: 80.0,
              height: 80.0,
              point: new LatLng(34.056340, -118.232050),
              builder: (ctx) =>
              new Container(
                child: IconButton(
                  icon: Icon(MdiIcons.mapMarker),
                  color: darkPurpleColor,
                  iconSize: 45.0,
                  onPressed: (){
                    showModalBottomSheet(
                      context: context,
                      builder: (builder) {
                        return Container(
                          color: Colors.white,
                          child: new Center(
                            child: new Text("bottom sheet"),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// Show vehicle types

//class VehicleInfo extends StatefulWidget {
//  @override
//  _VehicleInfoState createState() => _VehicleInfoState();
//}
//
//class _VehicleInfoState extends State<VehicleInfo> {
//  @override
//  Widget build(BuildContext context) {
//    return DraggableScrollableSheet(
//      maxChildSize: 1,
//      minChildSize: 0.05,
//      initialChildSize: 0.05,
//      builder: (context, controller) {
//        return Container(
//          color: Colors.white,
//          child: ListView.builder(
//            controller: controller,
//            itemBuilder: (BuildContext context,index) {
//              return Container(
//                decoration: BoxDecoration(
//                  image: DecorationImage(
//                      image: AssetImage('assets/scroll_bar.jpg'),
//                      fit: BoxFit.fill,
//                  ),
//                ),
//                alignment: Alignment.center,
//                padding: EdgeInsets.all(25.0),
//                child: Column(
//                  mainAxisSize: MainAxisSize.min,
//                  children: <Widget>[
//                      Row(
//                        children: <Widget>[
//                          new Container(
//                            child: new Image.asset(
//                              'assets/car1.png',
//                              height: 20.0,
//                            ),
//                          ),
//                        ],
//                      ),
//                  ],
//                ),
//              );
//            },
//          ),
//        );
//      },
//    );
//  }
//}




class VehicleInformation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      maxChildSize: 1,
      minChildSize: 0.05,
      initialChildSize: 0.05,
      builder: (context, controller) {
        return Container(
          color: Colors.white,
          child: ListView.builder(
            itemCount: 1,
            controller: controller,
            itemBuilder: (BuildContext context, index) {
              return Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/scroll_bar.jpg'),
                      fit: BoxFit.fill
                  ),
                ),
                alignment: Alignment.center,
                padding: EdgeInsets.all(25.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[

                    InkWell(
                      child: Container(
                        color: blueColor,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>
                          [
                            Text(
                              'Select Car Type',
                            ),
                            SizedBox(
                              width: 10.0,
                              height: 10.0,
                            ),
                            IconButton(
                              icon: Image.asset('assets/car1.png'),
                              iconSize: 100,
                              onPressed: (){},
                            ),
                            Text(
                              'STANDARD',
                            ),
                            Column(
                              children: <Widget>[

                                RichText(
                                  text: TextSpan(
                                    text: 'Affordable rides, nearest you, 1 booster seat for kids',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 15
                                    ),
                                  ),
                                ),
                                Text(
                                  '\$15.50',
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      onTap: () {},
                    ),

                    SizedBox(
                      width: 10.0,
                      height: 30.0,
                    ),

                    InkWell(
                      child: Container(
                        color: blueColor,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            IconButton(
                              icon: Image.asset('assets/car2.png'),
                              iconSize: 100,
                              onPressed: (){},
                            ),
                            Text(
                              'DELUXE',
                            ),
                            RichText(
                              text: TextSpan(
                                text: 'Need space or more riders? 2 booster seats for kids',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15
                                ),
                              ),
                            ),
                            Text(
                              '\$35.30',
                            ),
                          ],
                        ),
                      ),
                      onTap: () {},
                    ),

                    SizedBox(
                      width: 10.0,
                      height: 30.0,
                    ),

                    InkWell(
                      child: Container(
                        color: blueColor,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            IconButton(
                              icon: Image.asset('assets/car3.png'),
                              iconSize: 100,
                              onPressed: (){},
                            ),
                            Text(
                              'PREMIUM',
                            ),
                            RichText(
                              text: TextSpan(
                                text: 'Ride with comfort in luxury, 3 booster seats for kids',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15
                                ),
                              ),
                            ),
                            Text(
                              '\$59.42',
                            ),
                          ],
                        ),
                      ),
                      onTap: () {},
                    ),

                    InkWell(
                      child: Container(
                        color: Colors.white10,
                        child: Column(
                          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            IconButton(
                              icon: Image.asset(
                                'assets/mastercard.jpg',
                                height: 90,
                                width: 200,
                                //scale: 0.8,
                              ),
                              iconSize: 100,
                              onPressed: (){},
                            ),
                            RichText(
                              text: TextSpan(
                                text: 'Mastercard **** **** **** 7822',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {},
                    ),

//                    Container(
//                      width: 330.0,
//                      margin: EdgeInsets.only(top: 35),
//                      child: ButtonTheme(
//                        height: 50.0,
//                        child: FlatButton(
//                          onPressed: () {},
//                          color: blueColor,
//                          shape: RoundedRectangleBorder(
//                            borderRadius: BorderRadius.circular(90.0),
//                          ),
//                          child: Text(
//                            'Back',
//                            style: primaryText,
//                          ),
//                        ),
//                      ),
//                    ),


                    Container(
                      width: 330.0,
                      margin: EdgeInsets.only(top: 35),
                      child: ButtonTheme(
                        height: 50.0,
                        child: FlatButton(
                          onPressed: () {},
                          color: blueColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(90.0),
                          ),
                          child: Text(
                            'Book',
                            style: primaryText,
                          ),
                        ),
                      ),
                    ),


//                   Container(
//                     child: RaisedButton(
//                       onPressed: () {},
//                       child: Text('Book'),
//                       color: blueColor,
//                     ),
//                   ),

                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
















