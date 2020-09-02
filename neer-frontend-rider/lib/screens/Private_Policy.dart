import 'package:flutter/material.dart';

void main() => runApp(PrivatePolicy());

class PrivatePolicy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Private Policy",
      theme: ThemeData(
        fontFamily: 'Montserrat',
        primarySwatch: Colors.grey,
      ),
      home: Policy(),
    );
  }
}

class Policy extends StatelessWidget {
  const Policy({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var column = Column(
      children: <Widget>[
        Text(
          "",
          style: TextStyle(fontSize: 5),
        ),
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(15.0),
          child: Text(
              "This Privacy Policy describes how your personal information is collected, used, and shared when you visit\nTechForGoodInc.(“NEER”).\n\nPersonal information we collect:\n\nWhen you visit the App, we automatically collect certain information about your device, including information about your web browser, IP address, time zone, and some of the cookies that are installed on your device. Additionally, as you browse the Site, we collect information about the individual web pages or products that you view, what websites or search terms referred you to the Site, and information about how you interact with the Site.\n\nWe refer to this automatically-collected information as “Device Information”. “Cookies” are data files that are placed on your device or computer and often include an anonymous unique identifier. For more information about cookies, and how to disable cookies, visit http://www.allaboutcookies.org.\n\n“Log files” track actions occurring on the Site, and collect data including your IP address, browser type, Internet service provider, referring/exit pages, and date/time stamps. “Web beacons”, “tags”, and “pixels” are electronic files used to record information about how you browse the Site. Additionally when you make a service or attempt to make a service through the APP, we collect certain information from you, including your name, billing address, shipping address, payment information (including credit card numbers, email address, and phone number. We refer to this information as “Order Information”.\n\nWhen we talk about “Personal Information” in this Privacy Policy, we are talking both about Device Information and Order Information. How do we use your personal information?\n\nCommunicate with you;\nScreen our services for potential risk or fraud;\n\nand When in line with the preferences you have shared with us, provide you with information or advertising relating to our products or services.\n\nWe use the Device Information that we collect to help us screen for potential risk and fraud (in particular, your IP address), and more generally to improve and optimize our Site (for example, by generating analytics about how our customers browse and interact with the APP, and to assess the success of our marketing and advertising campaigns).\n\nBehavioural advertising As described above, we use your Personal Information to provide you with targeted advertisements or marketing communications we believe may be of interest to you.\n\nFor more information about how targeted advertising works, you can visit the Network Advertising Initiative’s (“NAI”) educational page at http://www.networkadvertising.org/understanding-online-advertising/how-does-it-work.\n\n\n TechForGoodInc.",
              style: TextStyle(fontSize: 10.0),
              textAlign: TextAlign.justify),
        )
      ],
    );
    return Scaffold(
      appBar: AppBar(
          title: Text("Private Policy"),
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
          centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15.0),
        child: column,
      ),
    );
  }
}
