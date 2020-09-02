import 'package:flutter/material.dart';
import 'package:login/screens/Private_Policy.dart';
import 'package:login/screens/add_home_address.dart';
import 'package:login/screens/authenticate/create_password.dart';
import 'package:login/screens/authenticate/email_form.dart';
import 'package:login/screens/authenticate/signup_confirmation.dart';
import 'package:login/screens/end_ride.dart';
import 'package:login/screens/payment/add_credit_card.dart';
import 'package:login/screens/payment/add_payment.dart';
import 'package:login/screens/payment/payment_method.dart';
import 'package:login/screens/ride_booking/set_appointment.dart';
import 'package:login/screens/settings/dash_cam_videos.dart';
import 'package:login/screens/settings/edit_account.dart';
import 'package:login/screens/settings/ride_history.dart';
import 'package:login/screens/settings/ride_history_detail.dart';
import 'package:login/screens/terms_n_policy.dart';
import 'package:login/screens/terms_of_services.dart';
import 'package:login/screens/test.dart';
import 'screens/authenticate/name_registration.dart';
import 'screens/authenticate/sms_verification.dart';
import 'screens/landing_page.dart';
import 'screens/login.dart';
import 'screens/order_confirmation.dart';
import 'screens/authenticate/phone_sign_up.dart';
import 'screens/bookingCancellation.dart';
import 'screens/bookingConfirmation.dart';
import 'screens/rideInvoice.dart';
import 'screens/customizeable_saves_page.dart';
import 'screens/start_ride.dart';
import 'screens/set_pickup_destination.dart';
import 'screens/add_customed_place.dart';
import 'screens/confirm_pickup_location.dart';
import 'screens/wait_driver_accept_booking.dart';
import 'screens/wait_for_pickup.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(fontFamily: 'Montserrat'),
      initialRoute: '/landing_page',
      routes: {
        '/landing_page': (context) => LandingPage(),
        '/login': (context) => LoginPage(),
        '/authenticate/phone_sign_up': (context) => PhoneSignUp(),
        '/terms_of_services': (context) => TermsOfServiceOriginal(),
        '/Private_Policy': (context) => PrivatePolicy(),
        '/authenticate/sms_verification': (context) => SmsVerification(),
        '/authenticate/email_form': (context) => EmailForm(),
        '/authenticate/create_password': (context) => CreatePassword(),
        '/authenticate/name_registration': (context) => NameRegistration(),
        '/authenticate/signup_confirmation': (context) => SignupConfirmation(),
        '/payment/payment_method': (context) => PaymentMethod(),
        '/payment/add_payment': (context) => AddPayment(),
        '/payment/add_credit_card': (context) => AddCreditCard(),
        '/order_confirmation': (context) => OrderconfirmationPage(),
        '/customizeable_saves_page': (context) => CustomizeableSaves(),
        '/set_pickup_destination': (context) => SetPickupDestination(),
        '/settings/edit_account': (context) => EditAccount(),
        '/settings/ride_history': (context) => RideHistory(),
        '/settings/ride_history_detail': (context) => RideHistoryDetail(),
        '/settings/dash_cam_videos': (context) => DashCamVideo(),
        '/add_customed_place.dart': (context) => AddCustomedPlace(),
        '/confirm_pickup_location': (context) => ConfirmPickupLoc(),
        '/wait_driver_accept_booking': (context) => WaitDriverAcceptBooking(),
        '/wait_for_pickup': (context) => WaitForPickup(),
        '/start_ride': (context) => StartRide(),
      },
      home: SetPickupDestination(),
    ),
  );
}
