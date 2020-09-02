import 'package:flutter/material.dart';
import 'package:login/screens/payment/payment_method.dart';
import 'package:login/screens/settings/edit_account.dart';
import 'package:login/screens/settings/ride_history.dart';
import 'package:login/theme/global.dart';

class MenuDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(
                'John Doe',
                style: TextStyle(color: Colors.black),
              ),
              accountEmail: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '5.0 ',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    WidgetSpan(
                      child: Icon(
                        Icons.star,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ),
              decoration: BoxDecoration(color: blueColor),
              currentAccountPicture: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditAccount(),
                    ),
                  );
                },
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/avatar.png'),
                  backgroundColor: Colors.transparent,
                ),
              ),
            ),
            ListTile(
              title: Text('Ride History'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RideHistory(),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('Payment'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PaymentMethod(),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('Settings'),
              onTap: () {},
            ),
            ListTile(
              title: Text('Become a Driver'),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
