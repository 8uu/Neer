import 'package:flutter/material.dart';
import 'package:login/screens/settings/dash_cam_videos.dart';
import 'package:login/theme/global.dart';

class RideHistoryDetail extends StatefulWidget {
  @override
  _RideHistoryDetailState createState() => _RideHistoryDetailState();
}

class _RideHistoryDetailState extends State<RideHistoryDetail> {
  String tripDateTime = 'Jul 08, 2020, 9:14 AM';
  String driver1Name = 'Tina';
  String pickUpAdd = '451 E Cevallos St';
  String pickUpCity = 'San Antonio';
  String pickUpTime = '9:14 AM';
  String dropOffAdd = '930 S Presa';
  String dropOffCity = 'San Antonio';
  String dropOffTime = '9:19 AM';
  String tripTotal = '\$5.89';
  String tripLength = '1.1mi';
  String tripTime = '5m 29s';

  String driver1 = 'https://tinyurl.com/y8b8f6lr';
  String driver2 = 'https://tinyurl.com/yak3txzg';
  String driver3 = 'https://tinyurl.com/yagoxw95';
  String driver4 = 'https://tinyurl.com/ya7rfr73';
  String driver5 = 'https://tinyurl.com/y8wtejxq';

  driverAvatar() {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 10, 0, 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CircleAvatar(
            backgroundImage: NetworkImage(driver1),
            backgroundColor: Colors.transparent,
            radius: 50,
          ),
        ],
      ),
    );
  }

  tripAmount() {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '$tripTotal',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  thanksDriver() {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
      child: Text(
        'Thanks for riding with $driver1Name',
        style: TextStyle(
          fontSize: 18,
        ),
      ),
    );
  }

  tripRoute() {
    return Container(
      // margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
      child: Image.asset('assets/route_example.png'),
    );
  }

  yourTrip() {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 5, 0, 5),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Text(
                'Your Trip',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  pickUpLoc() {
    return Container(
      child: ListTile(
        leading: Icon(
          Icons.trip_origin,
          color: Colors.green,
        ),
        title: Text(
          '$pickUpAdd',
          style: TextStyle(
            fontSize: 16,
            // fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text('$pickUpCity'),
        trailing: Column(
          children: <Widget>[
            Text('Pickup'),
            Text('$pickUpTime'),
          ],
        ),
      ),
    );
  }

  dropOffLoc() {
    return Container(
      child: ListTile(
        leading: Icon(
          Icons.place,
          color: darkPurpleColor,
        ),
        title: Text(
          '$dropOffAdd',
          style: TextStyle(
            fontSize: 16,
            // fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text('$dropOffCity'),
        trailing: Column(
          children: <Widget>[
            Text('Drop-off'),
            Text('$dropOffTime'),
          ],
        ),
      ),
    );
  }

  tripPayment() {
    return Container(
      child: ListTile(
        title: Text(
          'Payment',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Text(
              'Neer fare ($tripLength, $tripTime)',
              style: TextStyle(
                fontSize: 16,
                // fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
        trailing: Text(
          '$tripTotal',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  paymentType() {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: ListTile(
        title: Row(
          children: <Widget>[
            Image.asset('assets/payment_logos/visa_logo.png'),
            SizedBox(width: 10),
            Text(
              '5578',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        subtitle: Text(
            'Your payment method has already been charged. Changing profiles here will not affect the payment method used for this ride.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Montserrat'),
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            tripDateTime,
            style: primaryText,
          ),
          centerTitle: true,
          backgroundColor: blueColor,
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
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                driverAvatar(),
                tripAmount(),
                thanksDriver(),
                tripRoute(),
                Divider(thickness: 1),
                DashCamWidget(),
                Divider(thickness: 1),
                yourTrip(),
                pickUpLoc(),
                dropOffLoc(),
                Divider(thickness: 5),
                tripPayment(),
                Divider(thickness: 1),
                paymentType(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomListItem extends StatelessWidget {
  const CustomListItem({
    this.thumbnail,
    this.title,
    this.videoLength,
  });

  final Widget thumbnail;
  final String title;
  final String videoLength;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 2,
          child: thumbnail,
        ),
        Expanded(
          flex: 3,
          child: _VideoDescription(
            title: title,
            videoLength: videoLength,
            // hasSeen: hasSeen,
          ),
        ),
        // const Icon(
        //   Icons.more_vert,
        //   size: 16.0,
        // ),
      ],
    );
  }
}

class _VideoDescription extends StatelessWidget {
  const _VideoDescription({
    Key key,
    this.title,
    this.videoLength,
  }) : super(key: key);

  final String title;
  final String videoLength;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(
              // fontWeight: FontWeight.w500,
              fontSize: 16.0,
            ),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 3.0)),
          Text(
            videoLength,
            style: const TextStyle(fontSize: 16.0),
          ),
        ],
      ),
    );
  }
}

/// This is the stateless widget that the main application instantiates.
class DashCamWidget extends StatelessWidget {
  DashCamWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomListItem(
        videoLength: '0:13',
        thumbnail: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DashCamVideo(),
              ),
            );
          },
          child: Container(
            child: Image.asset('assets/dashcam_image.png'),
          ),
        ),
        title: 'Dash Cam Recording',
      ),
      // CustomListItem(
      //   videoLength: 'Dash',
      //   hasSeen: 884000,
      //   thumbnail: Container(
      //     decoration: const BoxDecoration(color: Colors.yellow),
      //   ),
      //   title: 'Announcing Flutter 1.0',
      // ),
    );
  }
}
