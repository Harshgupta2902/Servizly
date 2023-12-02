


import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';



import '../bottom_screens/bottom.dart';
import '../generated/l10n.dart';
import '../helper/constant.dart';
import '../bottom_screens/setting.dart';
import '../helper/image.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({Key? key}) : super(key: key);

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {


  Position? _currentPosition;
  String? _currentAddress;
  bool hasPermission = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 100),
                  child: Image.asset(ProjectImage.location,height: 100,),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Text(S.of(context).EnableLocationPermission,
                      style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500),)),
                ),
                Text(S.of(context).Loationdescription,textAlign: TextAlign.center, style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w500),)
                ),
                SizedBox(
                  height: 20,
                ),
                MaterialButton(
                  color: Color(0xFF0ABDFC),
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  height: 50,
                  textColor: Colors.white,
                  child: Text(S.of(context).AllowLocation,
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      )),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  onPressed: () {
                    _getCurrentPosition();

                  },
                ),

              ],
            ),
          ),
          Positioned(
            bottom: 0,
              child:  Container(
                child: Image.asset(ProjectImage.toolbox,height: 300,),
              ),)
        ],
      ),
    );
  }


  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    print("===========serviceEnabled===============================");
    print(serviceEnabled);
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      // permission = await Geolocator.checkPermission();
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     content: Text('Please turn on location to use this feature'),
      //     action: SnackBarAction(
      //       label: 'Turn on',
      //       onPressed: () async {
      //         await Geolocator.requestPermission();
      //       },
      //     ),
      //   ),
      // );
      return false;
    }
    permission = await Geolocator.checkPermission();
    print("===========permission===============================");
    print(permission);
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }
  Future<void> _getCurrentPosition() async {
    hasPermission = await _handleLocationPermission();
    print("----------------inside getcurrentposition---------------");
    if (!hasPermission) return;
    print("----------------has permission getcurrentposition---------------");
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);

      _getAddressFromLatLng(_currentPosition!);
      SessionHelper().put(SessionHelper.LATITUDE, _currentPosition!.latitude.toString());

      SessionHelper().put(SessionHelper.LONGITUDE, _currentPosition!.longitude.toString());

    } )
        .catchError((e) {
      //debugPrint(e);
      //
    }
    );
    print("===========_currentPosition===============================");
    print(_currentPosition);
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
          Bottom()), (Route<dynamic> route) => false);
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
        _currentPosition!.latitude,  _currentPosition!.longitude)
        .then((List<Placemark> placemarks) async {
      Placemark place = placemarks[0];
      setState(() {

        _currentAddress =
        '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
      });
      // Helper.checkInternet(SignupApi());
      // SessionHelper session = await SessionHelper.getInstance(context);
      // String fullNAme = session.put(SessionHelper.LOCATION, _currentAddress!);
      // print("current Address ====>>>${_currentAddress}");

    }).catchError((e) {
      debugPrint(e);
    });
  }


}
