import 'package:fdottedline_nullsafety/fdottedline__nullsafety.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:serviceapplatest/setting/refund.dart';

import '../helper/constant.dart';
import '../helper/image.dart';




class RefundSuccessful extends StatefulWidget {
  const RefundSuccessful({Key? key}) : super(key: key);

  @override
  State<RefundSuccessful> createState() => _RefundSuccessfulState();
}

class _RefundSuccessfulState extends State<RefundSuccessful> {

  bool checktwo = false;
  bool check = false;

  final List<OfferModel> _offermodel = [
    OfferModel(image: ProjectImage.comb, name: "Lemongrass Salon",cut: "Hair cut",rs: "₹277",deleteImg: ProjectImage.delete,
        req: "Request for refund"),
    // OfferModel(image: ProjectImage.comb, name: "Lemongrass Salon",cut: "Hair cut",rs: "₹277",deleteImg: ProjectImage.delete,
    //     req: "Request for refund"),

  ];


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
        actions: [
          // Padding(
          //   padding: const EdgeInsets.only(right: 20),
          //   child: InkWell(
          //       onTap: () {
          //         Helper.moveToScreenwithPush(context, EditProfile());
          //       },
          //       child: Image.asset(ProjectImage.editprofile,height: 40,width: 40,)),
          // ),
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: (){
                  setState(() {
                    checktwo = true;
                    check = true;
                  });
                },
                child: Container(
                    width: 95,
                    height: 30,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        border: Border.all(color: AppColor.primaryColor),
                        borderRadius: BorderRadius.circular(5)
                    ),
                    child: Text("select all",
                      style: GoogleFonts.poppins(
                        color:AppColor.primaryColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 15,),
                    )
                ),
              ),
            ),
            Text(
              "Today",
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: AppColor.primaryColor,
                  )),
            ),
            ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: _offermodel.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 0),
                          margin: EdgeInsets.symmetric(vertical: 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    if (checktwo == true) {
                                      checktwo = false;

                                    } else {
                                      checktwo = true;
                                    }
                                  });
                                },
                                child: Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(2),
                                      color: Colors.transparent),
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        bottom: 0,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(2),
                                            color: Color(0xFFd9d9d9),
                                          ),
                                          height: 25,
                                          width: 25,
                                        ),
                                      ),
                                      checktwo == true
                                          ? Positioned(
                                          bottom: 0,
                                          right: 8,
                                          left: 5,
                                          child: Image.asset(
                                            ProjectImage.check,
                                            height: 20,
                                            width: 20,
                                          ))
                                          : SizedBox()
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 280,
                          margin: EdgeInsets.symmetric(vertical: 10),
                          // padding:const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                          decoration:const BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                            color: Color(0xFFFFFFFF),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 7,
                                offset: Offset(3, 5),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:const EdgeInsets.symmetric(vertical: 15,horizontal: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.asset(_offermodel[index].image,
                                      height: 25,width: 25,),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          _offermodel[index].name,
                                          style: GoogleFonts.poppins(
                                              textStyle: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w600,
                                                color: Color(0xFF222222),
                                              )),
                                        ),
                                        Text(
                                          _offermodel[index].cut,
                                          style: GoogleFonts.poppins(
                                              textStyle: TextStyle(
                                                fontSize: 11,
                                                fontWeight: FontWeight.w600,
                                                color: Color(0xFF727679),
                                              )),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          _offermodel[index].rs,
                                          style: GoogleFonts.poppins(
                                              textStyle: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color: AppColor.primaryColor,
                                              )),
                                        ),
                                        SizedBox(width: 20,),
                                        Image.asset(_offermodel[index].deleteImg,height: 20,width: 20,),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(height: 10,),
                              FDottedLine(
                                color: Color(0xFF777777),
                                width: MediaQuery.of(context).size.width,
                                strokeWidth: 1.0,
                                dottedLength: 5.0,
                                space: 5.0,
                              ),
                              SizedBox(height: 10,),
                              Padding(
                                padding:const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    _offermodel[index].req,
                                    style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFFF14656),
                                        )),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                      ],
                    );
                }),
            Text(
              "Yesterday",
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: AppColor.primaryColor,
                  )),
            ),
            ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: _offermodel.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 0),
                          margin: EdgeInsets.symmetric(vertical: 0),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                if (check == true) {
                                  check = false;

                                } else {
                                  check = true;
                                }
                              });
                            },
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2),
                                  color: Colors.transparent),
                              child: Stack(
                                children: [
                                  Positioned(
                                    bottom: 0,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(2),
                                        color: Color(0xFFd9d9d9),
                                      ),
                                      height: 25,
                                      width: 25,
                                    ),
                                  ),
                                  check == true
                                      ? Positioned(
                                      bottom: 0,
                                      right: 8,
                                      left: 5,
                                      child: Image.asset(
                                        ProjectImage.check,
                                        height: 20,
                                        width: 20,
                                      ))
                                      : SizedBox()
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 280,
                          margin: EdgeInsets.symmetric(vertical: 10),
                          // padding:const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                          decoration:const BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                            color: Color(0xFFFFFFFF),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 7,
                                offset: Offset(3, 5),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:const EdgeInsets.symmetric(vertical: 15,horizontal: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.asset(_offermodel[index].image,
                                      height: 25,width: 25,),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          _offermodel[index].name,
                                          style: GoogleFonts.poppins(
                                              textStyle: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w600,
                                                color: Color(0xFF222222),
                                              )),
                                        ),
                                        Text(
                                          _offermodel[index].cut,
                                          style: GoogleFonts.poppins(
                                              textStyle: TextStyle(
                                                fontSize: 11,
                                                fontWeight: FontWeight.w600,
                                                color: Color(0xFF727679),
                                              )),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          _offermodel[index].rs,
                                          style: GoogleFonts.poppins(
                                              textStyle: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color: AppColor.primaryColor,
                                              )),
                                        ),
                                        SizedBox(width: 20,),
                                        Image.asset(_offermodel[index].deleteImg,height: 20,width: 20,),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(height: 10,),
                              FDottedLine(
                                color: Color(0xFF777777),
                                width: MediaQuery.of(context).size.width,
                                strokeWidth: 1.0,
                                dottedLength: 5.0,
                                space: 5.0,
                              ),
                              SizedBox(height: 10,),
                              Padding(
                                padding:const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    _offermodel[index].req,
                                    style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFFF14656),
                                        )),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                      ],
                    );
                }),
              SizedBox(height: 30,),
            Container(
              padding: EdgeInsets.symmetric(vertical: 44),
              child: Center(
                child: MaterialButton(
                  minWidth: 350,
                  color: Color(0xFF0ABDFC),
                  // padding: EdgeInsets.symmetric(horizontal: 100),
                  height: 50,
                  textColor: Colors.white,
                  child: Text("Delete all",
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      )),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  onPressed: () {
                    Helper.moveToScreenwithPushreplaceemt(context,
                        Refund(booking_id: "",));
                  },
                ),
              ),
            ),




          ],
        )
      ),
    );
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


