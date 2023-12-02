// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `No Data Found`
  String get NoDataFound {
    return Intl.message(
      'No Data Found',
      name: 'NoDataFound',
      desc: '',
      args: [],
    );
  }

  /// `No Details Found`
  String get NoDetailsFound {
    return Intl.message(
      'No Details Found',
      name: 'NoDetailsFound',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to exit?`
  String get Exit {
    return Intl.message(
      'Do you want to exit?',
      name: 'Exit',
      desc: '',
      args: [],
    );
  }

  /// `Mobile no.`
  String get Mobileno {
    return Intl.message(
      'Mobile no.',
      name: 'Mobileno',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get Submit {
    return Intl.message(
      'Submit',
      name: 'Submit',
      desc: '',
      args: [],
    );
  }

  /// `Please enter number`
  String get Pleaseenternumber {
    return Intl.message(
      'Please enter number',
      name: 'Pleaseenternumber',
      desc: '',
      args: [],
    );
  }

  /// `Number must be of 10 digit`
  String get Numberlimit {
    return Intl.message(
      'Number must be of 10 digit',
      name: 'Numberlimit',
      desc: '',
      args: [],
    );
  }

  /// `EnterOTP`
  String get EnterOTP {
    return Intl.message(
      'EnterOTP',
      name: 'EnterOTP',
      desc: '',
      args: [],
    );
  }

  /// `OTP Expires in: `
  String get OTPExpire {
    return Intl.message(
      'OTP Expires in: ',
      name: 'OTPExpire',
      desc: '',
      args: [],
    );
  }

  /// `Resend OTP`
  String get ResendOtp {
    return Intl.message(
      'Resend OTP',
      name: 'ResendOtp',
      desc: '',
      args: [],
    );
  }

  /// `Enable Location Permission`
  String get EnableLocationPermission {
    return Intl.message(
      'Enable Location Permission',
      name: 'EnableLocationPermission',
      desc: '',
      args: [],
    );
  }

  /// `We want to access your location to provide a better experience by helping you find partners nearby`
  String get Loationdescription {
    return Intl.message(
      'We want to access your location to provide a better experience by helping you find partners nearby',
      name: 'Loationdescription',
      desc: '',
      args: [],
    );
  }

  /// `Allow Location`
  String get AllowLocation {
    return Intl.message(
      'Allow Location',
      name: 'AllowLocation',
      desc: '',
      args: [],
    );
  }

  /// `Services`
  String get Services {
    return Intl.message(
      'Services',
      name: 'Services',
      desc: '',
      args: [],
    );
  }

  /// `Special Offers`
  String get SpecialOffers {
    return Intl.message(
      'Special Offers',
      name: 'SpecialOffers',
      desc: '',
      args: [],
    );
  }

  /// `Get Inspired \nwith Servizly`
  String get GetInspiredwithServizly {
    return Intl.message(
      'Get Inspired \nwith Servizly',
      name: 'GetInspiredwithServizly',
      desc: '',
      args: [],
    );
  }

  /// `Hair`
  String get Hair {
    return Intl.message(
      'Hair',
      name: 'Hair',
      desc: '',
      args: [],
    );
  }

  /// `Barber`
  String get Barber {
    return Intl.message(
      'Barber',
      name: 'Barber',
      desc: '',
      args: [],
    );
  }

  /// `Nails`
  String get Nails {
    return Intl.message(
      'Nails',
      name: 'Nails',
      desc: '',
      args: [],
    );
  }

  /// `Skin`
  String get Skin {
    return Intl.message(
      'Skin',
      name: 'Skin',
      desc: '',
      args: [],
    );
  }

  /// `Tattoo`
  String get Tattoo {
    return Intl.message(
      'Tattoo',
      name: 'Tattoo',
      desc: '',
      args: [],
    );
  }

  /// `Most Booked Services`
  String get MostBookedServices {
    return Intl.message(
      'Most Booked Services',
      name: 'MostBookedServices',
      desc: '',
      args: [],
    );
  }

  /// `View Full Services`
  String get ViewFullServices {
    return Intl.message(
      'View Full Services',
      name: 'ViewFullServices',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get Home {
    return Intl.message(
      'Home',
      name: 'Home',
      desc: '',
      args: [],
    );
  }

  /// `Explore`
  String get Explore {
    return Intl.message(
      'Explore',
      name: 'Explore',
      desc: '',
      args: [],
    );
  }

  /// `Appointments`
  String get Appointments {
    return Intl.message(
      'Appointments',
      name: 'Appointments',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get Settings {
    return Intl.message(
      'Settings',
      name: 'Settings',
      desc: '',
      args: [],
    );
  }

  /// `What Services you are looking for?`
  String get WhatServicesyouarelookingfor {
    return Intl.message(
      'What Services you are looking for?',
      name: 'WhatServicesyouarelookingfor',
      desc: '',
      args: [],
    );
  }

  /// `Where`
  String get Where {
    return Intl.message(
      'Where',
      name: 'Where',
      desc: '',
      args: [],
    );
  }

  /// `When`
  String get When {
    return Intl.message(
      'When',
      name: 'When',
      desc: '',
      args: [],
    );
  }

  /// `Filters`
  String get Filters {
    return Intl.message(
      'Filters',
      name: 'Filters',
      desc: '',
      args: [],
    );
  }

  /// `Sort by: Recommended`
  String get SortbyRecommended {
    return Intl.message(
      'Sort by: Recommended',
      name: 'SortbyRecommended',
      desc: '',
      args: [],
    );
  }

  /// `No Result Found`
  String get NoResultFound {
    return Intl.message(
      'No Result Found',
      name: 'NoResultFound',
      desc: '',
      args: [],
    );
  }

  /// `Ongoing`
  String get Ongoing {
    return Intl.message(
      'Ongoing',
      name: 'Ongoing',
      desc: '',
      args: [],
    );
  }

  /// `History`
  String get History {
    return Intl.message(
      'History',
      name: 'History',
      desc: '',
      args: [],
    );
  }

  /// `Cancel Appointments`
  String get CancelAppointments {
    return Intl.message(
      'Cancel Appointments',
      name: 'CancelAppointments',
      desc: '',
      args: [],
    );
  }

  /// `Reschedule`
  String get Reschedule {
    return Intl.message(
      'Reschedule',
      name: 'Reschedule',
      desc: '',
      args: [],
    );
  }

  /// `Service Completed`
  String get ServiceComplete {
    return Intl.message(
      'Service Completed',
      name: 'ServiceComplete',
      desc: '',
      args: [],
    );
  }

  /// `Refund`
  String get Refund {
    return Intl.message(
      'Refund',
      name: 'Refund',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get Profile {
    return Intl.message(
      'Profile',
      name: 'Profile',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get Name {
    return Intl.message(
      'Name',
      name: 'Name',
      desc: '',
      args: [],
    );
  }

  /// `Mobile Number`
  String get MobileNumber {
    return Intl.message(
      'Mobile Number',
      name: 'MobileNumber',
      desc: '',
      args: [],
    );
  }

  /// `Email Address`
  String get EmailAddress {
    return Intl.message(
      'Email Address',
      name: 'EmailAddress',
      desc: '',
      args: [],
    );
  }

  /// `Update`
  String get Update {
    return Intl.message(
      'Update',
      name: 'Update',
      desc: '',
      args: [],
    );
  }

  /// `Add Address`
  String get AddAddress {
    return Intl.message(
      'Add Address',
      name: 'AddAddress',
      desc: '',
      args: [],
    );
  }

  /// `Search Location`
  String get SearchLocation {
    return Intl.message(
      'Search Location',
      name: 'SearchLocation',
      desc: '',
      args: [],
    );
  }

  /// `House/Flat`
  String get HouseFlat {
    return Intl.message(
      'House/Flat',
      name: 'HouseFlat',
      desc: '',
      args: [],
    );
  }

  /// `Landmark`
  String get Landmark {
    return Intl.message(
      'Landmark',
      name: 'Landmark',
      desc: '',
      args: [],
    );
  }

  /// `other`
  String get other {
    return Intl.message(
      'other',
      name: 'other',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get Continue {
    return Intl.message(
      'Continue',
      name: 'Continue',
      desc: '',
      args: [],
    );
  }

  /// `Enter Address`
  String get EnterAddress {
    return Intl.message(
      'Enter Address',
      name: 'EnterAddress',
      desc: '',
      args: [],
    );
  }

  /// `Enter Landmark`
  String get EnterLandmark {
    return Intl.message(
      'Enter Landmark',
      name: 'EnterLandmark',
      desc: '',
      args: [],
    );
  }

  /// `My Reviews`
  String get MyReviews {
    return Intl.message(
      'My Reviews',
      name: 'MyReviews',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get Language {
    return Intl.message(
      'Language',
      name: 'Language',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get English {
    return Intl.message(
      'English',
      name: 'English',
      desc: '',
      args: [],
    );
  }

  /// `Hindi`
  String get Hindi {
    return Intl.message(
      'Hindi',
      name: 'Hindi',
      desc: '',
      args: [],
    );
  }

  /// `Terms And Condition`
  String get TermsAndCondition {
    return Intl.message(
      'Terms And Condition',
      name: 'TermsAndCondition',
      desc: '',
      args: [],
    );
  }

  /// `About Us`
  String get AboutUs {
    return Intl.message(
      'About Us',
      name: 'AboutUs',
      desc: '',
      args: [],
    );
  }

  /// `Help Center`
  String get HelpCenter {
    return Intl.message(
      'Help Center',
      name: 'HelpCenter',
      desc: '',
      args: [],
    );
  }

  /// `Write Something`
  String get WriteSomething {
    return Intl.message(
      'Write Something',
      name: 'WriteSomething',
      desc: '',
      args: [],
    );
  }

  /// `write some messages`
  String get writesomemessages {
    return Intl.message(
      'write some messages',
      name: 'writesomemessages',
      desc: '',
      args: [],
    );
  }

  /// `Delete Account`
  String get DeleteAccount {
    return Intl.message(
      'Delete Account',
      name: 'DeleteAccount',
      desc: '',
      args: [],
    );
  }

  /// `Want To Delete?`
  String get WantToDelete {
    return Intl.message(
      'Want To Delete?',
      name: 'WantToDelete',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get Cancel {
    return Intl.message(
      'Cancel',
      name: 'Cancel',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get Delete {
    return Intl.message(
      'Delete',
      name: 'Delete',
      desc: '',
      args: [],
    );
  }

  /// `Log Out`
  String get log_Out {
    return Intl.message(
      'Log Out',
      name: 'log_Out',
      desc: '',
      args: [],
    );
  }

  /// `Book`
  String get Book {
    return Intl.message(
      'Book',
      name: 'Book',
      desc: '',
      args: [],
    );
  }

  /// `Reviews`
  String get Reviews {
    return Intl.message(
      'Reviews',
      name: 'Reviews',
      desc: '',
      args: [],
    );
  }

  /// `Portfolio`
  String get Portfolio {
    return Intl.message(
      'Portfolio',
      name: 'Portfolio',
      desc: '',
      args: [],
    );
  }

  /// `Details`
  String get details {
    return Intl.message(
      'Details',
      name: 'details',
      desc: '',
      args: [],
    );
  }

  /// `Based on`
  String get Basedon {
    return Intl.message(
      'Based on',
      name: 'Basedon',
      desc: '',
      args: [],
    );
  }

  /// `Appointments`
  String get Contactno {
    return Intl.message(
      'Appointments',
      name: 'Contactno',
      desc: '',
      args: [],
    );
  }

  /// `Appointments`
  String get Monday {
    return Intl.message(
      'Appointments',
      name: 'Monday',
      desc: '',
      args: [],
    );
  }

  /// `Appointments`
  String get Tuesday {
    return Intl.message(
      'Appointments',
      name: 'Tuesday',
      desc: '',
      args: [],
    );
  }

  /// `Appointments`
  String get Wednesday {
    return Intl.message(
      'Appointments',
      name: 'Wednesday',
      desc: '',
      args: [],
    );
  }

  /// `Appointments`
  String get Thursday {
    return Intl.message(
      'Appointments',
      name: 'Thursday',
      desc: '',
      args: [],
    );
  }

  /// `Appointments`
  String get Friday {
    return Intl.message(
      'Appointments',
      name: 'Friday',
      desc: '',
      args: [],
    );
  }

  /// `Appointments`
  String get Saturday {
    return Intl.message(
      'Appointments',
      name: 'Saturday',
      desc: '',
      args: [],
    );
  }

  /// `Appointments`
  String get Sunday {
    return Intl.message(
      'Appointments',
      name: 'Sunday',
      desc: '',
      args: [],
    );
  }

  /// `Why do you want to Report?`
  String get whydoyouwanttoreport {
    return Intl.message(
      'Why do you want to Report?',
      name: 'whydoyouwanttoreport',
      desc: '',
      args: [],
    );
  }

  /// `Something about the person`
  String get R1 {
    return Intl.message(
      'Something about the person',
      name: 'R1',
      desc: '',
      args: [],
    );
  }

  /// `Poor Service`
  String get R2 {
    return Intl.message(
      'Poor Service',
      name: 'R2',
      desc: '',
      args: [],
    );
  }

  /// `Taking Unnecessary Time`
  String get R3 {
    return Intl.message(
      'Taking Unnecessary Time',
      name: 'R3',
      desc: '',
      args: [],
    );
  }

  /// `Lack of Time Management`
  String get R4 {
    return Intl.message(
      'Lack of Time Management',
      name: 'R4',
      desc: '',
      args: [],
    );
  }

  /// `Rude Behaviour`
  String get R5 {
    return Intl.message(
      'Rude Behaviour',
      name: 'R5',
      desc: '',
      args: [],
    );
  }

  /// `BookServices`
  String get BookServices {
    return Intl.message(
      'BookServices',
      name: 'BookServices',
      desc: '',
      args: [],
    );
  }

  /// `AddServices`
  String get AddServices {
    return Intl.message(
      'AddServices',
      name: 'AddServices',
      desc: '',
      args: [],
    );
  }

  /// `ApplyCoupon`
  String get ApplyCoupon {
    return Intl.message(
      'ApplyCoupon',
      name: 'ApplyCoupon',
      desc: '',
      args: [],
    );
  }

  /// `BillDetails`
  String get BillDetails {
    return Intl.message(
      'BillDetails',
      name: 'BillDetails',
      desc: '',
      args: [],
    );
  }

  /// `ItemTotal`
  String get ItemTotal {
    return Intl.message(
      'ItemTotal',
      name: 'ItemTotal',
      desc: '',
      args: [],
    );
  }

  /// `Discount`
  String get Discount {
    return Intl.message(
      'Discount',
      name: 'Discount',
      desc: '',
      args: [],
    );
  }

  /// `Govt. Taxes & Restaurant Charges (10%)`
  String get GST {
    return Intl.message(
      'Govt. Taxes & Restaurant Charges (10%)',
      name: 'GST',
      desc: '',
      args: [],
    );
  }

  /// `To Pay`
  String get Topay {
    return Intl.message(
      'To Pay',
      name: 'Topay',
      desc: '',
      args: [],
    );
  }

  /// `At Shop`
  String get AtShop {
    return Intl.message(
      'At Shop',
      name: 'AtShop',
      desc: '',
      args: [],
    );
  }

  /// `Home Visit`
  String get HomeVisit {
    return Intl.message(
      'Home Visit',
      name: 'HomeVisit',
      desc: '',
      args: [],
    );
  }

  /// `Appointment Details`
  String get AppointmentDetails {
    return Intl.message(
      'Appointment Details',
      name: 'AppointmentDetails',
      desc: '',
      args: [],
    );
  }

  /// `Your Booking is Confirmed`
  String get Confirmed {
    return Intl.message(
      'Your Booking is Confirmed',
      name: 'Confirmed',
      desc: '',
      args: [],
    );
  }

  /// `Pay`
  String get pay {
    return Intl.message(
      'Pay',
      name: 'pay',
      desc: '',
      args: [],
    );
  }

  /// `Add New Address`
  String get AddNewAddress {
    return Intl.message(
      'Add New Address',
      name: 'AddNewAddress',
      desc: '',
      args: [],
    );
  }

  /// `Proceed To Pay`
  String get ProceedToPay {
    return Intl.message(
      'Proceed To Pay',
      name: 'ProceedToPay',
      desc: '',
      args: [],
    );
  }

  /// `View Detailed Bill`
  String get ViewDetailedBill {
    return Intl.message(
      'View Detailed Bill',
      name: 'ViewDetailedBill',
      desc: '',
      args: [],
    );
  }

  /// `Payment Method`
  String get PaymentMethod {
    return Intl.message(
      'Payment Method',
      name: 'PaymentMethod',
      desc: '',
      args: [],
    );
  }

  /// `View All`
  String get ViewAll {
    return Intl.message(
      'View All',
      name: 'ViewAll',
      desc: '',
      args: [],
    );
  }

  /// `Your Payment of`
  String get YourPaymentof {
    return Intl.message(
      'Your Payment of',
      name: 'YourPaymentof',
      desc: '',
      args: [],
    );
  }

  /// `is Successful`
  String get isSuccessful {
    return Intl.message(
      'is Successful',
      name: 'isSuccessful',
      desc: '',
      args: [],
    );
  }

  /// `ViewCart`
  String get ViewCart {
    return Intl.message(
      'ViewCart',
      name: 'ViewCart',
      desc: '',
      args: [],
    );
  }

  /// `Enter Coupon Code`
  String get EnterCode {
    return Intl.message(
      'Enter Coupon Code',
      name: 'EnterCode',
      desc: '',
      args: [],
    );
  }

  /// `Apply`
  String get Apply {
    return Intl.message(
      'Apply',
      name: 'Apply',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'hi'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
