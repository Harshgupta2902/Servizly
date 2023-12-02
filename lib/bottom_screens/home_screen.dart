import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:serviceapplatest/Payment/review_order.dart';
import '../blogpage.dart';
import '../generated/l10n.dart';
import '../helper/apis.dart';
import '../helper/constant.dart';
import '../helper/image.dart';
import '../model/get_profile_model.dart';
import '../model/home_model.dart';
import '../others/all_services_screen.dart';
import '../others/notification.dart';
import '../top salons/top_salon.dart';

class HomeScreen extends StatefulWidget {
  String shop_id = "";
  String totalAmount = "";

  HomeScreen({required this.shop_id, required this.totalAmount});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String img = '';
  GetProfileModel? _getprofileModel;
  String? getimage = SessionHelper().get(SessionHelper.IMAGE);
  String? getname = SessionHelper().get(SessionHelper.NAME);

  final List<ListimageModel> _listimagename = [
    ListimageModel(image: ProjectImage.hairmachine, name: "Hair Salon"),
    ListimageModel(image: ProjectImage.Nail, name: "Nail Salon"),
    ListimageModel(image: ProjectImage.Skin, name: "Skin care"),
    ListimageModel(image: ProjectImage.more, name: "More"),
  ];

  final List _blogpage = [
    ListimageModel(image: ProjectImage.solon_logo1, name: "Hair"),
    ListimageModel(image: ProjectImage.solon_logo1, name: "Barber"),
    ListimageModel(image: ProjectImage.solon_logo1, name: "Nails"),
    ListimageModel(image: ProjectImage.solon_logo1, name: "Skin"),
    ListimageModel(image: ProjectImage.solon_logo1, name: "Tattoo"),
  ];

  // final _formKey = GlobalKey<FormState>();
  String time = "";
  bool _isVisible = false;
  bool _hashData = false;
  File? _image;
  String service = "";
  HomeModel? _homeModel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    FirebaseMessaging.instance.getInitialMessage().then(
          (message) {
        print("FirebaseMessaging.instance.getInitialMessage");
        if (message != null) {
          print("New Notification");
        }
      },
    );

