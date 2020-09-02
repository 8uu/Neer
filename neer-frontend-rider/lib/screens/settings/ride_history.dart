import 'package:flutter/material.dart';
import 'package:login/screens/settings/ride_history_detail.dart';
import 'package:login/theme/global.dart';

class RideHistory extends StatefulWidget {
  @override
  _RideHistoryState createState() => _RideHistoryState();
}

class _RideHistoryState extends State<RideHistory> {
  String driver1 = 'https://tinyurl.com/y8b8f6lr';
  String driver2 = 'https://tinyurl.com/yak3txzg';
  String driver3 = 'https://tinyurl.com/yagoxw95';
  String driver4 = 'https://tinyurl.com/ya7rfr73';
  String driver5 = 'https://tinyurl.com/y8wtejxq';

  _buildRideDetailList() {
    return ListView(
      children: <Widget>[
        ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(driver1),
            backgroundColor: Colors.transparent,
          ),
          title: Text('Jul 08, 9:14 AM'),
          subtitle: Text('1.1mi - 5m'),
          trailing: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '\$5.89   ',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                WidgetSpan(
                  child: Icon(
                    Icons.keyboard_arrow_right,
                    // size: 20,
                  ),
                ),
              ],
            ),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RideHistoryDetail(),
              ),
            );
          },
          // selected: true,
        ),
        Divider(),
        ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(driver2),
            backgroundColor: Colors.transparent,
          ),
          title: Text('Jun 10, 7:50 PM'),
          subtitle: Text('1.6mi - 8m'),
          trailing: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '\$6.52   ',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                WidgetSpan(
                  child: Icon(
                    Icons.keyboard_arrow_right,
                    // size: 20,
                  ),
                ),
              ],
            ),
          ),
          onTap: () {
            print('2nd trip');
          },
        ),
        Divider(),
        ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(driver3),
            backgroundColor: Colors.transparent,
          ),
          title: Text('May 31, 8:21 PM'),
          subtitle: Text('2.7mi - 10m'),
          trailing: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '\$10.26   ',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                WidgetSpan(
                  child: Icon(
                    Icons.keyboard_arrow_right,
                    // size: 20,
                  ),
                ),
              ],
            ),
          ),
          onTap: () {
            print('3rd trip');
          },
        ),
        Divider(),
        ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(driver4),
            backgroundColor: Colors.transparent,
          ),
          title: Text('May 01, 2:26 PM'),
          subtitle: Text('2.2mi - 6m'),
          trailing: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '\$8.75   ',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                WidgetSpan(
                  child: Icon(
                    Icons.keyboard_arrow_right,
                    // size: 20,
                  ),
                ),
              ],
            ),
          ),
          onTap: () {
            print('4th trip');
          },
        ),
        Divider(),
        ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(driver5),
            backgroundColor: Colors.transparent,
          ),
          title: Text('Apr 19, 3:56 PM'),
          subtitle: Text('7.6mi - 13m'),
          trailing: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '\$12.85   ',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                WidgetSpan(
                  child: Icon(
                    Icons.keyboard_arrow_right,
                    // size: 20,
                  ),
                ),
              ],
            ),
          ),
          onTap: () {
            print('5th trip');
          },
        ),
        Divider(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Montserrat'),
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Ride History',
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
        body: _buildRideDetailList(),
      ),
    );
  }
}
