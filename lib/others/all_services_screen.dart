import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:serviceapplatest/helper/constant.dart';
import '../helper/apis.dart';
import '../model/get_shop_list_model.dart';
import '../top salons/top_salon.dart';

class AllService extends StatefulWidget {
  String service = "";

  AllService({required this.service});

  @override
  State<AllService> createState() => _AllServiceState();
}

class _AllServiceState extends State<AllService> {
  Getshoplistmodel? _getshoplistmodel;
  bool _isVisible = false;
  bool _hashData = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Helper.checkInternet(getShopListApi());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 80,
        titleSpacing: 0,
        backgroundColor: Color(0xFFFFFFFF),
        centerTitle: true,
        title: Text(
          widget.service,
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
      body: _getshoplistmodel == null
          ? Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Center(child: Text("No services found")),
            )
          : Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    ListView.builder(
                        scrollDirection: Axis.vertical,
                        physics: ScrollPhysics(),
                        // physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: _getshoplistmodel!.shopLists!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              print("saloon===1");
                              Helper.moveToScreenwithPush(
                                  context, TopSalon(
                                    shop_id: _getshoplistmodel!.shopLists![index].shopId.toString(),
                                totalAmount: "",

                                  ));
                            },
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.35,
                              margin: EdgeInsets.symmetric(horizontal: 20),
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
                                        borderRadius: BorderRadius.circular(10)),
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: CachedNetworkImage(
                                          imageUrl: _getshoplistmodel!
                                                  .shopLists![index]
                                                  .image!
                                                  .isEmpty
                                              ? ""
                                              : _getshoplistmodel!
                                                  .shopLists![index].image!
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
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Container(
                                              height: 160,
                                              width: 300,
                                              decoration: BoxDecoration(
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: Colors.grey
                                                            .withOpacity(1),
                                                        blurRadius: 3,
                                                        offset: Offset(0, 3))
                                                  ],
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(20)),
                                              child:
                                                  Icon(Icons.error_outline_sharp),
                                            ),
                                          ),
                                        )),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    // width: MediaQuery.of(context).size.width*0.80,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              _getshoplistmodel!
                                                  .shopLists![index].saloonName
                                                  .toString(),
                                              style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                color: AppColor.primaryColor,
                                              )),
                                            ),
                                            Text(
                                              "13 Anoop nagar",
                                              style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                color: AppColor.greytext,
                                              )),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          "5.0 Ratings",
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

  Future<void> getShopListApi() async {
    print("<==============getShopListApi==================>");

    _hashData = true;
    setProgress(true);

    SessionHelper session = await SessionHelper.getInstance(context);
    String userId = session.get(SessionHelper.USER_ID) ?? "0";

    Map data = {
      'user_id': userId,
      'service': widget.service
    };

    print("Request =============>" + data.toString());
    try {
      var res = await http.post(Uri.parse(Apis.getShopList), body: data);
      print("Response ============>" + res.body);

      if (res.statusCode == 200) {
        try {
          final jsonResponse = jsonDecode(res.body);
          Getshoplistmodel model = Getshoplistmodel.fromJson(jsonResponse);

          if (model.status == "true") {
            _hashData = false;

            setState(() {
              _getshoplistmodel = model;
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
}
