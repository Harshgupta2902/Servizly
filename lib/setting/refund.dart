

import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fdottedline_nullsafety/fdottedline__nullsafety.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:serviceapplatest/bottom_screens/bottom.dart';
import 'package:serviceapplatest/setting/refund_successful.dart';
import 'package:http/http.dart'as http;
import '../helper/apis.dart';
import '../helper/constant.dart';
import '../helper/image.dart';
import '../model/get_booking_details_model.dart';
import '../model/get_refund_model.dart';
import '../model/refund_model.dart';

class Refund extends StatefulWidget {
  String booking_id="";

  Refund({required this.booking_id});

  @override
  State<Refund> createState() => _RefundState();
}

class _RefundState extends State<Refund> {


  bool _hashData = false;
  bool _isVisible = false;

  String amt = "";

  TextEditingController _reasonController = TextEditingController();

  GetBookingDetailsModel?_getBookingDetailsModel;

  GetRefundModel?_getRefundModel;

  final List<OfferModel> _offermodel = [
    OfferModel(image: ProjectImage.comb, name: "Lemongrass Salon",cut: "Hair cut",rs: "₹277",deleteImg: ProjectImage.delete,
      req: "Request for refund"),
    OfferModel(image: ProjectImage.comb, name: "Lemongrass Salon",cut: "Hair cut",rs: "₹277",deleteImg: ProjectImage.delete,
        req: "Request for refund"),

  ];

@override
  void initState() {
    // TODO: implement initState
    super.initState();
  // Helper.checkInternet((getRefundApi()));
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
          "Refund",
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
              color: Colors.white,
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
      // body: Stack(
      //   children: [
      //     _getBookingDetailsModel == null
      //         ? _hashData
      //         ? Container()
      //         : Container(
      //         height: MediaQuery.of(context).size.height,
      //         width: MediaQuery.of(context).size.width,
      //         child: Center(
      //             child: Text(
      //               "No data found",
      //               style: TextStyle(
      //                   fontWeight: FontWeight.bold,
      //                   color: Colors.black,
      //                   fontSize: 25),
      //             )))
      //         : Container(
      //       height: MediaQuery.of(context).size.height,
      //       width: MediaQuery.of(context).size.width,
      //       padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
      //       child: SingleChildScrollView(
      //         child: Column(
      //           crossAxisAlignment: CrossAxisAlignment.start,
      //           mainAxisAlignment: MainAxisAlignment.start,
      //           children: [
      //             Text(
      //               "Service",
      //               style: GoogleFonts.poppins(
      //                   textStyle: TextStyle(
      //                     fontSize: 20,
      //                     fontWeight: FontWeight.w600,
      //                     color: AppColor.primaryColor,
      //                   )),
      //             ),
      //             SizedBox(height: 30,),
      //             ListView.builder(
      //                 scrollDirection: Axis.vertical,
      //                 itemCount: _getBookingDetailsModel!.service!.length,
      //                 shrinkWrap: true,
      //                 physics: NeverScrollableScrollPhysics(),
      //                 itemBuilder: (BuildContext context, int index) {
      //                   return
      //                     Container(
      //                       margin: EdgeInsets.symmetric(vertical: 10),
      //                       padding:const EdgeInsets.symmetric(vertical: 20,horizontal: 10),
      //                       decoration:const BoxDecoration(
      //                         borderRadius: BorderRadius.all(
      //                           Radius.circular(15),
      //                         ),
      //                         color: Color(0xFFFFFFFF),
      //                         boxShadow: [
      //                           BoxShadow(
      //                             color: Colors.black12,
      //                             blurRadius: 7,
      //                             offset: Offset(3, 5),
      //                           ),
      //                         ],
      //                       ),
      //                       child: Column(
      //                         children: [
      //                           Row(
      //                             // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                             crossAxisAlignment: CrossAxisAlignment.start,
      //                             children: [
      //                               Image.asset(_offermodel[index].image,
      //                                 height: 40,width: 40,),
      //                               SizedBox(width: 15,),
      //                               Column(
      //                                 crossAxisAlignment: CrossAxisAlignment.start,
      //                                 children: [
      //                                   Text(
      //                                     _getBookingDetailsModel!.bookingDetails![0].saloonName.toString(),
      //                                     // _refundModel!.serviceBooked![index].toString(),
      //                                     style: GoogleFonts.poppins(
      //                                         textStyle: TextStyle(
      //                                           fontSize: 15,
      //                                           fontWeight: FontWeight.w600,
      //                                           color: Color(0xFF222222),
      //                                         )),
      //                                   ),
      //                                   Text(
      //                                     _getBookingDetailsModel!.service![index].toString(),
      //                                     style: GoogleFonts.poppins(
      //                                         textStyle: TextStyle(
      //                                           fontSize: 14,
      //                                           fontWeight: FontWeight.w600,
      //                                           color: Color(0xFF727679),
      //                                         )),
      //                                   ),
      //                                 ],
      //                               ),
      //                               // SizedBox(width: 65,),
      //                               Padding(
      //                                 padding: const EdgeInsets.only(left: 100),
      //                                 child: Row(
      //                                   mainAxisAlignment: MainAxisAlignment.start,
      //                                   children: [
      //                                     Text(
      //                                       _getBookingDetailsModel!.price![index].toString(),                                            style: GoogleFonts.poppins(
      //                                           textStyle: TextStyle(
      //                                             fontSize: 16,
      //                                             fontWeight: FontWeight.w600,
      //                                             color: AppColor.primaryColor,
      //                                           )),
      //                                     ),
      //                                     SizedBox(width: 20,),
      //                                     Image.asset(_offermodel[index].deleteImg,
      //                                       height: 30,width: 30,),
      //                                   ],
      //                                 ),
      //                               )
      //                             ],
      //                           ),
      //                           SizedBox(height: 10,),
      //                           FDottedLine(
      //                             color: Color(0xFF777777),
      //                             width: MediaQuery.of(context).size.width,
      //                             strokeWidth: 1.0,
      //                             dottedLength: 5.0,
      //                             space: 5.0,
      //                           ),
      //                           SizedBox(height: 10,),
      //                           Align(
      //                             alignment: Alignment.center,
      //                             child: InkWell(
      //                               onTap: (){
      //                                 showAlertDialogReqRefund(context,
      //                                     _getBookingDetailsModel!.bookingDetails![index].bookingId.toString(),
      //                                   _getBookingDetailsModel!.price![index].toString(),
      //                                 );
      //                               },
      //                               child: Text(
      //                                 _offermodel[index].req,
      //                                 style: GoogleFonts.poppins(
      //                                     textStyle: TextStyle(
      //                                       fontSize: 17,
      //                                       fontWeight: FontWeight.w600,
      //                                       color: Color(0xFFF14656),
      //                                     )),
      //                               ),
      //                             ),
      //                           ),
      //                         ],
      //                       ),
      //                     );
      //                 }),
      //             SizedBox(height: 10,),
      //             Align(
      //               alignment: Alignment.centerRight,
      //               child: InkWell(
      //                 onTap: (){
      //                   Helper.moveToScreenwithPush(context, RefundSuccessful());
      //                 },
      //                 child: Container(
      //                     width: 80,
      //                     height: 30,
      //                     padding: EdgeInsets.symmetric(horizontal: 10),
      //                     decoration: BoxDecoration(
      //                         border: Border.all(color: AppColor.primaryColor),
      //                         borderRadius: BorderRadius.circular(5)
      //                     ),
      //                     child: Text("view all",
      //                       style: GoogleFonts.poppins(
      //                         color:AppColor.primaryColor,
      //                         fontWeight: FontWeight.w500,
      //                         fontSize: 15,),
      //                     )
      //                 ),
      //               ),
      //             ),
      //           ],
      //         ),
      //       ),
      //     ),
      //     Positioned(child: Helper.getProgressBarWhite(context, _isVisible ))
      //   ],
      // ),
     body: _getRefundModel == null
        ?Container(
       height: MediaQuery.of(context).size.height,
       width: MediaQuery.of(context).size.width,
       child: Center(
         child: Text("No Details Found"),
       ),
     )
         :Container(
       height: MediaQuery.of(context).size.height,
       width: MediaQuery.of(context).size.width,
     ),
    );
  }

  showAlertDialog(BuildContext context) {

    AlertDialog alert = AlertDialog(
      scrollable: false,
      insetPadding: EdgeInsets.symmetric(horizontal: 0),
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Container(
          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
          margin: EdgeInsets.only(top: 50),
          height: 280,
          width: 280,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.white),
          child:
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(ProjectImage.right,
                height: 60,
                width: 60,),
              SizedBox(height: 10,),
              Text(
                "Refund request sent successfully",
                style: GoogleFonts.poppins(
                    color: Color(0xFF1D1D1D),
                    fontWeight: FontWeight.w600,
                    fontSize: 16
                ),textAlign: TextAlign.center,
              ),
              SizedBox(height: 15,),
              Text(
                "Amount will be credited within 24 hours",
                style: GoogleFonts.poppins(
                    color: Color(0xFF1D1D1D),
                    fontWeight: FontWeight.w400,
                    fontSize: 13
                ),textAlign: TextAlign.center,
              ),
              SizedBox(height: 10,),
              MaterialButton(
                color:  Colors.white,
                minWidth: 280,
                height: 50,
                textColor: Colors.black,
                child: Text("Ok",
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 18
                  ),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                onPressed: () {
                  Helper.moveToScreenwithPushreplaceemt(context, Bottom());
                  // Navigator.of(context, rootNavigator: false).pop('dialog');
                },
              ),
            ],
          )
      ),
    );

    // show the dialog
    showDialog(

      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showAlertDialogReqRefund(BuildContext context,String booking_id,String amount) {

    // set up the AlertDialog

    AlertDialog alert = AlertDialog(
      scrollable: false,
      insetPadding: EdgeInsets.symmetric(horizontal: 0),
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Container(
          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
          // margin: EdgeInsets.only(top: 20),
          height: 310,
          width: 300,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(ProjectImage.right,
                height: 60,
                width: 60,),
              SizedBox(height: 10,),
              Text(
                "Reason for Request for Refund",
                style: GoogleFonts.poppins(
                    color: Color(0xFF1D1D1D),
                    fontWeight: FontWeight.w600,
                    fontSize: 16
                ),textAlign: TextAlign.center,
              ),
              SizedBox(height: 15,),
              TextFormField(
                controller: _reasonController,
                keyboardType: TextInputType.name,
                maxLines: 3,
                // inputFormatters: [
                //   FilteringTextInputFormatter.digitsOnly,
                //   CardNumberFormatter(),
                // ],
                decoration: InputDecoration(
                  // border: const OutlineInputBorder(),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  hintText: 'Enter your Reason',
                ),
                // maxLength: 19,
                onChanged: (value) {},
                // validator: (value) {
                //   if (cardNumber.text.isEmpty) {
                //     return "Please enter card number";
                //   }
                //   else if(cardNumber.text.length<12){
                //     return "Card Number must be of 12 digit";
                //   }else {
                //     // isValidated  = true;
                //   }
                // },
              ),
              SizedBox(height: 10,),
              MaterialButton(
                color: Color(0xFF0ABDFC),
                minWidth: 280,
                height: 50,
                textColor:  AppColor.primaryColor,
                child: Text("Ok",
                  style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 18
                  ),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                onPressed: () {
                  Helper.popScreen(context);
                  Helper.checkInternet(getRefundApi());

                  // Navigator.of(context, rootNavigator: false).pop('dialog');
                },
              ),
            ],
          )
      ),
    );
    // show the dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<void> getBookingDetailsApi() async {

    print("<==============getBookingDetailsApi==================>");

    _hashData = true;
    setProgress(true);

    SessionHelper session = await SessionHelper.getInstance(context);
    String userId = session.get(SessionHelper.USER_ID) ?? "0";


    Map data = {
      'user_id': userId,
      "booking_id":1,
    };

    print("Request =============>" + data.toString());
    try {
      var res = await http.post(Uri.parse(Apis.getBookingDetails), body: data);
      print("Response========>" + res.body);

      if (res.statusCode == 200) {
        try {
          final jsonResponse = jsonDecode(res.body);
          GetBookingDetailsModel model = GetBookingDetailsModel.fromJson(jsonResponse);

          if (model.status == "true") {

            _hashData = false;

            setState(() {
              _getBookingDetailsModel = model;
            });



            print("Model status true123");
            setProgress(false);
            _hashData = false;
            ToastMessage.msg(model.message.toString());

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

  Future<void> getRefundApi() async {

    print("<==============getRefundApi==================>");

    _hashData = true;
    setProgress(true);

    SessionHelper session = await SessionHelper.getInstance(context);
    String userId = session.get(SessionHelper.USER_ID) ?? "0";


    Map data = {
      'user_id': userId,
      'booking_id': "3",
      'amount': "150",
      'refundReason': _reasonController.text.toString(),
    };

    print("Request =============>" + data.toString());
    try {
      var res = await http.post(Uri.parse(Apis.getRefund), body: data);
      print("Response========>" + res.body);

      if (res.statusCode == 200) {
        try {
          final jsonResponse = jsonDecode(res.body);
          GetRefundModel model = GetRefundModel.fromJson(jsonResponse);

          if (model.status == "true") {

            _hashData = false;

            setState(() {
              _getRefundModel = model;
              showAlertDialog(context);

            });

            print("Model status true123");
            setProgress(false);
            _hashData = false;
            ToastMessage.msg(model.message.toString());

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


  setProgress(bool show) {
    if (mounted)
      setState(() {
        _isVisible = show;
      });
  }



}


class OfferModel {
  String image = "";
  String name = "";
  String cut = "";
  String rs = "";
  String deleteImg = "";
  String req = "";

  OfferModel({required this.image, required this.name,required this.cut,required this.rs,
      required this.deleteImg,required this.req});
}