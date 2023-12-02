import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:serviceapplatest/setting/refund.dart';
import 'package:http/http.dart'as http;
import '../generated/l10n.dart';
import '../helper/apis.dart';
import 'package:serviceapplatest/helper/constant.dart';
import '../helper/image.dart';
import '../model/refund_model.dart';



class RefundCompleteScreen extends StatefulWidget {
  const RefundCompleteScreen({Key? key}) : super(key: key);

  @override
  State<RefundCompleteScreen> createState() => _RefundCompleteScreenState();
}

class _RefundCompleteScreenState extends State<RefundCompleteScreen> {

  final List<OfferModel> _offermodel = [
    OfferModel(image: ProjectImage.comb, name: "Hair Salon"),
    OfferModel(image: ProjectImage.girlappointment, name: "Nail Salon"),
  ];

  bool _hashData = false;
  bool _isVisible = false;
  RefundModel?_refundModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Helper.checkInternet(getCompletedBookingApi());
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
          S.of(context).Refund,
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
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Text("${S.of(context).NoDataFound}"),
        ),
    )
     );
  }

  setProgress(bool show) {
    if (mounted)
      setState(() {
        _isVisible = show;
      });
  }

  Future<void> getCompletedBookingApi() async {

    print("<==============getCompletedBookingApi==================>");

    _hashData = true;
    setProgress(true);

    SessionHelper session = await SessionHelper.getInstance(context);
    String userId = session.get(SessionHelper.USER_ID) ?? "0";


    Map data = {
      'user_id': userId,
    };

    print("Request =============>" + data.toString());
    try {
      var res = await http.post(Uri.parse(Apis.getCompletedBooking), body: data);
      print("Response========>" + res.body);

      if (res.statusCode == 200) {
        try {
          final jsonResponse = jsonDecode(res.body);
          RefundModel model = RefundModel.fromJson(jsonResponse);

          if (model.status == "true") {

            _hashData = false;

            setState(() {
              _refundModel = model;
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




}
class OfferModel {
  String image = "";
  String name = "";

  OfferModel({required this.image, required this.name});
}