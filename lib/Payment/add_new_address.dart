import 'dart:convert';

import 'package:dotted_line/dotted_line.dart';
import 'package:fdottedline_nullsafety/fdottedline__nullsafety.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:serviceapplatest/helper/constant.dart';
import '../bottom_screens/bottom.dart';
import '../helper/apis.dart';
import '../helper/image.dart';
import '../model/add_booking_address_model.dart';
import '../model/get_address_model.dart';
import '../setting/add_address_screen.dart';
import 'addnewcard.dart';
import 'all_card.dart';



class AddNewAddress extends StatefulWidget {
  String booking_id = "";
  String totalAmount = "";

  AddNewAddress({required this.booking_id,required this.totalAmount});

  @override
  State<AddNewAddress> createState() => _AddNewAddressState();
}

class _AddNewAddressState extends State<AddNewAddress> {



  bool _hashData = false;
  bool _isVisible = false;

  GetAddressModel? _getaddressmodel;
  AddBookingAddressModel?_addBookingAddressModel;

  String id="";
  String _isSelect="";

  String _selectPlace = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  Helper.checkInternet(getaddressApi());
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //App Bar.......................................
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 100,
        titleSpacing: 0,
        backgroundColor: Color(0xFFf5f5f5),
        centerTitle: true,
        title: Text(
          "Add address",
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
          _getaddressmodel == null
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
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       Icon(
                  //         Icons.close,
                  //         color: Colors.transparent,
                  //       ),
                  //       InkWell(
                  //           onTap: () {
                  //             Helper.popScreen(context);
                  //           },
                  //           child: Icon(
                  //             Icons.close,
                  //             color: Colors.black,
                  //           )),
                  //     ],
                  //   ),
                  // ),
                   Container(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: _getaddressmodel!.addressList!.length,
                        itemBuilder: (BuildContext context, int index) {
                           id = _getaddressmodel!.addressList![index].id.toString();
                           print("booking---------------${id}");
                          return InkWell(
                            onTap: () {
                             setState(() {
                               _isSelect=index.toString();
                             });
                               Helper.checkInternet(addBookingAddressApi(_getaddressmodel!.addressList![index].flatNumber.toString()));
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: Container(
                                  // margin: EdgeInsets.symmetric(horizontal: 15),
                                padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    color: _isSelect == index.toString()
                                        ?  Color(0xFF0ABDFC)
                                        : Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 7,
                                        offset: Offset(3, 5),
                                      ),
                                    ],
                                  ),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            _getaddressmodel!.addressList![index].type ==
                                                "Home"
                                                ? Image.asset(
                                                ProjectImage.home,
                                              color: _isSelect == index.toString()
                                                  ?  Colors.white
                                                  : Colors.black,
                                            )
                                                : Image.asset(
                                                ProjectImage.navigation,
                                              color: _isSelect == index.toString()
                                                  ?  Colors.white
                                                  : Colors.black,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Container(
                                              width: 200,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    _getaddressmodel!.addressList![index].type.toString(),
                                                    style: GoogleFonts.poppins(
                                                        textStyle:
                                                        TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                          FontWeight.w500,
                                                          color: _isSelect == index.toString()
                                                              ?  Colors.white
                                                              : Colors.black,
                                                        )),
                                                  ),
                                                  Text(
                                                    _getaddressmodel!.addressList![index].flatNumber.toString(),
                                                    style: GoogleFonts.poppins(
                                                      textStyle: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                        FontWeight.w400,
                                                        color: _isSelect == index.toString()
                                                            ?  Colors.white
                                                            : Colors.black,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Icon(Icons.arrow_forward_ios,
                                              color: _isSelect == index.toString()
                                                  ?  Colors.white
                                                  : Colors.black,
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        // Divider(
                                        //   color: Colors.grey,
                                        //   height: 2,
                                        //   thickness: 1,
                                        //   indent: 0,
                                        //   endIndent: 15,
                                        // ),
                                        // SizedBox(
                                        //   height: 20,
                                        // ),
                                      ],
                                    ),
                                  )),
                            ),
                          );
                        }),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Helper.moveToScreenwithPush(
                                context, AddAddressScreen());
                          },
                          child: Row(
                            children: [
                              Image.asset(ProjectImage.newAddress,
                                  color: Colors.blue),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                child: Text(
                                  "Add New Address",
                                  style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      )),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(Icons.arrow_forward_ios)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(child: Helper.getProgressBarWhite(context, _isVisible))
        ],
      ),
    );
  }
  _bottomSheetHomeAddress(context,String selectAddress,String amount) {
    showModalBottomSheet<void>(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
        ),
        context: context,
        elevation: 0,
        isScrollControlled: true,
        // backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Container(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text("Service deliver to",
                                    style: GoogleFonts.poppins(
                                        color: Color(0xFF1D1D1D),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18),),
                                  Container(
                                    width: 10,
                                    height: 20,
                                    child: VerticalDivider(
                                      color: Colors.black,
                                      thickness: 2,
                                    ),
                                  ),
                                  Text("40 MINS",
                                      style: GoogleFonts.poppins(
                                          color: Color(0xFF1D1D1D),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18)
                                  ),
                                ],
                              ),
                              Container(
                                width: 250,
                                child: Text(selectAddress,
                                  style: GoogleFonts.poppins(
                                      color: Color(0xFF555555),
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14),maxLines: 1,
                                ),
                              )
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: Color(0xFFD1D1D1),
                                    width: 1
                                )
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.home,
                                  color: Colors.black,size: 25,),
                                Icon(Icons.keyboard_arrow_down_rounded,
                                  color: Colors.black,size: 25,),

                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 20,),
                      FDottedLine(
                        color: Color(0xFF777777),
                        width: MediaQuery.of(context).size.width,
                        strokeWidth: 1.0,
                        dottedLength: 5.0,
                        space: 5.0,
                      ),
                      SizedBox(height: 30,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                // mainAxisAlignment: MainAxisAlignment.start,
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset(ProjectImage.rupeeSimbol, height: 15),
                                  Text(
                                    amount,
                                    style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                        )),
                                  ),
                                ],
                              ),
                              Text(
                                "View Detailed Bill",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                    color: Color(0xFF1BA571)),
                              )
                            ],
                          ),
                          MaterialButton(
                            color: Color(0xFF0ABDFC),
                            minWidth: 100,
                            height: 50,
                            textColor: Colors.white,
                            child: Text("Proceed to pay",
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  )),
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            onPressed: () {
                              _bottomSheetFilter(context,amount);

                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              });
        });
  }

  _bottomSheetFilter(context, String amount) {
    showModalBottomSheet<void>(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        context: context,
        elevation: 0,
        isScrollControlled: true,
        // backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.70,
                  padding: EdgeInsets.all(10),
                  child: Builder(
                    builder: (context) {
                      final double height = MediaQuery.of(context).size.height;
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 120,
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        //Payment Method.......................................
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                                alignment: Alignment.topRight,
                                child: InkWell(
                                  onTap: (){
                                    Helper.popScreen(context);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(05),
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey,
                                            blurRadius: 7,
                                            offset: Offset(3, 5),
                                          ),
                                        ],
                                        borderRadius: BorderRadius.all(Radius.circular(20),),
                                        color: Colors.white),
                                    child: Icon(Icons.clear,
                                      size: 20,
                                      color: Colors.black,),
                                  ),
                                )),
                            Text(
                              "Payment method",
                              style: GoogleFonts.poppins(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            //Divider............................................
                            Divider(
                              color: Color(0xFFb8b8b8),
                              height: 5,
                              thickness: 1,
                              indent: 0,
                              endIndent: 15,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            //Google
                            InkWell(
                              onTap: () {
                                setState(() {
                                  _selectPlace = "Google Pay";
                                });
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                        ProjectImage.google,
                                        width: 30,
                                      ),
                                      SizedBox(
                                        width: 30,
                                      ),
                                      Text(
                                        "Google Pay",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                  _selectPlace == "Google Pay"
                                      ?
                                  Image.asset(ProjectImage.checklist,
                                    height: 30,width: 30,
                                  )
                                      :
                                  Icon(Icons.radio_button_checked_rounded,
                                      color: Color(0xFFD9D9D9),
                                      size: 25)
                                  // Icon(Icons.radio_button_off,
                                  //     size: 18, color: AppColor.primaryColor),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  _selectPlace = "Phone Pay";
                                });
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                        ProjectImage.phonepay,
                                        width: 30,
                                      ),
                                      SizedBox(
                                        width: 30,
                                      ),
                                      Text(
                                        "Phone Pay",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(
                                        width: 82,
                                      ),

                                      // SizedBox(
                                      //   width: 10,
                                      // ),
                                    ],
                                  ),
                                  _selectPlace == "Phone Pay"?
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
                            SizedBox(
                              height: 20,
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  _selectPlace = "Paytm";
                                });
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Image.asset(
                                        ProjectImage.paytem,
                                        width: 30,
                                      ),
                                      SizedBox(
                                        width: 30,
                                      ),
                                      Text(
                                        "Paytm",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(
                                        width: 82,
                                      ),

                                      // SizedBox(
                                      //   width: 10,
                                      // ),
                                    ],
                                  ),
                                  _selectPlace == "Paytm"
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
                            SizedBox(
                              height: 20,
                            ),
                            InkWell(
                              onTap: (){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AddNewCard()));
                              },
                              child: Container(
                                // height: 80,
                                padding: const EdgeInsets.all(16.0),
                                decoration: BoxDecoration(
                                  color: Color(0xFFffffff),
                                  borderRadius: BorderRadius.all(Radius.circular(15)),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Color(0xFFe2e2e2),
                                        blurRadius: 15.0,
                                        spreadRadius: 5.0,
                                        offset: Offset(
                                          1.0,
                                          1.0,
                                        ))
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      ProjectImage.pluse,
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Add debit / card card",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 15),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "Save and Pay Via Card",
                                          style: TextStyle(
                                              color: Color(0xFF1D1D1D),
                                              fontWeight: FontWeight.w400,
                                              fontSize: 10),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Save Card",
                                  style: GoogleFonts.poppins(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),
                                ),
                                InkWell(
                                  onTap: (){
                                    Helper.moveToScreenwithPush(context, AllCards(
                                      total: amount,
                                    ));
                                  },
                                  child: Text(
                                    "View All",
                                    style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
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
                                    Text("3198",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xFF737b82))),
                                  ],
                                ),
                                Image.asset(ProjectImage.select, height: 30),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            MaterialButton(
                              color: Color(0xFF0ABDFC),
                              minWidth: 310,
                              height: 50,
                              textColor: Colors.white,
                              child: Text("Confirm",
                                  style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        fontSize: 20, fontWeight: FontWeight.w500),
                                  )),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              onPressed: () {
                                // Helper.popScreen(context);
                                showAlertDialog(context,amount);
                                // Navigator.push(
                                //               context,
                                //               MaterialPageRoute(
                                //                   builder: (context) => AddNewCard()));

                              },
                            ),
                            // SizedBox(
                            //   // width: 200,
                            //   // height: 50,
                            //   child: ElevatedButton(
                            //     style: ElevatedButton.styleFrom(
                            //       fixedSize: const Size(150, 70),
                            //       shape: RoundedRectangleBorder(
                            //           //to set border radius to button
                            //           borderRadius: BorderRadius.circular(25)),
                            //       // NEW
                            //     ),
                            //     onPressed: () {
                            //       Navigator.push(
                            //           context,
                            //           MaterialPageRoute(
                            //               builder: (context) => ExpertProfile()));
                            //     },
                            //     child: const Text(
                            //       'Submit',
                            //       style: TextStyle(fontSize: 24),
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              });
        });
  }

  showAlertDialog(BuildContext context,String amount) {

    // set up the AlertDialog


    AlertDialog alert = AlertDialog(
      scrollable: false,
      insetPadding: EdgeInsets.symmetric(horizontal: 0),
      backgroundColor: Colors.transparent,
      elevation: 0,
      content:  Container(
          padding: EdgeInsets.symmetric(horizontal:  30,vertical: 30),
          margin: EdgeInsets.only(top: 50),
          height: 400,
          width: 380,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.white),
          child:
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Image.asset(ProjectImage.checklist,height: 100,color: Color(0xFF1ba571)),
              Text("Payment Successful",style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF1ba571),
                  )),),
              Text("Transaction number : 149538292331",
                style: GoogleFonts.poppins(
                    color: Color(0xFF8C8C8C),
                    fontWeight: FontWeight.w400,
                    fontSize: 12
                ),
              ),
              SizedBox(height: 10,),
              DottedLine(
                direction: Axis.horizontal,
                lineLength: double.infinity,
                lineThickness: 1.0,
                dashLength: 4.0,
                dashColor: Color(0xFFdedede),
                dashGapLength: 2.0,
                dashGapColor: Colors.transparent,
                dashGapRadius: 4.0,
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Amount Paid",style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF8C8C8C),
                      )),),
                  Text(amount,
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF8C8C8C),
                        )),),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Bank",style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF8C8C8C),
                      )),),
                  Text("SBI",style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF8C8C8C),
                      )),),
                ],
              ),
              SizedBox(height: 25,),
              MaterialButton(
                color: Colors.white,
                minWidth: 200,
                height: 45,
                textColor: Colors.white,
                elevation: 20,
                child: Text("Ok",
                  style: GoogleFonts.poppins(
                      color:Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 17
                  ),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                onPressed: () {
                  print("tap--------------------->");
                  Helper.moveToScreenwithPushreplaceemt(
                      context, Bottom());

                },
              )
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


  setProgress(bool show) {
    if (mounted)
      setState(() {
        _isVisible = show;
      });
  }

  Future<void> getaddressApi() async {
    print("<=============getaddressApi =============>");

    SessionHelper sessionHelper = await SessionHelper.getInstance(context);
    String userId = sessionHelper.get(SessionHelper.USER_ID) ?? "0";

    print("<========getaddressApi=====userId =============>" + userId);
    _hashData = true;
    setProgress(true);

    Map data = {
      'user_id': userId,
    };

    print("Request ====getaddressApi=========>" + data.toString());
    try {
      var res = await http.post(Uri.parse(Apis.getSavedAddress), body: data);
      print("Response ======getaddressApi======>" + res.body);

      if (res.statusCode == 200) {

        try {
          final jsonResponse = jsonDecode(res.body);
          GetAddressModel model = GetAddressModel.fromJson(jsonResponse);

          if (model.status == "true") {
            print("Model status true");

            setProgress(false);
            _hashData = false;

            setState(() {
              _getaddressmodel = model;
              // nameController.text = _getprofileModel!.data!.name.toString();
              // phoneController.text = _getprofileModel!.data!.phone.toString();
              // emailController.text = _getprofileModel!.data!.email.toString();
              // img= _getprofileModel!.data!.image.toString();
              // print("===================image =========== ${img.toString()}");
              // select=_getprofileModel!.data!.gender.toString();
            });

            // ToastMessage.msg(model.message.toString());
          } else {
            setProgress(false);
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
    setProgress(false);
    _hashData = false;
  }



  Future<void> addBookingAddressApi(String selectAddress) async {

    print("<==============addBookingAddressApi==================>");

    _hashData = true;
    setProgress(true);

    SessionHelper session = await SessionHelper.getInstance(context);
    String userId = session.get(SessionHelper.USER_ID) ?? "0";


    Map data = {
      'user_id': userId,
      'booking_id':widget.booking_id,
      'location':"Home",
      'address':selectAddress,
    };

    print("Request ====================>" + data.toString());
    try {
      var res = await http.post(Uri.parse(Apis.addBookingAddress), body: data);
      print("Response==================>" + res.body);

      if (res.statusCode == 200) {
        try {
          final jsonResponse = jsonDecode(res.body);
          AddBookingAddressModel model = AddBookingAddressModel.fromJson(jsonResponse);

          print("Response========================>" + res.body);

          if (model.status == "true") {

            _hashData = false;


            setState(() {
              _addBookingAddressModel = model;

              print("amount======================${_addBookingAddressModel!.data!.amount!.toString()}");
              _bottomSheetHomeAddress(context, selectAddress,_addBookingAddressModel!.data!.amount!.toString());


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

}
