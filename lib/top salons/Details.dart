import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:serviceapplatest/helper/constant.dart';

import 'dart:ui' as ui;
import '../generated/l10n.dart';
import '../helper/apis.dart';
import '../helper/image.dart';
import '../model/get_shop_data_modal.dart';

class Details extends StatefulWidget {
  String shop_id = "";
  Details({
    required this.shop_id,
  });

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  GetShopDataModal? _getShopDataApi;

  final List<TopSalonModel> _topsalonlist = [
    TopSalonModel(day: "Monday", time: "8:00 am - 11:00 am", time2: "12:00 am - 04:30 pm"),
    TopSalonModel(day: "Tuesday", time: "8:00 am - 11:00 am", time2: "12:00 am - 04:30 pm"),
    TopSalonModel(day: "Wednesday", time: "8:00 am - 11:00 am", time2: "12:00 am - 04:30 pm"),
    TopSalonModel(day: "Thursday", time: "8:00 am - 11:00 am", time2: "12:00 am - 04:30 pm"),
    TopSalonModel(day: "Friday", time: "8:00 am - 11:00 am", time2: "12:00 am - 04:30 pm"),
    TopSalonModel(day: "Saturday", time: "8:00 am - 11:00 am", time2: "12:00 am - 04:30 pm"),
    TopSalonModel(day: "Sunday", time: "8:00 am - 11:00 am", time2: "12:00 am - 04:30 pm"),
  ];

  int activeIndex = 0;

  bool _isVisible = false;
  bool _hashData = false;
  bool _showDocument = true;
  File? _image;

  String lati = "";
  String long = "";

  //new var
  String googleApikey = "AIzaSyCW1Jp9LDsBUNGt0P3r2jYXRW1gvouZYK0";
  GoogleMapController? mapController; //contrller for Google map
  CameraPosition? cameraPosition;
  LatLng startLocation = LatLng(20.5937, 78.9629);
  String location = "Enter your area";
  String receivedShopLat = "";
  String receivedShopLong = "";
  TextEditingController searchController = TextEditingController();

  List<Marker> _markers = <Marker>[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Helper.checkInternet(getShopDataApi());
    Helper.checkInternet(initialMethod());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  _getShopDataApi == null
                      ? _hashData
                          ? Container()
                          : Container(
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width,
                              child: Center(
                                  child: Text(
                                S.of(context).NoDataFound,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, color: Colors.black, fontSize: 25),
                              )))
                      : Container(
                          height: 200,
                          child: GoogleMap(
                            //Map widget from google_maps_flutter package
                            zoomGesturesEnabled: true, //enable Zoom in, out on map
                            initialCameraPosition: CameraPosition(
                              //innital position in map
                              target: startLocation, //initial position
                              zoom: 14.0, //initial zoom level
                            ),
                            mapType: MapType.normal, //map type
                            onMapCreated: (controller) {
                              //method called when map is created
                              setState(() {
                                mapController = controller;
                              });
                            },
                            onCameraMove: (CameraPosition cameraPositiona) {
                              cameraPosition = cameraPositiona;
                            },
                            onCameraIdle: () async {
                              List<Placemark> placemarks = await placemarkFromCoordinates(
                                  cameraPosition!.target.latitude,
                                  cameraPosition!.target.longitude);
                              setState(() {
                                location = placemarks.first.administrativeArea.toString() +
                                    ", " +
                                    placemarks.first.street.toString();
                              });
                            },

                            markers: Set<Marker>.of(_markers),
                          ),
                        ),
                  _getShopDataApi == null
                      ? Container()
                      : Positioned(
                          bottom: 15,
                          left: 10,
                          right: 20,
                          child: Container(
                            height: 50,
                            // width: 50,
                            decoration: BoxDecoration(
                                color: Colors.white, borderRadius: BorderRadius.circular(15)),
                            child: Center(
                              child: Text(
                                _getShopDataApi!.shopData!.address!.isEmpty == ""
                                    ? ""
                                    : _getShopDataApi!.shopData!.address.toString(),
                                style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                )),
                                maxLines: 2,
                              ),
                            ),
                          ),
                        ),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: TextFormField(
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(11),
                  ],
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    suffixIcon: Icon(
                      Icons.call,
                      color: AppColor.primaryColor,
                      size: 20,
                    ),
                    prefixIcon: Image.asset(
                      ProjectImage.mobile,
                      width: 10,
                      height: 10,
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    hintText: S.of(context).Contactno,
                    hintStyle: GoogleFonts.poppins(
                        fontSize: 15, fontWeight: FontWeight.w400, color: Color(0xFF1D1D1D)),
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
                ),
              ),
              ListView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: _topsalonlist.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      // height: 300,
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _topsalonlist[index].day,
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF8C8C8C),
                            )),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _topsalonlist[index].time,
                                style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF1D1D1D),
                                )),
                              ),
                              Text(
                                _topsalonlist[index].time2,
                                style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF1D1D1D),
                                )),
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }

  initialMethod() async {
    setState(() async {
      // print("lat==>${widget.lati}");
      // print("llong==>${widget.long}");

      SessionHelper session = await SessionHelper.getInstance(context);
      lati = session.get(SessionHelper.LATITUDE) ?? "0";
      long = session.get(SessionHelper.LONGITUDE) ?? "0";

      final lat = double.parse(lati);
      final lang = double.parse(long);
      var newlatlang = LatLng(lat, lang);
      startLocation = LatLng(lat, lang);
      mapController?.animateCamera(
          CameraUpdate.newCameraPosition(CameraPosition(target: newlatlang, zoom: 17)));
// final Uint8List markerIcon = await getBytesFromAsset('assets/img/pin2.png', 100);
      _markers.add(Marker(
        markerId: MarkerId('SomeId'),
        position: LatLng(lat, lang),
        // icon: BitmapDescriptor.fromBytes(markerIcon),
        // infoWindow: InfoWindow(
        //     title: 'The title of the marker'
        // )
      ));
    });
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }

  Future<void> getShopDataApi() async {
    _hashData = true;
    setProgress(true);
    print("<==============getShopDataApi==================>");

    _hashData = true;
    setProgress(true);

    SessionHelper session = await SessionHelper.getInstance(context);
    String userId = session.get(SessionHelper.USER_ID) ?? "0";

    Map data = {
      'user_id': userId,
      "shop_id": widget.shop_id,
    };

    print("Request =============>" + data.toString());
    try {
      var res = await http.post(Uri.parse(Apis.getShopData), body: data);
      print("Response ============>" + res.body);

      if (res.statusCode == 200) {
        try {
          final jsonResponse = jsonDecode(res.body);
          GetShopDataModal model = GetShopDataModal.fromJson(jsonResponse);

          if (model.status == "true") {
            _hashData = false;

            setState(() {
              _getShopDataApi = model;
            });

            print("Model status true");
            setProgress(false);
            _hashData = false;
            ToastMessage.msg(model.message.toString());
          } else {
            setProgress(false);
            _hashData = false;
            print("false ### ============>");
            ToastMessage.msg(model.message.toString());
          }
        } catch (e) {
          _hashData = false;
          print("false ============>");
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
      print('Exception ======> ' + e.toString());
    }
  }

  setProgress(bool show) {
    if (mounted)
      setState(() {
        _isVisible = show;
      });
  }
}

class TopSalonModel {
  String day = "";
  String time = "";
  String time2 = "";

  TopSalonModel({required this.day, required this.time, required this.time2});
}
