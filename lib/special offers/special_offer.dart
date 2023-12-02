

import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:serviceapplatest/model/home_model.dart';
import 'package:serviceapplatest/special%20offers/skin_care.dart';
import 'package:http/http.dart'as http;
import '../helper/apis.dart';
import '../helper/constant.dart';
import '../helper/image.dart';
import '../model/get_offer_model.dart';
import '../model/get_shop_detail_model.dart';
import '../top salons/top_salon.dart';
import 'hair_salon.dart';
import 'nail_salon.dart';

class SpecialofferScreen extends StatefulWidget {
  String service="";
   SpecialofferScreen({required this.service});


  @override
  State<SpecialofferScreen> createState() => _SpecialofferScreenState();
}

class _SpecialofferScreenState extends State<SpecialofferScreen>{
  bool _isVisible = false;
  bool _hashData = false;
  GetOfferModel?_getOfferModel;

  late TabController _tabController;
  Getshopdetailmodel?_getshopdetailmodel;

  final List<TopSalonModel> _topsalonlist = [
    TopSalonModel(image: ProjectImage.nailsalon, name: "Hair Salon"),
    TopSalonModel(image: ProjectImage.nailsalon, name: "Nail Salon"),
    TopSalonModel(image: ProjectImage.nailsalon, name: "Skin care"),
    TopSalonModel(image: ProjectImage.nailsalon, name: "Skin care"),
    TopSalonModel(image: ProjectImage.nailsalon, name: "Skin care"),
  ];
  String shopId="";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Helper.checkInternet(getofferApi());
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
          "Salon",
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
      body:  Stack(
        children: [
          _getOfferModel == null
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
            width: MediaQuery.of(context).size.width ,
            padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: 300,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Special Offers",
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: AppColor.primaryColor,
                              )),
                        ),
                        Icon(Icons.arrow_forward)
                      ],
                    ),
                  ),
                  SizedBox(height: 20,),
                  // Container(
                  //   width: MediaQuery.of(context).size.width,
                  //   height: 180,
                  //   child: ListView.builder(
                  //       scrollDirection: Axis.horizontal,
                  //       itemCount: _getOfferModel!.shopList!.length,
                  //       itemBuilder: (BuildContext context, int index) {
                  //         return Container(
                  //           // height: 100,
                  //           margin: EdgeInsets.symmetric(horizontal: 10),
                  //           child: Column(
                  //             children: [
                  //               InkWell(
                  //                 onTap: (){
                  //                   Helper.moveToScreenwithPush(context, TopSalon(
                  //                     image: "",
                  //                     listOfSelectedService: [],
                  //                   price: "",
                  //                   salonname: "",
                  //                   service: "",
                  //                   shop_id: "",
                  //                   ));
                  //                 },
                  //                 child: Container(
                  //                   height: 160,
                  //                   width: 300,
                  //                   decoration: BoxDecoration(
                  //                       boxShadow: [
                  //                         BoxShadow(
                  //                             color: Colors.grey.withOpacity(1),
                  //                             blurRadius: 3,
                  //                             offset: Offset(0, 3))
                  //                       ],
                  //                       color: Colors.white,
                  //                       borderRadius: BorderRadius.circular(10)
                  //                   ),
                  //                   child: ClipRRect(
                  //                       borderRadius: BorderRadius.circular(10),
                  //                       child:CachedNetworkImage(
                  //                         imageUrl:
                  //                         _getOfferModel!.shopList![index].image!.isEmpty
                  //                             ? ""
                  //                             :   _getOfferModel!.shopList![index].image!
                  //                             .toString(),
                  //                         fit: BoxFit.fill,
                  //                         height: 160,
                  //                         width: 300,
                  //                         placeholder: (context, url) =>
                  //                             LinearProgressIndicator(
                  //                               color: Colors.white.withOpacity(0.2),
                  //                               backgroundColor:
                  //                               Colors.white.withOpacity(.5),
                  //                             ),
                  //                         errorWidget: (context, url, error) =>
                  //                             ClipRRect(
                  //                               borderRadius: BorderRadius.circular(10),
                  //                               child: Container(
                  //                                 height: 160,
                  //                                 width: 300,
                  //                                 decoration: BoxDecoration(
                  //                                     boxShadow: [
                  //                                       BoxShadow(
                  //                                           color: Colors.grey.withOpacity(1),
                  //                                           blurRadius: 3,
                  //                                           offset: Offset(0, 3))
                  //                                     ],
                  //                                     color: Colors.white,
                  //                                     borderRadius: BorderRadius.circular(20)
                  //                                 ),
                  //                                 child:Icon(Icons.error_outline_sharp),
                  //                               ),
                  //                             ),
                  //                       )
                  //                   ),
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //         );
                  //       }),
                  // ),
                  // ListView.builder(
                  //     scrollDirection: Axis.vertical,
                  //     physics: NeverScrollableScrollPhysics(),
                  //     shrinkWrap: true,
                  //     itemCount: _topsalonlist.length,
                  //     itemBuilder: (BuildContext context, int index) {
                  //       return Container(
                  //         height: 250,
                  //         margin: EdgeInsets.symmetric(horizontal: 30),
                  //         child: Column(
                  //           children: [
                  //             Stack(
                  //               children: [
                  //                 Container(
                  //                   height: 160,
                  //                   width: 300,
                  //                   decoration: BoxDecoration(
                  //                     borderRadius: BorderRadius.circular(10),
                  //                   ),
                  //                   child: Image.asset(_topsalonlist[index].image,fit: BoxFit.fill,),
                  //                 ),
                  //               ],
                  //             ),
                  //             SizedBox(
                  //               height: 20,
                  //             ),
                  //             Container(
                  //               width: 300,
                  //               child: Row(
                  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //                 crossAxisAlignment: CrossAxisAlignment.start,
                  //                 children: [
                  //                   Column(
                  //                     crossAxisAlignment: CrossAxisAlignment.start,
                  //                     mainAxisAlignment: MainAxisAlignment.start,
                  //                     children: [
                  //                       Text(
                  //                         "Fingertip",
                  //                         style: GoogleFonts.poppins(
                  //                             textStyle: TextStyle(
                  //                               fontSize: 16,
                  //                               fontWeight: FontWeight.w500,
                  //                               color: AppColor.primaryColor,
                  //                             )),
                  //                       ),
                  //                       Text(
                  //                         "13 Kalani nagar",
                  //                         style: GoogleFonts.poppins(
                  //                             textStyle: TextStyle(
                  //                               fontSize: 14,
                  //                               fontWeight: FontWeight.w400,
                  //                               color: AppColor.greytext,
                  //                             )),
                  //                       ),
                  //
                  //                     ],
                  //                   ),
                  //                   Row(
                  //                     children: [
                  //                       Text(
                  //                         "5.0 Ratings",
                  //                         style: GoogleFonts.poppins(
                  //                             textStyle: TextStyle(
                  //                               fontSize: 14,
                  //                               fontWeight: FontWeight.w400,
                  //                               color: Color(0XFFB8B8B8),
                  //                             )),
                  //                       ),
                  //                     ],
                  //                   )
                  //                 ],
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //       );
                  //     }),
                  InkWell(
                    onTap: () {
                      // Helper.moveToScreenwithPush(context, TopSalon());
                    },
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: _getOfferModel!.shopList!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return
                            Container(
                            height: MediaQuery.of(context).size.height*0.40,
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            child: InkWell(
                              onTap: (){
                                Helper.moveToScreenwithPush(context, TopSalon(
                                shop_id: _getOfferModel!.shopList![index].shopId.toString(),
                                  totalAmount: "",

                                ));
                              },
                              child: Column(
                                children: [
                                  Container(
                                    height: 160,
                                    width: 300,
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.grey.withOpacity(1),
                                              blurRadius: 3,
                                              offset: Offset(0, 3))
                                        ],
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child:CachedNetworkImage(
                                          imageUrl:
                                          _getOfferModel!.shopList![index].image!.isEmpty
                                              ? ""
                                              :   _getOfferModel!.shopList![index].image!
                                              .toString(),
                                          fit: BoxFit.fill,
                                          height: 160,
                                          width: 300,
                                          placeholder: (context, url) =>
                                              LinearProgressIndicator(
                                                color: Colors.white.withOpacity(0.2),
                                                backgroundColor:
                                                Colors.white.withOpacity(.5),
                                              ),
                                          errorWidget: (context, url, error) =>
                                              ClipRRect(
                                                borderRadius: BorderRadius.circular(10),
                                                child: Container(
                                                  height: 160,
                                                  width: 300,
                                                  decoration: BoxDecoration(
                                                      boxShadow: [
                                                        BoxShadow(
                                                            color: Colors.grey.withOpacity(1),
                                                            blurRadius: 3,
                                                            offset: Offset(0, 3))
                                                      ],
                                                      color: Colors.white,
                                                      borderRadius: BorderRadius.circular(20)
                                                  ),
                                                  child:Icon(Icons.error_outline_sharp),
                                                ),
                                              ),
                                        )
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    // width: MediaQuery.of(context).size.width*0.80,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              _getOfferModel!.shopList![index].saloonName!
                                                  .toString(),
                                              style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                    color: AppColor.primaryColor,
                                                  )),
                                            ),
                                            Container(
                                              width: 250,
                                              child: Text(
                                                _getOfferModel!.shopList![index].address!
                                                    .toString(),
                                                style: GoogleFonts.poppins(
                                                    textStyle: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w400,
                                                      color: AppColor.greytext,
                                                    )),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          _getOfferModel!.shopList![index].rating!
                                              .toString(),
                                          style: GoogleFonts.poppins(
                                              textStyle: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                color: Color(0XFFB8B8B8),
                                              )),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
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

  Future<void> getofferApi() async {

    print("<==============getofferApi==================>");

    _hashData = true;
    setProgress(true);

    SessionHelper session = await SessionHelper.getInstance(context);
    String userId = session.get(SessionHelper.USER_ID) ?? "0";


    Map data = {
      'user_id': userId,
    };

    print("Request =============>" + data.toString());
    try {
      var res = await http.post(Uri.parse(Apis.getOffers), body: data);
      print("Response ============>" + res.body);

      if (res.statusCode == 200) {
        try {
          final jsonResponse = jsonDecode(res.body);
          GetOfferModel model = GetOfferModel.fromJson(jsonResponse);

          if (model.status == "true") {
            _hashData = false;

            setState(() {
              _getOfferModel = model;

          // Helper.checkInternet(getShopDetailsApi());
            });

            print("Model status true");
            setProgress(false);
            _hashData = false;
            ToastMessage.msg(model.message.toString());
            // _nameController.text=model.data!.name!;
            // _emailController.text=model.data!.email!;
            // _phoneController.text.data!.phone!;


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


  Future<void> getShopDetailsApi() async {

    print("<==============getShopDetailsApi==================>");

    _hashData = true;
    setProgress(true);

    SessionHelper session = await SessionHelper.getInstance(context);
    String userId = session.get(SessionHelper.USER_ID) ?? "0";


    Map data = {
      'user_id': userId,
      'shop_id':shopId.toString()
    };

    print("Request =============>" + data.toString());
    try {
      var res = await http.post(Uri.parse(Apis.getShopDetails), body: data);
      print("Response ============>" + res.body);

      if (res.statusCode == 200) {
        try {
          final jsonResponse = jsonDecode(res.body);
          Getshopdetailmodel model = Getshopdetailmodel.fromJson(jsonResponse);

          if (model.status == "true") {
            _hashData = false;

            setState(() {
              _getshopdetailmodel = model;
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


  setProgress(bool show) {
    if (mounted)
      setState(() {
        _isVisible = show;
      });
  }


}

class TopSalonModel {
  String image = "";
  String name = "";

  TopSalonModel({required this.image, required this.name});
}


class OfferModel {
  String image = "";
  String name = "";

  OfferModel({required this.image, required this.name});
}
