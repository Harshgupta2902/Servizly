import 'dart:convert';

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:serviceapplatest/helper/constant.dart';
import '../bottom_screens/bottom.dart';
import '../helper/image.dart';
import '../helper/apis.dart';
import '../model/get_card_details_model.dart';
import 'card_detail.dart';


class AllCards extends StatefulWidget {

  String total = "";

  AllCards({required this.total});

  @override
  State<AllCards> createState() => _AllCardsState();
}

class _AllCardsState extends State<AllCards> {


  String cards = "";
  String _selectPlace = "";

  bool _hashData = false;
  bool _isVisible = false;

  GetCardDetailsModel?_getCardDetailsModel;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  Helper.checkInternet(getCardDetailsApi());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 100,
        titleSpacing: 0,
        backgroundColor: Color(0xFFf5f5f5),
        centerTitle: true,
        title: Text(
          "Card",
          style: GoogleFonts.poppins(
              textStyle: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              )),
        ),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context,);

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
      body: Stack(
        children: [
          _getCardDetailsModel == null
              ? _hashData
              ? Container()
              : Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Center(
                  child: Text(
                    "No data found",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 25),
                  )))
              : Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
           padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
           child: SingleChildScrollView(
             child: Column(
               children: [
                 ListView.builder(
                     scrollDirection: Axis.vertical,
                     physics: NeverScrollableScrollPhysics(),
                     // padding: EdgeInsets.symmetric(horizontal: 10),
                     // padding: EdgeInsets.only(top: 10),
                     shrinkWrap: true,
                     itemCount: _getCardDetailsModel!.cardDetails!.length,
                     itemBuilder: (BuildContext context, int index) {
                       print("index*****${index}");
                       cards =    _getCardDetailsModel!.cardDetails![0].cardnumber!.length.toString();
                       print("lenth=====================>${cards.toString()}");
                       return  Container(
                           margin: EdgeInsets.only(top: 10),
                           height: 70,
                           padding: EdgeInsets.symmetric(horizontal: 0,vertical: 15),
                           decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(10),
                             color: Colors.white,
                             // boxShadow: [
                             //   BoxShadow(
                             //     color: Colors.grey.withOpacity(0.2),
                             //     spreadRadius: 2,
                             //     blurRadius: 2,
                             //     offset: Offset(0, 1), // changes position of shadow
                             //   ),
                             // ],
                           ),
                           child: InkWell(
                             onTap: () {
                               setState(() {
                                 _selectPlace = index.toString();
                               });
                               Helper.moveToScreenwithPush(context, CardDetail(
                                 Number: _getCardDetailsModel!.cardDetails![index].cardnumber.toString(),
                                 Date: _getCardDetailsModel!.cardDetails![index].expiryDate.toString(),
                                 Name: _getCardDetailsModel!.cardDetails![index].holderName.toString(),
                                 total: widget.total,
                               ));
                             },
                             child: Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: [
                                 Row(
                                   children: [
                                     Image.asset(ProjectImage.visa1, height: 30),
                                     SizedBox(
                                       width: 10,
                                     ),
                                     Image.asset(ProjectImage.password, height: 10),
                                     SizedBox(
                                       width: 5,
                                     ),
                                     Text(_getCardDetailsModel!.cardDetails![0].cardnumber.toString().substring(6,
                                         int.parse(cards)),
                                         style: TextStyle(
                                             fontSize: 20,
                                             fontWeight: FontWeight.w600,
                                             color: Color(0xFF737b82))),
                                   ],
                                 ),
                                 _selectPlace == index.toString()
                                     ?
                                 Image.asset(ProjectImage.checklist,
                                   height: 30,width: 30,
                                 )
                                     :
                                 Icon(Icons.radio_button_checked_rounded,
                                     color: Color(0xFFD9D9D9),
                                     size: 25)
                               ],
                             ),
                           ),

                       );
                     }),
               ],
             ),
           ),
          ),
          Positioned(child: Helper.getProgressBarWhite(context, _isVisible))
        ],
      ),
    );
  }

  setProgress(bool show) {
    if (mounted)
      setState(() {
        _isVisible = show;
      });
  }


  Future<void> getCardDetailsApi() async {

    print("<==============getCardDetailsApi==================>");

    _hashData = true;
    setProgress(true);

    SessionHelper session = await SessionHelper.getInstance(context);
    String userId = session.get(SessionHelper.USER_ID) ?? "0";


    Map data = {
      'user_id': userId,
    };

    print("Request ====================>" + data.toString());
    try {
      var res = await http.post(Uri.parse(Apis.getCardDetails), body: data);
      print("Response==================>" + res.body);

      if (res.statusCode == 200) {
        try {
          final jsonResponse = jsonDecode(res.body);
          GetCardDetailsModel model = GetCardDetailsModel.fromJson(jsonResponse);

          print("Response========================>" + res.body);

          if (model.status == "true") {

            _hashData = false;


            setState(() {
              _getCardDetailsModel = model;
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


  // showAlertDialog(BuildContext context) {
  //
  //   // set up the AlertDialog
  //
  //
  //   AlertDialog alert = AlertDialog(
  //     scrollable: false,
  //     insetPadding: EdgeInsets.symmetric(horizontal: 0),
  //     backgroundColor: Colors.transparent,
  //     elevation: 0,
  //     content:  Container(
  //         padding: EdgeInsets.symmetric(horizontal:  30,vertical: 30),
  //         margin: EdgeInsets.only(top: 50),
  //         height: 400,
  //         width: 380,
  //         decoration: BoxDecoration(
  //             borderRadius: BorderRadius.circular(30),
  //             color: Colors.white),
  //         child:
  //         Column(
  //           crossAxisAlignment: CrossAxisAlignment.center,
  //           mainAxisAlignment: MainAxisAlignment.start,
  //           children: [
  //             SizedBox(height: 10),
  //             Image.asset(ProjectImage.checklist,height: 100,color: Color(0xFF1ba571)),
  //             Text("Payment Successful",style: GoogleFonts.poppins(
  //                 textStyle: TextStyle(
  //                   fontSize: 20,
  //                   fontWeight: FontWeight.w500,
  //                   color: Color(0xFF1ba571),
  //                 )),),
  //             Text("Transaction number : 149538292331",
  //               style: GoogleFonts.poppins(
  //                   color: Color(0xFF8C8C8C),
  //                   fontWeight: FontWeight.w400,
  //                   fontSize: 12
  //               ),
  //             ),
  //             SizedBox(height: 10,),
  //             DottedLine(
  //               direction: Axis.horizontal,
  //               lineLength: double.infinity,
  //               lineThickness: 1.0,
  //               dashLength: 4.0,
  //               dashColor: Color(0xFFdedede),
  //               dashGapLength: 2.0,
  //               dashGapColor: Colors.transparent,
  //               dashGapRadius: 4.0,
  //             ),
  //             SizedBox(height: 10,),
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 Text("Amount Paid",style: GoogleFonts.poppins(
  //                     textStyle: TextStyle(
  //                       fontSize: 15,
  //                       fontWeight: FontWeight.w500,
  //                       color: Color(0xFF8C8C8C),
  //                     )),),
  //                 Text(widget.total,
  //                   style: GoogleFonts.poppins(
  //                       textStyle: TextStyle(
  //                         fontSize: 15,
  //                         fontWeight: FontWeight.w500,
  //                         color: Color(0xFF8C8C8C),
  //                       )),),
  //               ],
  //             ),
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 Text("Bank",style: GoogleFonts.poppins(
  //                     textStyle: TextStyle(
  //                       fontSize: 15,
  //                       fontWeight: FontWeight.w500,
  //                       color: Color(0xFF8C8C8C),
  //                     )),),
  //                 Text("SBI",style: GoogleFonts.poppins(
  //                     textStyle: TextStyle(
  //                       fontSize: 15,
  //                       fontWeight: FontWeight.w500,
  //                       color: Color(0xFF8C8C8C),
  //                     )),),
  //               ],
  //             ),
  //             SizedBox(height: 25,),
  //             MaterialButton(
  //               color: Colors.white,
  //               minWidth: 200,
  //               height: 45,
  //               textColor: Colors.white,
  //               elevation: 20,
  //               child: Text("Ok",
  //                 style: GoogleFonts.poppins(
  //                     color:Colors.black,
  //                     fontWeight: FontWeight.w600,
  //                     fontSize: 17
  //                 ),
  //               ),
  //               shape: RoundedRectangleBorder(
  //                   borderRadius: BorderRadius.circular(30)),
  //               onPressed: () {
  //                 print("tap--------------------->");
  //                 Helper.moveToScreenwithPushreplaceemt(
  //                     context, Bottom());
  //
  //               },
  //             )
  //           ],
  //         )
  //     ),
  //   );
  //
  //   // show the dialog
  //   showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (BuildContext context) {
  //       return alert;
  //     },
  //   );
  // }



}
