import 'package:flutter/material.dart';
import 'package:login/theme/global.dart';
import 'package:lottie/lottie.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Terms of Service & Private Policy',
    home: TermsOfService(),
    theme: ThemeData(primaryColor: Colors.grey),
  ));
}

class TermsOfService extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
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
          title: Text(
            'Terms of Services & Private Policy',
            style: primaryText,
          ),
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            Center(
              child: Container(
                  child: Lottie.asset('assets/lottiefile-questions.json'),
                  padding: EdgeInsets.all(8.0),
                  height: 250.0,
                  width: 250.0),
            ),
            Container(
              height: 2000,
              width: 350,
              child: Text(
                'This App is operated by Tech For Good Inc.\nThroughout the App, the terms "We", "us" and "our" refer to Tech For Good Inc.\n\nTech For Good Inc offers this app, including all information, tools and services avaliable from this app to you, the user, conditioned upon your acceptance of all terms, conditions, policies and notices started here.\n\nBy visiting our app and/or purchasing something from us, you engage in our "Service" and agree to be bound by the following terms and conditions ("Terms of Service", "Terms"), including those additional terms, conditions and policies referenced herein and/or avaliable by hyperlink. These Terms of Service apply to all users of the app, including without limitation users who are browsers, vendors, customers, merchants, and/or contributors of content.\n\nPlease read these Terms Of Service carefully before accessing or using our app, you agree to be bound by these Terms of Service. If you do not agree to all the terms and conditions of this agreement, then you may not access the app or use any services. If these Terms of Service are considered an offer, acceptance is expressly limited to these Terms of Service.\n\n\nONLINE TERMS\n\nBy agreeign to these Terms of Service, you represent that you are at least the age of majority in your state or province of residence and you have given us your consent to allow any of your minor dependents to use this app.\n\nYou may not use or app for any illegal or unauthorized purpose nor may you, in the use of the Service, violate any laws in your jurisdiction (including but not limited to copyright laws).\nYou must not transmit any worms, viruses, or any code of a destructive nature, A breach or violation of any of the Terms will result in an immediate termination of your services.\n\n\nGENERAL CONDITIONS\n\nWe reserve the right to refuse service to anyone for any reason at any time.\n\nYou understand that your content (not including credit card information), may be transferred unencrypted and involve (a) transmission over various networks, and (b) changes to conform and adapt to technical requirements of connecting networks or devices. Credit card information is always encrypted during transfer over networks.\n\nYou agree not reproduce, duplicate, copy, sell, resell or expolit any portion of the Service, use of the Service, access to the Service or any contact on the app through which the service is porvided , without express written permission by us.\n\nThe headings used in this agreement are included for convenience only and will not limit or otherwise affect thses Terms.\n\nACCURACY, COMPLETENESS AND TIMELESS OF INFORMATION\n\nWe are not responsible if information made avaliable on this app is not accurate, complete or current.\n\nThe material on this app is provided for general information only and should not be relied upon or used as the sole basis for making decisions without consulting primary, more accurate, more complete or more timely sources of information. Any reliance on the material on this site os at your risk.\n\nThis app may contain certain historical information, Historical Information, necessarily, is not current and is provided for your reference only. We reserve the right to modify the contents oof this site at any time, but we have no obligation to update any information on our app. You agree that it is your responsibility to monitor changes to our app.\n\nMODIFICATIONS TO THE SERVICE AND PRICES\n\nPrices for our services are subject to change without notice\n\nWe reserve the right at any time to modify or discontinue the Service (or any part or content thereof) without notice any time.\n\nWe shall not be liable to you or to any third-party for any modifications, price change, suspension or discontinuance of the Service.\n\nSERVICES\n\nServices may be avaliable exclusively online through the app.\n\nWe have made every effort to display as accurately as possible the colors and images that appear on the app.\n\nACCURACY OF BILLING AND ACCOUNT INFORMATION\n\nWe reserve the right to refuse any order you place with us. We may, in our sole discretion, limit or cancel trips purchased per person, per household, or per order. These restrictions may include services placed by or under the same customer account, the same credit card, and/or orders that use the same billing address. In the event that we make a change to or cancel an order, we may attempt to notify you by contacting the e-mail and/or billing address/phone number provided at the time of the order.',
                style: TextStyle(fontSize: 14.0),
                textAlign: TextAlign.justify,
              ),
              padding: EdgeInsets.all(10.0),
              alignment: Alignment.center,
            ),
            Container(
                child: Lottie.asset('assets/map-navigation.json'),
                padding: EdgeInsets.all(15.0),
                height: 250,
                width: 250),
            Container(
                height: 1900,
                width: 350,
                child: Text(
                  'This Privacy Policy describes how your personal information is collected, used, and shared when you visit Tech for good inc (the “APP”).\n\nPersonal information we collect\n\nWhen you visit the App, we automatically collect certain information about your device, including information about your web browser, IP address, time zone, and some of the cookies that are installed on your device. Additionally, as you browse the Site, we collect information about the individual web pages or products that you view, what websites or search terms referred you to the Site, and information about how you interact with the Site. We refer to this automatically-collected information as “Device Information”.\n\nWe collect Device Information using the following technologies:\n\n“Cookies” are data files that are placed on your device or computer and often include an anonymous unique identifier.\n\nFor more information about cookies, and how to disable cookies, visit http://www.allaboutcookies.org.\n\n“Log files” track actions occurring on the Site, and collect data including your IP address, browser type, Internet service provider, referring/exit pages, and date/time stamps.\n\n“Web beacons”, “tags”, and “pixels” are electronic files used to record information about how you browse the Site.\n\nAdditionally when you make a service or attempt to make a service through the APP, we collect certain information from you, including your name, billing address, shipping address, payment information (including credit card numbers, email address, and phone number. We refer to this information as “Order Information”.\n\nWhen we talk about “Personal Information” in this Privacy Policy, we are talking both about Device Information and Order Information.\n\nHow do we use your personal information?\n\nCommunicate with you;\n\nScreen our services for potential risk or fraud; and\n\nWhen in line with the preferences you have shared with us, provide you with information or advertising relating to our products or services.\n\nWe use the Device Information that we collect to help us screen for potential risk and fraud (in particular, your IP address), and more generally to improve and optimize our Site (for example, by generating analytics about how our customers browse and interact with the APP, and to assess the success of our marketing and advertising campaigns).\n\nFinally, we may also share your Personal Information to comply with applicable laws and regulations, to respond to a subpoena, search warrant or other lawful request for information we receive, or to otherwise protect our rights.\n\nBehavioural advertising\n\nAs described above, we use your Personal Information to provide you with targeted advertisements or marketing communications we believe may be of interest to you. For more information about how targeted advertising works, you can visit the Network Advertising Initiative’s (“NAI”) educational page at http://www.networkadvertising.org/understanding-online-advertising/how-does-it-work.\n\nYou can opt out of targeted advertising by using the links below:\n\nFacebook: https://www.facebook.com/settings/?tab=ads\n\nGoogle: https://www.google.com/settings/ads/anonymous\n\nBing: https://advertise.bingads.microsoft.com/en-us/resources/policies/personalized-ads\n\nDo not track\n\nPlease note that we do not alter our Site’s data collection and use practices when we see a Do Not Track signal from your browser.\n\nChanges\n\nWe may update this privacy policy from time to time in order to reflect, for example, changes to our practices or for other operational, legal or regulatory reasons.\n\nContact us\n\nFor more information about our privacy practices, if you have questions, or if you would like to make a complaint, please contact us by e‑mail at justinmarcano@techforgoodinc.com or by mail using the details provided below:\n\nTech For Good Inc',
                  style: TextStyle(fontSize: 14.0),
                  textAlign: TextAlign.justify,
                )),
            Container(
              child: Lottie.asset('assets/lottiefile-stopwatch.json'),
              alignment: Alignment.center,
              height: 150,
              width: 150,
            )
          ],
        )));
  }
}
