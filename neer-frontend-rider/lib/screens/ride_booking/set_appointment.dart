import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:login/screens/ride_booking/book_ride_detail.dart';
import 'package:login/theme/global.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'dart:async';

class SetAppt extends StatefulWidget {
  @override
  _SetApptState createState() => _SetApptState();
}

class _SetApptState extends State<SetAppt> {
  DateTime _dateTime = DateTime.now();

  GoogleMapController mapController;
  LatLng start = new LatLng(37.416780, -122.077430);
  LatLng end = new LatLng(37.426780, -122.077430);
  Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FlatButton(
        onPressed: () => showCupertinoModalBottomSheet(
          expand: false,
          context: context,
          backgroundColor: Colors.transparent,
          builder: (context, scrollController) => Container(
            height: 350,
            child: Scaffold(
              body: Container(
                // height: 400,
                child: Column(
                  children: <Widget>[
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Text(
                          'Book a Ride',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: CupertinoDatePicker(
                        initialDateTime: _dateTime,
                        onDateTimeChanged: (dateTime) {
                          setState(() {
                            _dateTime = dateTime;
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: ButtonTheme(
                                height: 50,
                                child: FlatButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    'Cancel',
                                    style: primaryText,
                                  ),
                                  color: blueColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(90.0),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: ButtonTheme(
                                height: 50,
                                child: FlatButton(
                                  onPressed: () {
                                    showGeneralDialog(
                                      context: context,
                                      barrierDismissible: true,
                                      barrierLabel:
                                          MaterialLocalizations.of(context)
                                              .modalBarrierDismissLabel,
                                      barrierColor:
                                          Colors.black.withOpacity(0.5),
                                      transitionDuration:
                                          Duration(milliseconds: 200),
                                      pageBuilder: (BuildContext context,
                                          Animation first, Animation second) {
                                        // return BookRideDetailDialog(
                                        //     start: start,
                                        //     end: end,
                                        //     controller: _controller);
                                        return BookRideDetail();
                                      },
                                    );
                                  },
                                  child: Text(
                                    'Set',
                                    style: primaryText,
                                  ),
                                  color: blueColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(90.0),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        child: Text('Book'),
        color: blueColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(90.0),
        ),
      ),
    );
  }
}
