import 'dart:convert';

import 'package:http/http.dart'as http;
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../helper/apis.dart';
import '../helper/constant.dart';
import '../helper/image.dart';
import '../model/get_shop_offer_model.dart';
import '../model/review_appointment_model.dart';

class OderDetails extends StatefulWidget {
  String shop_id="";
  String booking_id="";
   OderDetails({required this.booking_id,required this.shop_id});

  @override
  State<OderDetails> createState() => _OderDetailsState();
}

class _OderDetailsState extends State<OderDetails> {
  bool _isVisible = false;
  bool _hashData = false;
  ReviewAppointmentModel?_reviewAppointmentModel;
  GetShopOfferModel?_getShopOfferModel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Helper.checkInternet(getREVIEWappointmentApi());
    Helper.checkInternet(getshopofferApi());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight:80,
        titleSpacing: 0,
        backgroundColor: Color(0xFFFFFFFF),
        centerTitle: true,
        title: Text(
          "Order Details",
          style: GoogleFonts.poppins(textStyle: TextStyle(
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
      body: Stack(
        children: [
          _reviewAppointmentModel == null
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
              :
          SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListView.builder(
                        scrollDirection: Axis.vertical,
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        shrinkWrap: true,
                        itemCount: _reviewAppointmentModel!.servicesBooked!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return  Container(
                            margin: EdgeInsets.symmetric(horizontal: 0, vertical: 20),
                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              // border: Border.all(color: AppColor.secondaryColor, width: 2),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 2,
                                  offset: Offset(0, 1), // changes position of shadow
                                ),
                              ],
                              // color: AppColor.textfeildclr,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      // Container(
                                      //   height: 25,
                                      //   width: 25,
                                      //   decoration: BoxDecoration(
                                      //       borderRadius: BorderRadius.circular(5),
                                      //       border: Border.all(color: AppColor.green)),
                                      //   child: Icon(
                                      //     Icons.circle,
                                      //     color: AppColor.green,
                                      //     size: 12,
                                      //   ),
                                      // ),
                                      Text(
                                        _reviewAppointmentModel!.servicesBooked![index].toString(),
                                        style: GoogleFonts.poppins(
                                            textStyle: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black,
                                            )),
                                      ),
                                      // Container(
                                      //   width: 80,
                                      //   height: 30,
                                      //   decoration: BoxDecoration(
                                      //     borderRadius: BorderRadius.circular(10),
                                      //     color: Colors.white,
                                      //     boxShadow: [
                                      //       BoxShadow(
                                      //         color: Colors.grey.withOpacity(0.2),
                                      //         spreadRadius: 2,
                                      //         blurRadius: 2,
                                      //         offset:
                                      //         Offset(0, 1), // changes position of shadow
                                      //       ),
                                      //     ],
                                      //   ),
                                      //   child: Row(
                                      //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      //     children: [
                                      //       Text(
                                      //         "-",
                                      //         style: GoogleFonts.poppins(
                                      //             textStyle: TextStyle(
                                      //               fontSize: 16,
                                      //               fontWeight: FontWeight.w500,
                                      //               color: Colors.green,
                                      //             )),
                                      //       ),
                                      //       Text(
                                      //         "1",
                                      //         style: GoogleFonts.poppins(
                                      //             textStyle: TextStyle(
                                      //               fontSize: 16,
                                      //               fontWeight: FontWeight.w500,
                                      //               color: Colors.green,
                                      //             )),
                                      //       ),
                                      //       Text(
                                      //         "+",
                                      //         style: GoogleFonts.poppins(
                                      //             textStyle: TextStyle(
                                      //               fontSize: 16,
                                      //               fontWeight: FontWeight.w500,
                                      //               color: Colors.green,
                                      //             )),
                                      //       ),
                                      //     ],
                                      //   ),
                                      // ),
                                      Text( _reviewAppointmentModel!.price![index].toString(),
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black,
                                          )),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  DottedLine(
                                    direction: Axis.horizontal,
                                    lineLength: double.infinity,
                                    lineThickness: 1.0,
                                    dashLength: 4.0,
                                    dashColor: Colors.grey,
                                    dashRadius: 0.0,
                                    dashGapLength: 4.0,
                                    dashGapColor: Colors.transparent,
                                    dashGapRadius: 0.0,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Write instruction for restaurant",
                                        style: GoogleFonts.poppins(
                                            textStyle: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.grey,
                                            )),
                                      ),
                                      Icon(
                                        Icons.add_circle_outline_rounded,
                                        color: Colors.grey,
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        }),

                    // Container(
                    //   padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                    //   width: MediaQuery.of(context).size.width,
                    //   decoration: BoxDecoration(
                    //     color: Colors.white,
                    //     // border: Border.all(color: AppColor.secondaryColor, width: 2),
                    //     borderRadius: BorderRadius.circular(20),
                    //     boxShadow: [
                    //       BoxShadow(
                    //         color: Colors.grey.withOpacity(0.2),
                    //         spreadRadius: 2,
                    //         blurRadius: 2,
                    //         offset: Offset(0, 1), // changes position of shadow
                    //       ),
                    //     ],
                    //     // color: AppColor.textfeildclr,
                    //   ),
                    //   child: Padding(
                    //     padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    //     child: Column(
                    //       children: [
                    //         Row(
                    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //           children: [
                    //             // Container(
                    //             //   height: 25,
                    //             //   width: 25,
                    //             //   decoration: BoxDecoration(
                    //             //       borderRadius: BorderRadius.circular(5),
                    //             //       border: Border.all(color: AppColor.green)),
                    //             //   child: Icon(
                    //             //     Icons.circle,
                    //             //     color: AppColor.green,
                    //             //     size: 12,
                    //             //   ),
                    //             // ),
                    //             Text(
                    //               "Hair Cut",
                    //               style: GoogleFonts.poppins(
                    //                   textStyle: TextStyle(
                    //                     fontSize: 16,
                    //                     fontWeight: FontWeight.w500,
                    //                     color: Colors.black,
                    //                   )),
                    //             ),
                    //             // Container(
                    //             //   width: 80,
                    //             //   height: 30,
                    //             //   decoration: BoxDecoration(
                    //             //     borderRadius: BorderRadius.circular(10),
                    //             //     color: Colors.white,
                    //             //     boxShadow: [
                    //             //       BoxShadow(
                    //             //         color: Colors.grey.withOpacity(0.2),
                    //             //         spreadRadius: 2,
                    //             //         blurRadius: 2,
                    //             //         offset:
                    //             //         Offset(0, 1), // changes position of shadow
                    //             //       ),
                    //             //     ],
                    //             //   ),
                    //             //   child: Row(
                    //             //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //             //     children: [
                    //             //       Text(
                    //             //         "-",
                    //             //         style: GoogleFonts.poppins(
                    //             //             textStyle: TextStyle(
                    //             //               fontSize: 16,
                    //             //               fontWeight: FontWeight.w500,
                    //             //               color: Colors.green,
                    //             //             )),
                    //             //       ),
                    //             //       Text(
                    //             //         "1",
                    //             //         style: GoogleFonts.poppins(
                    //             //             textStyle: TextStyle(
                    //             //               fontSize: 16,
                    //             //               fontWeight: FontWeight.w500,
                    //             //               color: Colors.green,
                    //             //             )),
                    //             //       ),
                    //             //       Text(
                    //             //         "+",
                    //             //         style: GoogleFonts.poppins(
                    //             //             textStyle: TextStyle(
                    //             //               fontSize: 16,
                    //             //               fontWeight: FontWeight.w500,
                    //             //               color: Colors.green,
                    //             //             )),
                    //             //       ),
                    //             //     ],
                    //             //   ),
                    //             // ),
                    //             Text("₹ 277",
                    //                 style: TextStyle(
                    //                   fontSize: 16,
                    //                   fontWeight: FontWeight.w500,
                    //                   color: Colors.black,
                    //                 )),
                    //           ],
                    //         ),
                    //         SizedBox(
                    //           height: 20,
                    //         ),
                    //         DottedLine(
                    //           direction: Axis.horizontal,
                    //           lineLength: double.infinity,
                    //           lineThickness: 1.0,
                    //           dashLength: 4.0,
                    //           dashColor: Colors.grey,
                    //           dashRadius: 0.0,
                    //           dashGapLength: 4.0,
                    //           dashGapColor: Colors.transparent,
                    //           dashGapRadius: 0.0,
                    //         ),
                    //         SizedBox(
                    //           height: 20,
                    //         ),
                    //         Row(
                    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //           children: [
                    //             Text(
                    //               "Write instruction for restaurant",
                    //               style: GoogleFonts.poppins(
                    //                   textStyle: TextStyle(
                    //                     fontSize: 14,
                    //                     fontWeight: FontWeight.w400,
                    //                     color: Colors.grey,
                    //                   )),
                    //             ),
                    //             Icon(
                    //               Icons.add_circle_outline_rounded,
                    //               color: Colors.grey,
                    //             )
                    //           ],
                    //         )
                    //       ],
                    //     ),
                    //   ),
                    // ),

                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Offers & Benefits",
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      )),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    _getShopOfferModel==null?Container(): ListView.builder(
                        scrollDirection: Axis.vertical,
                        // physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        shrinkWrap: true,
                        itemCount: _getShopOfferModel!.offerList!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return  Container(
                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              // border: Border.all(color: AppColor.secondaryColor, width: 2),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 2,
                                  offset: Offset(0, 1), // changes position of shadow
                                ),
                              ],
                              // color: AppColor.textfeildclr,
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                        height: 30,
                                        width: 30,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5),
                                            border: Border.all(color: AppColor.green)),
                                        child: Image.asset(ProjectImage.discount)
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          _getShopOfferModel!.offerList![index].offer.toString(),
                                          style: GoogleFonts.poppins(
                                              textStyle: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black,
                                              )),
                                        ),
                                        Text(
                                          _getShopOfferModel!.offerList![index].description.toString(),
                                          style: GoogleFonts.poppins(
                                              textStyle: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.grey,
                                              )),
                                        ),
                                      ],
                                    ),

                                    Text("Apply",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                        )),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                DottedLine(
                                  direction: Axis.horizontal,
                                  lineLength: double.infinity,
                                  lineThickness: 1.0,
                                  dashLength: 4.0,
                                  dashColor: Colors.grey,
                                  dashRadius: 0.0,
                                  dashGapLength: 4.0,
                                  dashGapColor: Colors.transparent,
                                  dashGapRadius: 0.0,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "View more coupons",
                                      style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.grey,
                                          )),
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      color: Colors.grey,size: 16,
                                    )
                                  ],
                                )
                              ],
                            ),
                          );
                        }),

                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Bill Details",
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      )),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        // border: Border.all(color: AppColor.secondaryColor, width: 2),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 2,
                            offset: Offset(0, 1), // changes position of shadow
                          ),
                        ],
                        // color: AppColor.textfeildclr,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                            Text(
                              "Item Total",
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey,
                              )),
                            ),
                            Text("₹ 500",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey,
                                )),
                          ]),
                          SizedBox(
                            height: 10,
                          ),
                          DottedLine(
                            direction: Axis.horizontal,
                            lineLength: double.infinity,
                            lineThickness: 1.0,
                            dashLength: 4.0,
                            dashColor: Colors.grey,
                            dashRadius: 0.0,
                            dashGapLength: 4.0,
                            dashGapColor: Colors.transparent,
                            dashGapRadius: 0.0,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Discount",
                                  style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey,
                                      )),
                                ),
                                Text("₹ 500",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey,
                                    )),
                              ]),
                          SizedBox(
                            height: 10,
                          ),
                          DottedLine(
                            direction: Axis.horizontal,
                            lineLength: double.infinity,
                            lineThickness: 1.0,
                            dashLength: 4.0,
                            dashColor: Colors.grey,
                            dashRadius: 0.0,
                            dashGapLength: 4.0,
                            dashGapColor: Colors.transparent,
                            dashGapRadius: 0.0,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Text(
                                    "Govt Taxes & Restaurant charges",
                                    style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.grey,
                                        )),
                                  ),
                                ),
                                Text("₹ 500",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey,
                                    )),
                              ]),
                          SizedBox(
                            height: 10,
                          ),
                          DottedLine(
                            direction: Axis.horizontal,
                            lineLength: double.infinity,
                            lineThickness: 1.0,
                            dashLength: 4.0,
                            dashColor: Colors.grey,
                            dashRadius: 0.0,
                            dashGapLength: 4.0,
                            dashGapColor: Colors.transparent,
                            dashGapRadius: 0.0,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Text(
                                    "To pay",
                                    style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey,
                                        )),
                                  ),
                                ),
                                Text("₹ 500",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey,
                                    )),
                              ]),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child:  Container(
              height: 180,
            width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                // border: Border.all(color: AppColor.secondaryColor, width: 2),
                borderRadius: BorderRadius.only(topLeft:Radius.circular(20),topRight:Radius.circular(20) ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 2,
                    offset: Offset(0, 1), // changes position of shadow
                  ),
                ],
                // color: AppColor.textfeildclr,
              ),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 30,vertical: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(ProjectImage.sendnew,height: 25,),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "you are in a new location!",
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              )),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Select Address",
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: AppColor.primaryColor,
                              )),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        MaterialButton(
                            color: AppColor.primaryColor,
                           padding: EdgeInsets.symmetric(horizontal: 20,vertical: 15),
                            textColor: Colors.white,
                            child: Text("Add Address",
                                style: GoogleFonts.quicksand(
                                  textStyle: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                )),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            onPressed: () {

                            }),
                      ],
                    )
                  ],
                ),
              ),
          ),)
        ],
      ),
    );
  }


  Future<void> getREVIEWappointmentApi() async {

    print("<==============getREVIEWappointmentApi==================>");

    _hashData = true;
    setProgress(true);

    SessionHelper session = await SessionHelper.getInstance(context);
    String userId = session.get(SessionHelper.USER_ID) ?? "0";


    Map data = {
      'user_id': userId,
      'booking_id':"163"
    };

    print("Request =============>" + data.toString());
    try {
      var res = await http.post(Uri.parse(Apis.reviewAppointment), body: data);
      print("Response ============>" + res.body);

      if (res.statusCode == 200) {
        try {
          final jsonResponse = jsonDecode(res.body);
          ReviewAppointmentModel model = ReviewAppointmentModel.fromJson(jsonResponse);

          if (model.status == "true") {
            _hashData = false;

            setState(() {
              _reviewAppointmentModel = model;
              // nameController.text =_getprofileModel!.data!.name.toString() ;
              // phoneController.text =_getprofileModel!.data!.phone.toString() ;
              // emailController.text =_getprofileModel!.data!.email.toString() ;

              // showDate =dob ;
              // img =_profileModel!.userData![0].image![0].toString();

            });

            print("Model status true");
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

  Future<void> bookingconfirmedApi() async {

    print("<==============bookingconfirmedApi==================>");

    _hashData = true;
    setProgress(true);

    SessionHelper session = await SessionHelper.getInstance(context);
    String userId = session.get(SessionHelper.USER_ID) ?? "0";


    Map data = {
      'user_id': userId,
      'booking_id':"163"
    };

    print("Request =============>" + data.toString());
    try {
      var res = await http.post(Uri.parse(Apis.reviewAppointment), body: data);
      print("Response ============>" + res.body);

      if (res.statusCode == 200) {
        try {
          final jsonResponse = jsonDecode(res.body);
          ReviewAppointmentModel model = ReviewAppointmentModel.fromJson(jsonResponse);

          if (model.status == "true") {
            _hashData = false;

            setState(() {
              _reviewAppointmentModel = model;
              // nameController.text =_getprofileModel!.data!.name.toString() ;
              // phoneController.text =_getprofileModel!.data!.phone.toString() ;
              // emailController.text =_getprofileModel!.data!.email.toString() ;

              // showDate =dob ;
              // img =_profileModel!.userData![0].image![0].toString();

            });

            print("Model status true");
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

  Future<void> getshopofferApi() async {

    print("<==============getshopofferApi==================>");

    _hashData = true;
    setProgress(true);

    SessionHelper session = await SessionHelper.getInstance(context);
    String userId = session.get(SessionHelper.USER_ID) ?? "0";


    Map data = {
      'user_id': userId,
      'shop_id':widget.shop_id
    };

    print("Request =============>" + data.toString());
    try {
      var res = await http.post(Uri.parse(Apis.getShopOffers), body: data);
      print("Response ============>" + res.body);

      if (res.statusCode == 200) {
        try {
          final jsonResponse = jsonDecode(res.body);
          GetShopOfferModel model = GetShopOfferModel.fromJson(jsonResponse);

          if (model.status == "true") {
            _hashData = false;

            setState(() {
              _getShopOfferModel = model;
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
