


import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:serviceapplatest/helper/apis.dart';
import 'package:http/http.dart' as http;
import '../Payment/refund.dart';
import '../generated/l10n.dart';
import '../helper/constant.dart';
import '../helper/image.dart';
import '../model/past_appointment_list.dart';
import '../setting/refund.dart';
import 'dart:developer';

import '../setting/refund_complete_screen.dart';

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {

  bool _isSelect=false;
  bool _hasData=false;

  bool _isVisible = false;
  //
  // final List<OfferModel> _offermodel = [
  //   OfferModel(image: ProjectImage.comb, name: "Hair Salon"),
  //   OfferModel(image: ProjectImage.girlappointment, name: "Nail Salon"),
  // ];

  PastAppointmentList ?_pastAppointmentList;

  void initState() {

    //set the initial value of text field
    super.initState();
    Helper.checkInternet(pastAppointmentList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Stack(
        children: [
          _pastAppointmentList == null ?
          _hasData ?
          Container() :
          Container(
            child: Center(
              child: Text(S.of(context).NoDataFound),
            ),
          ) :
          Container(
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.symmetric(horizontal: 0),
                itemCount: _pastAppointmentList!.bookingList!.length,

                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    height:200,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Container(
                            height: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 2,
                                  offset: Offset(0, 1), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                           _pastAppointmentList!.bookingList![index].time.toString(),
                                        style: GoogleFonts.poppins(
                                            textStyle: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: AppColor.greytext,
                                            )),
                                      ),
                                      Text(
                                        _pastAppointmentList!.bookingList![index].saloonName.toString(),
                                        style: GoogleFonts.poppins(
                                            textStyle: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: AppColor.primaryColor,
                                            )),
                                      ),
                                      Text(
                                         _pastAppointmentList!.bookingList![index].service.toString(),
                                        style: GoogleFonts.poppins(
                                            textStyle: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: AppColor.greytext,
                                            )),
                                      ),

                                    ],
                                  ),
                                  // Image.asset(ProjectImage.phoneappointment,height: 40,)
                                  CachedNetworkImage(
                                    imageUrl: _pastAppointmentList!.bookingList![index].image.toString() ,
                                    //widget.image,
                                    fit: BoxFit.fill,
                                    width: 150,
                                    height: 300,
                                    placeholder: (context, url) =>
                                        LinearProgressIndicator(
                                          color: Colors.grey.withOpacity(0.2),
                                          backgroundColor:
                                          Colors.grey.withOpacity(.5),
                                        ),
                                    errorWidget: (context, url, error) =>
                                        Container(
                                          width: 150,
                                          height: 300,

                                          // padding: EdgeInsets.symmetric(vertical: 25.0),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(20),
                                              ),
                                              color: Color(0xFFD9D9D9)),
                                          child: Center(
                                            child: Icon(
                                              Icons.person,
                                              size: 80,
                                              color: AppColor.primaryColor,
                                            ),
                                            // child: Image.asset(ProjectImage.meditation_girl3,
                                            //   width: 150, height: 300,fit: BoxFit.cover,),
                                          ),
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),


                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 15.0,horizontal: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 2,
                                  offset: Offset(0, 1), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(S.of(context).ServiceComplete,
                                    style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          fontSize: 14, fontWeight: FontWeight.w400),
                                    )),
                                Container(
                                  height: 20,
                                  child: VerticalDivider(
                                    color: Colors.grey,
                                  ),
                                ),
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                      Helper.moveToScreenwithPush(context,
                                          RefundCompleteScreen());
                                        setState(() {
                                          _isSelect = true;
                                        });
                                      },
                                      child:_isSelect? Text(S.of(context).Refund,
                                        style: GoogleFonts.poppins(
                                            textStyle: TextStyle(
                                                fontSize: 14, fontWeight: FontWeight.w400,color: Colors.red),
                                          )):Text(S.of(context).Refund,
                                          style: GoogleFonts.poppins(
                                            textStyle: TextStyle(
                                                fontSize: 14, fontWeight: FontWeight.w400),
                                          )),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Image.asset(ProjectImage.refund,height: 20,)
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )

                      ],
                    ),
                  );
                }),
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


Future <void> pastAppointmentList() async{


  print("<=============pastAppointmentList===============>");

    SessionHelper sessionHelper = await SessionHelper.getInstance(context);
    String userId = sessionHelper.get(SessionHelper.USER_ID)??"0";

     Map data ={
       'user_id': userId,
     };

     try{

         var req = await http.post(Uri.parse(Apis.PastAppointmentList),body:data);
              print("api data***************************************${data}");
          if(req.statusCode == 200){

            try{

                final jsonResponce = jsonDecode(req.body);
                PastAppointmentList model = PastAppointmentList.fromJson(jsonResponce);

                  if(model.status == "true"){

                    print("Model status true${model}");

                     setState(() {

                       _pastAppointmentList = model;

                     });


                  }else{

                    print("false ### ============>");
                  }

            } catch (e){
              print("false ============>");
              // ToastMessage.msg(StaticMessages.API_ERROR);
              print('exception ==> ' + e.toString());
            }
          } else {
            print("status code ==> " + req.statusCode.toString());
            // ToastMessage.msg(StaticMessages.API_ERROR);
          }
     } catch (e) {
       // ToastMessage.msg(StaticMessages.API_ERROR);
       print('Exception ======> ' + e.toString());
     }
    //setProgress(false);
   // _hashData = false;
}

}

class OfferModel {
  String image = "";
  String name = "";

  OfferModel({required this.image, required this.name});
}
