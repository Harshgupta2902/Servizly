import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart' as http;
import '../generated/l10n.dart';
import '../helper/apis.dart';

import 'package:serviceapplatest/helper/constant.dart';
import '../bottom_screens/bottom.dart';
import '../helper/image.dart';
import '../model/final_get_booking_details_page_model.dart';

class BookingDetailsPageAtShop extends StatefulWidget {
  String booking_id = "";
  // String coupon = "";
  // String discount = "";

  BookingDetailsPageAtShop(
      {required this.booking_id,
        // required this.coupon,
        // required this.discount,
      });
  @override
  State<BookingDetailsPageAtShop> createState() => _BookingDetailsPageAtShopState();
}

class _BookingDetailsPageAtShopState extends State<BookingDetailsPageAtShop> {
  GetBookingDetailsModel? _getBookingDetailsModel;
  bool _isVisible = false;
  bool _hashData = false;

  var customFacilitiesName = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Helper.checkInternet(getBookingDetails());
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () =>  loadData(),
      child: Scaffold(
        backgroundColor: Color(0xFFe9e9e9),
        body: SafeArea(
          child: _getBookingDetailsModel == null
              ?Container()
              :Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Container(
                  // decoration: BoxDecoration(
                  //   color: Colors.green
                  // ),
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                            onTap: () {
                              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                                  Bottom()), (Route<dynamic> route) => false);
                            },
                            child: Icon(Icons.arrow_back_ios_outlined, size: 20,)),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(S.of(context).AppointmentDetails,style: GoogleFonts.poppins(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),),
                            // Text("Reservation", style: GoogleFonts.poppins(
                            //     fontSize: 15,
                            //     color: Colors.black,
                            //     fontWeight: FontWeight.w500),)
                          ],
                        ),
                        Icon(Icons.arrow_back_ios_outlined,color: Colors.transparent,),
                      ],
                    ),
                  ),
                ),
                Lottie.asset(
                  ProjectImage.successpayment,
                  // height: 200,width: 200
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: Text(S.of(context).Confirmed,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Container(
                    height: 230,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text("Order id: #${_getBookingDetailsModel!.bookingDetails!.orderId.toString()}",
                            style: TextStyle(
                                fontSize: 14,

                            ),),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                // child: Icon(Icons.calendar_month_outlined),
                                child: Image.asset(ProjectImage.schedule,height: 20, width: 25,),
                              ),
                              Text("${_getBookingDetailsModel!.bookingDetails!.appointmentDate.toString()}",
                                style: GoogleFonts.poppins(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),),
                              Text("  at ${_getBookingDetailsModel!.bookingDetails!.time.toString()}",
                                style: GoogleFonts.poppins(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),)
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                // child: Icon(Icons.calendar_month_outlined),
                                child: Image.asset(ProjectImage.store,height: 20, width: 25,),

                              ),
                              Text(_getBookingDetailsModel!.shopDetails!.saloonName.toString(),
                                style: GoogleFonts.poppins(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),),
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                // child: Icon(Icons.location_on_rounded),
                                child: Image.asset(ProjectImage.pin,height: 20, width: 25,),

                              ),
                              Column(
                                // mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  Container(
                                    width: 200,
                                    child: Text(_getBookingDetailsModel!.shopDetails!.address.toString(),
                                      maxLines: 3,
                                      style: GoogleFonts.poppins(
                                          fontSize: 15,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500),),
                                  )
                                ],
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                // child: Icon(Icons.picture_in_picture_alt),
                                child: Image.asset(ProjectImage.beautySaloon, height: 20, width: 25,),

                              ),
                              Text(customFacilitiesName,
                                style: GoogleFonts.poppins(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Text("${S.of(context).pay} ₹${_getBookingDetailsModel!.bookingDetails!.amount.toString()} ${S.of(context).AtShop} ")

              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> getBookingDetails() async {
    print("<=============getBookingDetails =============>");

    SessionHelper sessionHelper = await SessionHelper.getInstance(context);
    String userId = sessionHelper.get(SessionHelper.USER_ID) ?? "0";

    print("<========getBookingDetails=====userId =============>" + userId);
    _hashData = true;
    setProgressWhite(true);

    Map data = {
      'user_id': userId,
      'booking_id': widget.booking_id.toString()
    };

    print("Request ====getBookingDetails=========>" + data.toString());
    try {
      var res = await http.post(Uri.parse(Apis.getBookingDetails), body: data);
      print("Response ======getBookingDetails======>" + res.body);

      if (res.statusCode == 200) {
        try {
          final jsonResponse = jsonDecode(res.body);
          GetBookingDetailsModel model = GetBookingDetailsModel.fromJson(jsonResponse);

          if (model.status == "true") {
            print("Model status true");

            setProgressWhite(false);
            _hashData = false;

            setState(() {
              _getBookingDetailsModel = model;
              customFacilitiesName =  _getBookingDetailsModel!.services!.toString().replaceAll('[', '').replaceAll(']', '');
              print("${customFacilitiesName}");
            });

            // ToastMessage.msg(model.message.toString());
          } else {
            setProgressWhite(false);
            _hashData = false;
            print("false ### ============>");
            // ToastMessage.msg(model.message.toString());
          }
        } catch (e) {
          print("false ============>");
          // ToastMessage.msg(StaticMessages.API_ERROR);
          print('exception ==> ' + e.toString());
        }
      } else {
        print("status code ==> " + res.statusCode.toString());
        // ToastMessage.msg(StaticMessages.API_ERROR);
      }
    } catch (e) {
      // ToastMessage.msg(StaticMessages.API_ERROR);
      print('Exception ======> ' + e.toString());
    }
    setProgressWhite(false);
    _hashData = false;
  }
  setProgressWhite(bool show) {
    if (mounted)
      setState(() {
        _isVisible = show;
      });
  }
  loadData() async {
    // leave();
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
        Bottom()), (Route<dynamic> route) => false);
    // Helper.moveToScreenwithPushreplaceemt(context, Bottom());
  }
}
