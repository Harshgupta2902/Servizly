import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/directions.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:http/http.dart' as http;
import 'package:serviceapplatest/Payment/add_new_address.dart';
import '../Payment/review_order.dart';
import '../bottom_screens/bottom.dart';
import '../generated/l10n.dart';
import '../helper/apis.dart';
import '../helper/constant.dart';
import '../helper/image.dart';
import '../model/add_address_model.dart';
import '../model/review_appointment_model.dart';

class AddAddressScreen extends StatefulWidget {
  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {

  String googleApikey = "AIzaSyDFaXVE1gppFRuzgDsBpCzUNBvYMwtaULk";
  GoogleMapController? mapController; //contrller for Google map
  CameraPosition? cameraPosition;
  TextEditingController housenoController = TextEditingController();
  TextEditingController landmarkController = TextEditingController();
  // LatLng startLocation = LatLng(6.465422,3.406448);
  String location = "Search Location";
  bool hideSearchBar = true;
  bool isValidated = false;
  final _formKey = GlobalKey<FormState>();
  bool _isVisible = false;
  bool _hashData = false;

  String descriptionOfAddress = "Search Location";

  static const LatLng center = LatLng(0.0, 0.0);
  String? _currentAddress;
  String? _postalcode;
  String? _streetAddress;
  bool hasPermission = false;
  Position? _currentPosition;
  GoogleMapController? controller;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  MarkerId? selectedMarker;
  int _markerIdCounter = 1;
  LatLng? markerPosition;

  String latToPass = "";
  String longToPass = "";

  String select = "";

  ReviewAppointmentModel?_reviewAppointmentModel;


  void _onMapCreated(GoogleMapController controller) {
    this.controller = controller;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCurrentPosition();
    // Helper.checkInternet(getREVIEWappointmentApi());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 100,
        titleSpacing: 0,
        backgroundColor: Color(0xFFFFFFFF),
        centerTitle: true,
        title: Text(
          S.of(context).AddAddress,
          style: GoogleFonts.poppins(
              textStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: AppColor.primaryColor,
          )),
        ),
        leading: InkWell(
          onTap: () {
            Helper.popScreen(context);
          },
          child: Container(
            height: 45,
            width: 45,
            margin: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Color(0xFFFFFFFF),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Image.asset(
                        ProjectImage.Addaddress,
                        height: 300,
                        width: MediaQuery.of(context).size.width,
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          color: Colors.white,
                        ),
                        child: InkWell(
                            onTap: () async {
                              hideSearchBar = false;

                              var place = await PlacesAutocomplete.show(
                                context: context,
                                apiKey: googleApikey,
                                mode: Mode.overlay,
                                types: [],
                                strictbounds: false,
                                components: [
                                  Component(Component.country, 'in')
                                ],
                                //google_map_webservice package
                                onError: (err) {
                                  print("err==>" + err.toString());
                                },
                              );

                              if (place != null) {
                                setState(() {
                                  hideSearchBar = true;
                                  location = place.description.toString();
                                  descriptionOfAddress =
                                      place.description.toString();
                                  housenoController.text=descriptionOfAddress.toString();
                                  print("---------housenoController=======----------${housenoController}");
                                });
                                //form google_maps_webservice package
                                final plist = GoogleMapsPlaces(
                                  apiKey: googleApikey,
                                  // apiHeaders: await GoogleApiHeaders().getHeaders(),
                                  //from google_api_headers package
                                );
                                String placeid = place.placeId ?? "0";
                                final detail =
                                    await plist.getDetailsByPlaceId(placeid);
                                final geometry = detail.result.geometry!;
                                final lat = geometry.location.lat;
                                final lang = geometry.location.lng;
                                var newlatlang = LatLng(lat, lang);
                                latToPass = lat.toString();
                                longToPass = lang.toString();

                                //move map camera to selected place with animation
                                mapController?.animateCamera(
                                    CameraUpdate.newCameraPosition(
                                        CameraPosition(
                                            target: newlatlang, zoom: 17)));
                              } else {
                                setState(() {
                                  hideSearchBar = true;
                                });
                              }
                            },
                            child: Visibility(
                              visible: hideSearchBar,
                              maintainAnimation: true,
                              maintainSize: true,
                              maintainState: true,
                              child: Padding(
                                padding: EdgeInsets.all(0),
                                child: Card(
                                  child: ListTile(
                                    leading: Icon(Icons.location_on_outlined,
                                        color: Colors.red),
                                    title: Text(
                                      descriptionOfAddress,
                                      style: TextStyle(fontSize: 18),
                                    ), // location change
                                    trailing: Icon(
                                      Icons.search,
                                      color: Colors.transparent,
                                    ),
                                    dense: true,
                                  ),
                                ),
                              ),
                            )),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: TextFormField(
                          controller: housenoController,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(300),
                          ],
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            hintText: S.of(context).HouseFlat,
                            hintStyle: GoogleFonts.poppins(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF1D1D1D)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Color(0xFFCFCFCF),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Color(0xFFCFCFCF)),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Color(0xFFCFCFCF)),
                            ),
                          ),
                          validator: (value) {
                            if (housenoController.text.isEmpty) {
                              return S.of(context).EnterAddress;
                            } else if (housenoController.text.length < 2 ) {
                              return "Address must be greater than two letters";
                            }else if(housenoController.text.length > 100){
                              return "Address is to long";
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: TextFormField(
                          controller: landmarkController,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(20),
                          ],
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            hintText: S.of(context).Landmark,
                            hintStyle: GoogleFonts.poppins(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF1D1D1D)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Color(0xFFCFCFCF),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Color(0xFFCFCFCF)),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Color(0xFFCFCFCF)),
                            ),
                          ),
                          validator: (value) {
                            if (landmarkController.text.isEmpty) {
                              return S.of(context).EnterLandmark;
                            } else if (landmarkController.text.length < 2 ||
                                landmarkController.text.length > 50) {
                              return "Landmark must be greater than two letters";
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                select = "Home";
                                print(select);

                              });
                            },
                            child: Row(
                              children: [
                                select == "Home"
                                    ? Icon(Icons.radio_button_checked_rounded,
                                        color: Color(0xFF09BDFC), size: 18)
                                    : Icon(Icons.radio_button_off,
                                        size: 18, color: Color(0xFF09BDFC)),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                    color: Color(0xFFe6f8ff),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 7,
                                        offset: Offset(3, 5),
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Text(
                                      S.of(context).Home,
                                      style: TextStyle(
                                          color: Color(0xFF1D1D1D),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                select = "Other";
                                print(select);
                              });
                            },
                            child: Row(
                              children: [
                                select == "Other"
                                    ? Icon(Icons.radio_button_checked_rounded,
                                        color: Color(0xFF09BDFC), size: 18)
                                    : Icon(Icons.radio_button_off,
                                        size: 18, color: Color(0xFF09BDFC)),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                    color: Color(0xFFe6f8ff),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 7,
                                        offset: Offset(3, 5),
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Text(
                                      S.of(context).other,
                                      style: TextStyle(
                                          color: Color(0xFF1D1D1D),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      MaterialButton(
                        color: Color(0xFF0ABDFC),
                        minWidth: 340,
                        height: 50,
                        textColor: Colors.white,
                        child: Text(S.of(context).Continue,
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w500),
                            )),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            Helper.checkInternet(AddaddressApi());

                            // if (_formkey.currentState!.validate()) {
                            //   _formkey.currentState!.save();
                            // Helper.moveToScreenwithPush(
                            //     context, const VerificationScreen());
                          }

                        },
                      ),
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
                Positioned(
                    child: Helper.getProgressBarWhite(context, _isVisible))
              ],
            ),
          )),
    );
  }

  void _add() {
    final int markerCount = markers.length;

    if (markerCount == 12) {
      return;
    }

    final String markerIdVal = 'marker_id_$_markerIdCounter';
    _markerIdCounter++;
    final MarkerId markerId = MarkerId(markerIdVal);

    final Marker marker = Marker(
      markerId: markerId,
      position: LatLng(
        _currentPosition!.latitude.toDouble(),
        _currentPosition!.longitude.toDouble(),
        // center.latitude + sin(_markerIdCounter * pi / 6.0) / 20.0,
        // center.longitude + cos(_markerIdCounter * pi / 6.0) / 20.0,
      ),
      infoWindow: InfoWindow(title: markerIdVal, snippet: '*'),
      onTap: () => _onMarkerTapped(markerId),
      onDragEnd: (LatLng position) => _onMarkerDragEnd(markerId, position),
      onDrag: (LatLng position) => _onMarkerDrag(markerId, position),
    );

    setState(() {
      markers[markerId] = marker;
    });
    _getAddressFromLatLng(Position(
        longitude: _currentPosition!.longitude,
        latitude: _currentPosition!.latitude,
        timestamp: _currentPosition!.timestamp,
        accuracy: _currentPosition!.accuracy,
        altitude: _currentPosition!.altitude,
        heading: _currentPosition!.heading,
        speed: _currentPosition!.speed,
        speedAccuracy: _currentPosition!.speedAccuracy));
  }

  Future<void> _onMarkerDragEnd(MarkerId markerId, LatLng newPosition) async {
    final Marker? tappedMarker = markers[markerId];
    if (tappedMarker != null) {
      setState(() {
        markerPosition = null;
      });
      await showDialog<void>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
                actions: <Widget>[
                  TextButton(
                    child: const Text('OK'),
                    onPressed: () => Navigator.of(context).pop(),
                  )
                ],
                content: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 66),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text('Old position: ${tappedMarker.position}'),
                        Text('New position: $newPosition'),
                      ],
                    )));
          });
    }
  }

  Future<void> _onMarkerDrag(MarkerId markerId, LatLng newPosition) async {
    setState(() {
      markerPosition = newPosition;
    });
  }

  void _onMarkerTapped(MarkerId markerId) {
    final Marker? tappedMarker = markers[markerId];
    if (tappedMarker != null) {
      setState(() {
        final MarkerId? previousMarkerId = selectedMarker;
        if (previousMarkerId != null && markers.containsKey(previousMarkerId)) {
          final Marker resetOld = markers[previousMarkerId]!
              .copyWith(iconParam: BitmapDescriptor.defaultMarker);
          markers[previousMarkerId] = resetOld;
        }
        selectedMarker = markerId;
        final Marker newMarker = tappedMarker.copyWith(
          iconParam: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueGreen,
          ),
        );
        markers[markerId] = newMarker;

        markerPosition = null;
      });
    }
  }

  void _remove(MarkerId markerId) {
    setState(() {
      if (markers.containsKey(markerId)) {
        markers.remove(markerId);
      }
    });
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    print("===========serviceEnabled===============================");
    print(serviceEnabled);
    if (!serviceEnabled) {
      permission = await Geolocator.checkPermission();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
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
      // setState(() {
      //   location.text = _currentAddress.toString();
      // });
      // SessionHelper().put(SessionHelper.LATITUDE, _currentPosition!.latitude.toString());
      //
      // SessionHelper().put(SessionHelper.LONGITUDE, _currentPosition!.longitude.toString());
    }).catchError((e) {
      debugPrint(e);
    });
    print("===========_currentPosition===============================");
    print(_currentPosition);
    _add();
    // Helper.moveToScreenwithPushreplaceemt(
    //     context, PersonalDetailsNeww(latitude: _currentPosition!.latitude.toString(),longitude:_currentPosition!.latitude.toString() ,));
    // HelperClass.checkInternet(SignupApi());
    // if (_image == null)
    // {
    //   Helper.checkInternet(SignupApi());
    // }
    // else {
    //   Helper.checkInternet((SignupApiWithImage(_image!.path)));
    // }
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
            '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}${place.locality} ,${place.country},${place.postalCode}';
        _streetAddress = "${place.subLocality}";
        _postalcode = "${place.postalCode}";
        location = _postalcode.toString();




        print(
            "=========================current address=========${_currentAddress}");
        print(
            "=========================current address=========${_streetAddress}");
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  setProgress(bool show) {
    if (mounted)
      setState(() {
        _isVisible = show;
      });
  }

  Future<void> AddaddressApi() async {
    setProgress(true);

    SessionHelper sessionHelper = await SessionHelper.getInstance(context);
    var user_id = sessionHelper.get(SessionHelper.USER_ID) ?? "1";

    print("<=============AddaddressApi================>");

    Map values = {
      'user_id': user_id,
      'flatNumber': housenoController.text.trim().toString(),
      'landmark': landmarkController.text.trim().toString(),
      'type': select,
    };

    try {
      print(values);
      var res = await http.post(Uri.parse(Apis.addAddress), body: values);
      print(res.body);
      if (res.statusCode == 200) {
        try {
          final jsonResponse = jsonDecode(res.body);

          Addaddressmodel model = Addaddressmodel.fromJson(jsonResponse);

          print(model.status);

          if (model.status == 'true') {

            Helper.moveToScreenwithPushreplaceemt(context, ReviewPayment(shop_id: "", coupon: "", discount: ""));

            setProgress(false);
            // ToastMessage.msg(model.message.toString());

          } else {
            setProgress(false);
            // ToastMessage.msg(model.message.toString());
          }
        } catch (e) {
          print('hello + $e');
        }
      }
    } catch (e) {
      print(e);
    }
  }



  Future<void> getREVIEWappointmentApi() async {

    print("<==============getREVIEWappointmentApi==================>");

    _hashData = true;
    setProgress(true);

    SessionHelper session = await SessionHelper.getInstance(context);
    print("<======getREVIEWappointmentApi========sessionhere===${session}===============>");
    String userId = session.get(SessionHelper.USER_ID) ?? "0";
    print("<=======getREVIEWappointmentApi=======userIdhere==${userId}===============>");


    Map data = {
      'user_id': userId,
      'booking_id':"widget.booking_id"
    };

    print("<=======getREVIEWappointmentApi=======userIdget=${data}===============>");

    print("Request =============>" + data.toString());
    try {
      var res = await http.post(Uri.parse(Apis.reviewAppointment), body: data);
      print("Response get ===getREVIEWappointmentApi========>" + res.body);

      if (res.statusCode == 200) {
        try {
          final jsonResponse = jsonDecode(res.body);
          ReviewAppointmentModel model = ReviewAppointmentModel.fromJson(jsonResponse);
          print("Response get ===getREVIEWappointmentApi123====${model}====>" + res.body);
          if (model.status == "true") {
            print("****true**");
            _hashData = false;
            print("****hashData${_hashData}**");
            setState(() {
              _reviewAppointmentModel = model;
              print("****_reviewAppointment${_reviewAppointmentModel}**");
              print("88888888888${_reviewAppointmentModel!. servicesBooked.toString()}");
              print("calculationstart..${_reviewAppointmentModel!.totalAmount}");


              ;
              print("here123");
              // nameController.text =_getprofileModel!.data!.name.toString() ;
              // phoneController.text =_getprofileModel!.data!.phone.toString() ;
              // emailController.text =_getprofileModel!.data!.email.toString() ;

              // showDate =dob ;
              // img =_profileModel!.userData![0].image![0].toString();

            });

            print("Model status true123");
            setProgress(false);
            _hashData = false;
            ToastMessage.msg(model.message.toString());
            // _nameController.text=model.data!.name!;
            // _emailController.text=model.data!.email!;
            // _phoneController.text.data!.phone!;

            // //Helper.moveToScreenwithPush(context, EditProfile());
            // SessionHelper sessionHelper =await SessionHelper.getInstance(context);
            // print("userId blah==========>${model.data!.userId.toString()}");
            // sessionHelper.put(SessionHelper.USER_ID,model.data!.userId.toString());
            // sessionHelper.put(SessionHelper.FULLNAME,model.data!.fullName.toString());
            // sessionHelper.put(SessionHelper.EMAIL,model.data!.email.toString());
            // sessionHelper.put(SessionHelper.PASSWORD,passwordController.text.trim());
            // sessionHelper.put(SessionHelper.GENDER,model.data!.gender.toString());
            // sessionHelper.put(SessionHelper.DOB,model.data!.dob.toString());
            // sessionHelper.put(SessionHelper.IMAGE,model.data!.image.toString());
            // sessionHelper.put(SessionHelper.FIREBASEID,model.data!.firebaseId.toString());
            // sessionHelper.put(SessionHelper.IS_ACTIVE,model.data!.isActive.toString());
            // sessionHelper.put(SessionHelper.LOCATION_STATUS,model.data!.locationStatus.toString());
          } else {
            setProgress(false);
            _hashData = false;
            print("false ### =====getreviewappointment=1======>");
            ToastMessage.msg(model.message.toString());
          }
        } catch (e) {
          _hashData = false;
          print("false =======getreviewappointment=2====>");
          ToastMessage.msg(StaticMessages.API_ERROR);
          print('exception ==> ' + e.toString());
        }
      } else {
        _hashData = false;
        print("status code ==> " + res.statusCode.toString());
        ToastMessage.msg(StaticMessages.API_ERROR);
      }
    } catch (e) {
      _hashData = false;
      ToastMessage.msg(StaticMessages.API_ERROR);
      print('Exception ==getreviewappointment====> ' + e.toString());
    }
  }

}