    FirebaseMessaging.onMessageOpenedApp.listen(
          (message) {
        print("FirebaseMessaging.onMessageOpenedApp.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data22 ${message.data['_id']}");
        }
      },
    );

    Helper.checkInternet(getprofileApi());
    Helper.checkInternet(HomeAPi());
    DateTime _now = DateTime.now();
    print(
        'timestamp: ${_now.hour}:${_now.minute}:${_now.second}.${_now.millisecond}');
    if (_now.hour < 12) {
      time = 'Morning';
    } else if (12 < _now.hour && _now.hour < 18) {
      time = 'Afternoon';
    } else {
      time = 'Evening';
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => showExitPopup(context),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          surfaceTintColor: Colors.transparent,
          toolbarHeight: 60,
          titleSpacing: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Color(0XFF07A9B1),
          centerTitle: true,
          title: Image.asset(
            ProjectImage.ServizlyWhite,
            width: 120,
            height: 90,
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: InkWell(
                  onTap: () {
                    Helper.moveToScreenwithPush(context, NotificationScreen());
                  },
                  child: Icon(
                    Icons.notifications,
                    color: Colors.white,
                    size: 30,
                  )),
            ),
          ],
        ),
        body: SafeArea(
          child: Stack(
            children: [
              _homeModel == null
                  ? _hashData
                      ? Container()
                      : Container(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          child: Center(
                              child: Text(
                                S.of(context).NoDataFound,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 25
                            ),
                          )))
                  : Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      // padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: Stack(
                        children: [
                          Container(
                            color: Color(0xFFfcfcfc),
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                            // padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ///////////////////////////////////GradientBackground/////////////////////////////////////
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 25, left: 15),
                                              child: Text(
                                                S.of(context).Services,
                                                style: GoogleFonts.poppins(
                                                    textStyle: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500,
                                                  // color: Colors.white,
                                                )),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        // _homeModel!.services!.isEmpty
                                        _homeModel!.services!.isEmpty
                                            ? Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    6,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    6,
                                                child: Text(S.of(context).NoDataFound),
                                              )
                                            : Row(
                                                children: [
                                                  Container(
                                                    width: MediaQuery.of(context)
                                                        .size
                                                        .width,
                                                    height: 100,
                                                    child: ListView.builder(
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        itemCount: _homeModel!
                                                            .services!.length,
                                                        itemBuilder:
                                                            (BuildContext context,
                                                                int index) {
                                                          return InkWell(
                                                            onTap: () {
                                                              setState(() {
                                                                service = _homeModel!
                                                                    .services![
                                                                        index]
                                                                    .services
                                                                    .toString();
                                                              });
                                                              Helper
                                                                  .moveToScreenwithPush(
                                                                      context,
                                                                      AllService(
                                                                        service: _homeModel!
                                                                            .services![
                                                                                index]
                                                                            .services
                                                                            .toString(),
                                                                      ));
                                                            },
                                                            child: Container(
                                                              margin: EdgeInsets
                                                                  .symmetric(
                                                                horizontal: 5,
                                                              ),
                                                              height: 200,
                                                              child: Column(
                                                                children: [
                                                                  Container(
                                                                    height: 70,
                                                                    width: 70,
                                                                    child:
                                                                        ClipOval(
                                                                      child: _image ==
                                                                              null
                                                                          ? CachedNetworkImage(
                                                                              imageUrl: _homeModel!.services![index].images!.isEmpty
                                                                                  ? ""
                                                                                  : _homeModel!.services![index].images!.toString(),
                                                                              fit:
                                                                                  BoxFit.fill,
                                                                              width:
                                                                                  70,
                                                                              height:
                                                                                  70,
                                                                              placeholder: (context, url) =>
                                                                                  LinearProgressIndicator(
                                                                                color: Colors.white.withOpacity(0.2),
                                                                                backgroundColor: Colors.white.withOpacity(.5),
                                                                              ),
                                                                              errorWidget: (context, url, error) => ClipOval(
                                                                                  child: Image.asset(
                                                                                _listimagename[index].image,
                                                                                height: 70,
                                                                                width: 70,
                                                                              )),
                                                                            )
                                                                          : Image.file(
                                                                              _image!,
                                                                              height:
                                                                                  80,
                                                                              width:
                                                                                  80,
                                                                              fit:
                                                                                  BoxFit.fill),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 10,
                                                                  ),
                                                                  Text(
                                                                    _homeModel!
                                                                        .services![
                                                                            index]
                                                                        .services
                                                                        .toString(),
                                                                    style: GoogleFonts
                                                                        .poppins(
                                                                            textStyle:
                                                                                const TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      // color: Colors.white,
                                                                    )),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          );
                                                        }),
                                                  ),
                                                ],
                                              ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                      ],
                                    ),
                                  ),

                                  ///////////////////////////////////WhiteBackground/////////////////////////////////////

                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 20),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              S.of(context).SpecialOffers,
                                              style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black,
                                              )),
                                            ),
                                            // Icon(Icons.arrow_forward,
                                            //   color: Colors.black,)
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        _homeModel!.offers!.isEmpty
                                            ? Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    6,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    6,
                                                child: Text(S.of(context).NoDataFound),
                                              )
                                            : CarouselSlider.builder(
                                                itemCount:
                                                    _homeModel!.offers!.length,
                                                options: CarouselOptions(
                                                  // enlargeCenterPage: true,
                                                  height: 170,
                                                  autoPlay: true,
                                                  autoPlayInterval:
                                                      Duration(seconds: 3),
                                                  reverse: false,
                                                  aspectRatio: 0.8 / 0.4,
                                                  viewportFraction: 1,
                                                ),
                                                itemBuilder: (context, i, id) {
                                                  //for onTap to redirect to another screen
                                                  return GestureDetector(
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                15),
                                                        // border: Border.all(color: Colors.white,)
                                                      ),
                                                      //ClipRRect for image border radius
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                15),
                                                        child: Image.network(
                                                          _homeModel!
                                                              .offers![i].image
                                                              .toString(),
                                                          width: 600,
                                                          fit: BoxFit.fill,
                                                        ),
                                                      ),
                                                    ),
                                                    onTap: () {
                                                      var url = _homeModel!
                                                          .offers![i].image
                                                          .toString();
                                                      print(url.toString());
                                                    },
                                                  );
                                                },
                                              ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Stack(
                                    children: [
                                      Container(
                                        height: 250,
                                        width: MediaQuery.of(context).size.width,
                                        child: Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: Colors.grey.shade100,
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  vertical: 20, horizontal: 15),
                                              child: Text(
                                                S.of(context).GetInspiredwithServizly,
                                                style: TextStyle(
                                                    fontSize: 32,
                                                    letterSpacing: 0.6,
                                                    fontWeight: FontWeight.bold),

                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 1,
                                        left: 15,
                                        child: Container(
                                          height: 130,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          // color: Colors.red,
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: _blogpage.length,
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: InkWell(
                                                  onTap: (){
                                                    print(_blogpage[index].name);
                                                    Helper.moveToScreenwithPush(context, BlogPage(name: _blogpage[index].name));
                                                  },
                                                  child: Container(
                                                    height: 150,
                                                    width: 130,
                                                    // color: Colors.green,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(10),
                                                      boxShadow: [
                                                        BoxShadow(
                                                            blurRadius: 1,
                                                            spreadRadius: 1,
                                                            offset: Offset(0, 1),
                                                            color: Colors.grey
                                                                .withOpacity(0.2)),
                                                      ],
                                                    ),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.center,
                                                      children: [
                                                        ClipOval(
                                                            child:
                                                                CachedNetworkImage(
                                                          imageUrl: "",
                                                          fit: BoxFit.fill,
                                                          width: 65,
                                                          height: 65,
                                                          placeholder: (context,
                                                                  url) =>
                                                              LinearProgressIndicator(
                                                            color: Colors.white
                                                                .withOpacity(0.2),
                                                            backgroundColor: Colors
                                                                .white
                                                                .withOpacity(.5),
                                                          ),
                                                          errorWidget: (context,
                                                                  url, error) =>
                                                              Container(
                                                            width: 65,
                                                            height: 65,
                                                            // padding: EdgeInsets.symmetric(vertical: 25.0),
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius.all(
                                                                Radius.circular(20),
                                                              ),
                                                              // color: Color(0xFFD9D9D9)
                                                            ),
                                                            child: Center(
                                                              child: Image.asset(
                                                                  _blogpage[index].image),
                                                              // child: Icon(
                                                              //   Icons.person,
                                                              //   size: 40,
                                                              //   color: AppColor.primaryColor,
                                                              // ),
                                                            ),
                                                          ),
                                                        )),
                                                        SizedBox(height: 10),
                                                        Center(
                                                            child: Text(
                                                          _blogpage[index].name,
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight.bold),
                                                        )),
                                                        SizedBox(height: 10),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 30,
                                        right: 15,
                                        child: Container(
                                          height: 60,
                                          width: 60,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle,
                                            boxShadow: [
                                              BoxShadow(
                                                  offset: Offset(0, 1),
                                                  blurRadius: 2,
                                                  spreadRadius: 1,
                                                  color: Colors.grey
                                                      .withOpacity(0.5))
                                            ],
                                          ),
                                          // color: Colors.red,
                                          child: Icon(
                                            Icons.arrow_forward,
                                            size: 35,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 15),
                                  Container(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 20),
                                      child: Column(
                                        children: [
                                          Container(
                                            width:
                                                MediaQuery.of(context).size.width,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  S.of(context).MostBookedServices,
                                                  style: GoogleFonts.poppins(
                                                      textStyle: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w500,
                                                    color: AppColor.primaryColor,
                                                  )),
                                                ),
                                                // Icon(Icons.arrow_forward)
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          _homeModel!.topSaloon!.isEmpty
                                              ? Container(
                                                  height: MediaQuery.of(context).size.height / 2,
                                                  width: MediaQuery.of(context) .size.width /6,
                                                  child: Text(S.of(context).NoDataFound),
                                                )
                                              : SingleChildScrollView(
                                                  // scrollDirection: Axis.horizontal,
                                                  physics:
                                                      NeverScrollableScrollPhysics(),
                                                  child: Container(
                                                    width: MediaQuery.of(context)
                                                        .size
                                                        .width,
                                                    height: 250,
                                                    child: ListView.builder(
                                                        scrollDirection:Axis.horizontal,
                                                        itemCount: _homeModel!.topSaloon!.length,
                                                        itemBuilder:
                                                            (BuildContext context,
                                                                int index) {
                                                          return InkWell(
                                                            onTap: () {
                                                              Helper
                                                                  .moveToScreenwithPush(
                                                                      context,
                                                                      TopSalon(
                                                                        shop_id: _homeModel!
                                                                            .topSaloon![
                                                                                index]
                                                                            .shopId
                                                                            .toString(),
                                                                        totalAmount:
                                                                            widget
                                                                                .totalAmount,
                                                                      ));
                                                            },
                                                            child: Padding(
                                                              padding: const EdgeInsets.only(right: 15),
                                                              child: Container(
                                                                height: 240,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  boxShadow: [
                                                                    BoxShadow(
                                                                        color: Colors
                                                                            .grey
                                                                            .withOpacity(
                                                                                1),
                                                                        blurRadius:
                                                                            3,
                                                                        offset:
                                                                            Offset(
                                                                                0,
                                                                                3))
                                                                  ],
                                                                  color:
                                                                      Colors.white,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20),
                                                                ),
                                                                // margin: EdgeInsets.symmetric(
                                                                //     horizontal: 10),
                                                                child: Column(
                                                                  children: [
                                                                    // const  SizedBox(
                                                                    //   height: 20,
                                                                    // ),
                                                                    Stack(
                                                                      children: [
                                                                        Container(
                                                                          width:
                                                                              240,
                                                                          height:
                                                                              250,
                                                                          child:
                                                                              ClipRRect(
                                                                            borderRadius:
                                                                                BorderRadius.circular(20),
                                                                            child: _image ==
                                                                                    null
                                                                                ? CachedNetworkImage(
                                                                                    // imageUrl: _homeModel!.TopSaloon![ index].shop.isEmpty
                                                                                    imageUrl: _homeModel!.topSaloon![index].shopImage!.isEmpty ? "" : _homeModel!.topSaloon![index].shopImage!.toString(),
                                                                                    fit: BoxFit.fill,
                                                                                    width: 60,
                                                                                    height: 60,
                                                                                    placeholder: (context, url) => LinearProgressIndicator(
                                                                                      color: Colors.white.withOpacity(0.2),
                                                                                      backgroundColor: Colors.white.withOpacity(.5),
                                                                                    ),
                                                                                    errorWidget: (context, url, error) => ClipRRect(
                                                                                      borderRadius: BorderRadius.circular(20),
                                                                                      child: Container(
                                                                                        width: 240,
                                                                                        height: 220,
                                                                                        child: Image.asset(
                                                                                          _homeModel!.topSaloon![index].shopImage!.toString(),
                                                                                          fit: BoxFit.fill,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  )
                                                                                : Image.file(_image!,
                                                                                    height: 80,
                                                                                    width: 80,
                                                                                    fit: BoxFit.fill),
                                                                          ),
                                                                        ),
                                                                        Positioned(
                                                                            bottom:
                                                                                0,
                                                                            left: 0,
                                                                            child: Container(
                                                                                width: 110,
                                                                                // height: 50,
                                                                                padding: EdgeInsets.all(10),
                                                                                decoration: BoxDecoration(
                                                                                  borderRadius: BorderRadius.only(topRight: Radius.circular(10), topLeft: Radius.circular(0), bottomRight: Radius.circular(10), bottomLeft: Radius.circular(20)),
                                                                                  color: Color(0xFFdee1e3).withOpacity(0.5),
                                                                                  boxShadow: [
                                                                                    BoxShadow(
                                                                                      color: Colors.black12,
                                                                                      blurRadius: 2,
                                                                                      offset: Offset(1, 2),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                                child: Column(
                                                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                                                  children: [
                                                                                    Text(
                                                                                      "${_homeModel!.topSaloon![index].saloonName!.toString()}",
                                                                                      style: GoogleFonts.poppins(
                                                                                          textStyle: TextStyle(
                                                                                        fontSize: 10,
                                                                                        fontWeight: FontWeight.w500,
                                                                                        color: AppColor.primaryColor,
                                                                                      )),
                                                                                    ),
                                                                                  ],
                                                                                )
                                                                            )
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        }),
                                                  ),
                                                ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          _homeModel!.unconfirmedBooking == "0"
                              ? Container()
                              : Positioned(
                                  bottom: 0,
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding: EdgeInsets.all(10),
                                    decoration: const BoxDecoration(
                                      // borderRadius: BorderRadius.only(
                                      //     topRight:  Radius.circular(10),
                                      //     topLeft:  Radius.circular(10),
                                      //     bottomRight:  Radius.circular(10)
                                      // ),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 7,
                                          offset: Offset(3, 5),
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle),
                                          height: 40,
                                          width: 40,
                                          child: Stack(
                                            children: [
                                              ClipOval(
                                                  child: CachedNetworkImage(
                                                imageUrl: _homeModel!
                                                    .shopDetails!.image
                                                    .toString(),
                                                // _getprofileModel!
                                                //         .data!.image!.isEmpty
                                                //     ? ""
                                                //     : _getprofileModel!.data!.image!
                                                //         .toString(),
                                                fit: BoxFit.fill,
                                                width: 40,
                                                height: 40,
                                                placeholder: (context, url) =>
                                                    LinearProgressIndicator(
                                                  color: Colors.white
                                                      .withOpacity(0.2),
                                                  backgroundColor: Colors.white
                                                      .withOpacity(.5),
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Container(
                                                  width: 40,
                                                  height: 40,
                                                  // padding: EdgeInsets.symmetric(vertical: 25.0),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(20),
                                                      ),
                                                      color: Color(0xFFD9D9D9)),
                                                  child: Center(
                                                    child: Icon(
                                                      Icons.person,
                                                      size: 20,
                                                      color:
                                                          AppColor.primaryColor,
                                                    ),
                                                  ),
                                                ),
                                              )),
                                            ],
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              _homeModel!.shopDetails!.saloonName
                                                  .toString(),
                                              style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                color: AppColor.primaryColor,
                                              )),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                Helper.moveToScreenwithPush(context, TopSalon(shop_id: _homeModel!.booking![0].shopId.toString(), totalAmount: ""));
                                              },
                                              child: Text(
                                                S.of(context).ViewFullServices,
                                                style: GoogleFonts.poppins(
                                                    textStyle: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color(0xff5F5F5F),
                                                )),
                                              ),
                                            ),
                                          ],
                                        ),
                                        MaterialButton(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 12, vertical: 5),
                                            color: Color(0XFF07A9B1),
                                            textColor: Colors.white,
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                        _homeModel!.serviceCount
                                                            .toString(),
                                                        style:
                                                            GoogleFonts.poppins(
                                                          textStyle: TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                        )),
                                                    Text(" | ",
                                                        style:
                                                            GoogleFonts.poppins(
                                                          textStyle: TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                        )),
                                                    Text(
                                                      _homeModel!.totalAmount
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  ],
                                                ),
                                                Text("Checkout",
                                                    style: GoogleFonts.poppins(
                                                      textStyle: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    )),
                                              ],
                                            ),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            onPressed: () {
                                              Helper.moveToScreenwithPush(
                                                  context,
                                                  ReviewPayment(
                                                    shop_id: widget.shop_id,
                                                    coupon: "",
                                                    discount: "",
                                                  ));
                                              // Helper.moveToScreenwithPush(context, TopSalon());
                                              // if (_formkey.currentState!.validate() && isValidated == true) {
                                              //   isValidated  = false;
                                              //   _formkey.currentState!.save();
                                              //   Helper.checkInternet(SignupApi());
                                              //
                                              //   // if (_formkey.currentState!.validate()) {
                                              //   //   _formkey.currentState!.save();
                                              //   // Helper.moveToScreenwithPush(
                                              //   //     context, const VerificationScreen());
                                              // }
                                            }),
                                      ],
                                    ),
                                  )),
                        ],
                      ),
                    ),
              Helper.getProgressBarWhite(context, _isVisible)
            ],
          ),
        ),
      ),
    );
  }

  setProgress(bool show) {
    if (mounted)
      setState(() {
        _isVisible = show;
      });
  }

  Future<bool> showExitPopup(context) async{
    return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
              height: 90,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(S.of(context).Exit,),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            print('yes selected');
                            exit(0);
                          },
                          child: Text("Yes"),
                          style: ElevatedButton.styleFrom(
                              primary: Color(0XFF07A9B1)),
                        ),
                      ),
                      SizedBox(width: 15),
                      Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              print('no selected');
                              Navigator.of(context).pop();
                            },
                            child: Text("No", style: TextStyle(color: Colors.black)),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                            ),
                          ))
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
  Future<void> HomeAPi() async {
    print("<==============HomeAPI==================>");

    _hashData = true;
    setProgress(true);

    SessionHelper session = await SessionHelper.getInstance(context);
    String userId = session.get(SessionHelper.USER_ID) ?? "0";

    Map data = {
      'user_id': userId,
    };

    print("Request =============>" + data.toString());
    try {
      var res = await http.post(Uri.parse(Apis.home), body: data);
      print("Response ============>" + res.body);

      if (res.statusCode == 200) {
        try {
          final jsonResponse = jsonDecode(res.body);
          HomeModel model = HomeModel.fromJson(jsonResponse);

          if (model.status == "true") {
            _hashData = false;

            setState(() {
              _homeModel = model;
              // nameController.text =_getprofileModel!.data!.name.toString() ;
              // phoneController.text =_getprofileModel!.data!.phone.toString() ;
              // emailController.text =_getprofileModel!.data!.email.toString() ;

              // showDate =dob ;
              // img =_profileModel!.userData![0].image![0].toString();
              //  print("printRajat============${_homeModel!.unconfirmedBooking}");
              // print("count===============>${_homeModel!.booking!.serviceCount.toString()}");
              //  print("prints${_homeModel!.booking!.service.toString()}");
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
  Future<void> getprofileApi() async {
    print("<=============GetprofileApi =============>");

    SessionHelper sessionHelper = await SessionHelper.getInstance(context);
    String userId = sessionHelper.get(SessionHelper.USER_ID) ?? "0";

    print("<=============userId =============>" + userId);
    _hashData = true;
    setProgress(true);
    Map data = {
      'user_id': userId,
    };

    print("Request =============>" + data.toString());
    try {
      var res = await http.post(Uri.parse(Apis.getProfile), body: data);
      print("Response ============>" + res.body);

      if (res.statusCode == 200) {
        print("jaydeep ============>");
        try {
          final jsonResponse = jsonDecode(res.body);
          GetProfileModel model = GetProfileModel.fromJson(jsonResponse);

          if (model.status == "true") {
            print("Model status true");

            setProgress(false);
            _hashData = false;

            setState(() {
              _getprofileModel = model;

              img = _getprofileModel!.data!.image.toString();
              print("===================image =========== ${img.toString()}");
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
}

class ListimageModel {
  String image = "";
  String name = "";

  ListimageModel({required this.image, required this.name});
}

class OfferModel {
  String image = "";
  String name = "";

  OfferModel({required this.image, required this.name});
}

class TopSalonModel {
  String name = "";
  String rate = "";
  String rs = "";

  TopSalonModel({required this.name, required this.rate, required this.rs});
}

class ExpertsModel {
  String image = "";
  String name = "";

  ExpertsModel({required this.image, required this.name});
}

class MostBookedServicesModel {
  String image = "";
  String name = "";

  MostBookedServicesModel({required this.image, required this.name});
}
