
import 'dart:convert';

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart'as http;
import '../Payment/review_order.dart';
import '../generated/l10n.dart';
import '../model/add_offer_model.dart';
import '../helper/animationdilog.dart';
import '../helper/apis.dart';
import '../helper/constant.dart';
import '../helper/image.dart';
import '../model/get_shop_offer_model.dart';

class ApplyCoupon extends StatefulWidget {
  String shop_id="";
  String totalAmount="";

  ApplyCoupon({
    required this.shop_id,
    required this.totalAmount,
  });

  @override
  State<ApplyCoupon> createState() => _ApplyCouponState();
}

class _ApplyCouponState extends State<ApplyCoupon> with SingleTickerProviderStateMixin{


  bool _showDocument = true;
  bool _hashData = false;
  bool _isVisible = false;
  String discount="";
  String id = "";

  TextEditingController couponController=TextEditingController();
  GetShopOfferModel?_getShopOfferModel;
  AddOfferModel?_addOffersModel;

  final _formkey=GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _showDocument = false;
    Helper.checkInternet(getshopofferApi());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 100,
        titleSpacing: 0,
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          S.of(context).ApplyCoupon,
          style: GoogleFonts.poppins(
              textStyle: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.white,
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
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                      height: 180,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        // border: Border.all(color: AppColor.secondaryColor, width: 2),
                        borderRadius: BorderRadius.only(bottomLeft:Radius.circular(30),bottomRight:Radius.circular(30) ),
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
                      child:  Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:[
                          Text(
                              S.of(context).ApplyCoupon,
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff222222),
                                ),
                              )),
                          widget.totalAmount.toString() == null
                          ?Container()
                          :Row(
                            children: [
                              Text(
                                  S.of(context).ViewCart,
                                  style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color:Colors.grey,
                                    ),
                                  )),
                              Text(
                                "${widget.totalAmount}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            child: Container(
                              // width: MediaQuery.of(context).size.width/1.1,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey,),
                                borderRadius: BorderRadius.circular(10),
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
                              child: Form(
                                key: _formkey,
                                child: TextFormField(
                                    controller: couponController,
                                    keyboardType: TextInputType.text,
                                    cursorColor: Colors.white,

                                    // controller: phoneController,
                                    decoration: InputDecoration(
                                      hintText: S.of(context).EnterCode,
                                      hintStyle:
                                      GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                                      filled: true,
                                      suffixIcon: Padding(
                                        padding: const EdgeInsets.only(top: 10.0,right: 20),
                                        child: InkWell(
                                          onTap: () {
                                            // Helper.checkInternet(getshopofferapplyApi());
                                            Helper.checkInternet(AddOfferAPI());
                                            print("offerid******************${id}");
                                          },
                                          child: Text("APPLY",style:  GoogleFonts.poppins(
                                            textStyle: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.grey,
                                            ),)),
                                        ),
                                      ),
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),

                                      ),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: BorderSide.none),
                                      disabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.circular(10)),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.circular(10)),
                                      errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.circular(10)),
                                    ),
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                    textInputAction: TextInputAction.next,
                                    validator: (phone) {
                                      if (phone!.isEmpty) {
                                        return "Please enter phone number";
                                      } else if (phone.length != 10) {
                                        return "Mobile Number must be of 10 digit";
                                      }
                                    }),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _getShopOfferModel==null?Container():  Container(
                          height: MediaQuery.of(context).size.height,
                          child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              itemCount: _getShopOfferModel!.offerList!.length,
                              itemBuilder: (BuildContext context, int index) {
                                return  InkWell(
                                  onTap: () async {

                                    print("Discount**${discount}");
                                    setState(() {
                                      print("Discount**${discount}");

                                      if(discount.contains( _getShopOfferModel!.offerList![index].off.toString())){
                                        _showDocument = false;
                                        discount = "";
                                        couponController.text = "";
                                      }
                                      else{
                                        discount=_getShopOfferModel!.offerList![index].off.toString();
                                        couponController.text =  _getShopOfferModel!.offerList![index].offer.toString();
                                        _showDocument = true;
                                        id= _getShopOfferModel!.offerList![index].offerId.toString();
                                        print("*******************************${id}");

                                        // Helper.checkInternet(getshopofferapplyApi());
                                        Helper.checkInternet(AddOfferAPI());
                                      }
                                      print("Rajat${discount}");
                                    });
                                    await Clipboard.setData(ClipboardData(text:_getShopOfferModel!.offerList![index].offer.toString() ));
                                    ToastMessage.msg("Applied");// copied successfully
                                   },
                                  child: Stack(
                                    children: [
                                      Container(
                                        height: 200,
                                        margin: EdgeInsets.symmetric(vertical: 10) ,
                                        width: MediaQuery.of(context).size.width,
                                        decoration: new BoxDecoration(
                                            image: new DecorationImage(
                                              image: AssetImage(ProjectImage.Rectanglecoupon),
                                              fit: BoxFit.fill,
                                            )
                                        ),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Center(
                                              child: Container(
                                                padding: EdgeInsets.only(left: 10),
                                                child: RotatedBox(
                                                  quarterTurns: -1,
                                                  child: RichText(
                                                    text: TextSpan(
                                                      text: _getShopOfferModel!.offerList![index].offerOff.toString().toUpperCase(),style: GoogleFonts.poppins(
                                                        textStyle: TextStyle(
                                                          fontSize: 30,
                                                          fontWeight: FontWeight.w700,
                                                          color: Colors.white,
                                                        )),
                                                      children: [
                                                        WidgetSpan(
                                                          child: RotatedBox(quarterTurns: 2, child: Text("")),
                                                        ),

                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),

                                            ),
                                            Padding(
                                              padding:  EdgeInsets.only(left: 10.0,right: 15),
                                              child: DottedLine(
                                                direction: Axis.vertical,
                                                lineLength: 200,
                                                lineThickness: 1.0,
                                                dashLength: 4.0,
                                                dashColor: Colors.white,
                                                dashRadius: 0.0,
                                                dashGapLength: 4.0,
                                                dashGapColor: Colors.transparent,
                                                dashGapRadius: 0.0,
                                              ),
                                            ),
                                            Container(
                                              width: MediaQuery.of(context).size.width/2,
                                              child: Column(
                                                children: [
                                                  Container(
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                      children: [
                                                        Container(
                                                          width: MediaQuery.of(context).size.width/2,
                                                          padding: EdgeInsets.only(top: 20,bottom: 10),
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Container(
                                                                padding: EdgeInsets.symmetric(horizontal: 10),
                                                                decoration: BoxDecoration(
                                                                    borderRadius: BorderRadius.circular(2),
                                                                    color: Colors.white
                                                                ),
                                                                child: Center(
                                                                  child: Text(_getShopOfferModel!.offerList![index].offer.toString(), style: GoogleFonts.poppins(
                                                                    textStyle: TextStyle(
                                                                        fontSize: 16,
                                                                        fontWeight: FontWeight.w500,
                                                                        color: Color(0xffDA5496)
                                                                    ),
                                                                  ),),
                                                                ),),
                                                              InkWell(
                                                                onTap: () async {
                                                                  setState(() {
                                                                    id = _getShopOfferModel!.offerList![index].offerId.toString();
                                                                    print("offerId ${id}");
                                                                    discount=_getShopOfferModel!.offerList![index].off.toString();
                                                                    print("Discount${discount}");
                                                                  });
                                                                  await Clipboard.setData(ClipboardData(text:_getShopOfferModel!.offerList![index].offer.toString() ));
                                                                  ToastMessage.msg("Applied");
                                                                  // copied successfully
                                                                },
                                                                child: Text("Apply", style: GoogleFonts.poppins(
                                                                  textStyle: TextStyle(
                                                                      fontSize: 16,
                                                                      fontWeight: FontWeight.w600,
                                                                      color: Colors.white
                                                                  ),
                                                                ),),
                                                              ),
                                                            ],
                                                          ),
                                                        )


                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    width: MediaQuery.of(context).size.width/2,
                                                    child: Text("Add 90 more to get a discount upto 100 ", style: GoogleFonts.poppins(
                                                      textStyle: TextStyle(
                                                          fontSize: 13,
                                                          fontWeight: FontWeight.w500,
                                                          color: Colors.white
                                                      ),
                                                    ),),
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.symmetric(vertical: 10),
                                                    child: DottedLine(
                                                      direction: Axis.horizontal,
                                                      lineLength: 200,
                                                      lineThickness: 1.0,
                                                      dashLength: 4.0,
                                                      dashColor: Colors.white,
                                                      dashRadius: 0.0,
                                                      dashGapLength: 4.0,
                                                      dashGapColor: Colors.transparent,
                                                      dashGapRadius: 0.0,
                                                    ),
                                                  ),
                                                  Row(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                        width: MediaQuery.of(context).size.width/2,
                                                        child: Text("Use code ${_getShopOfferModel!.offerList![index].offer.toString()}&${_getShopOfferModel!.offerList![index].description.toString()}", style: GoogleFonts.poppins(
                                                          textStyle: TextStyle(
                                                              fontSize: 11,
                                                              fontWeight: FontWeight.w500,
                                                              color: Colors.white
                                                          ),
                                                        ),),
                                                      ),


                                                    ],
                                                  ),
                                                ],
                                              ),
                                            )

                                          ],
                                        ),
                                      ),
                                      Positioned(
                                          bottom: 150,
                                          left: 250,
                                          right: 15,
                                          child:  Padding(
                                            padding: EdgeInsets.symmetric(horizontal: 0),
                                            child: InkWell(
                                              onTap: (
                                                  ){

                                                // _bottomSheetFilter(context);
                                              },
                                              child: Visibility(
                                                maintainAnimation: true,
                                                // maintainSize: true,
                                                maintainState: true,
                                                visible: discount == _getShopOfferModel!.offerList![index].off.toString()?
                                                true : false,
                                                child:
                                                Container(
                                                  height: 45,
                                                  width: 45,
                                                  margin: EdgeInsets.all(12),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: Center(
                                                      child:
                                                      Image.asset(ProjectImage.right,)
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )),

                                    ],
                                  ),
                                );
                              }
                            ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
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
  Future<void> getshopofferApi() async {

    print("<==============getshopofferApi==================>");

    _hashData = true;
    setProgress(true);

    SessionHelper session = await SessionHelper.getInstance(context);
    String userId = session.get(SessionHelper.USER_ID) ?? "0";


    Map data = {
      'user_id': userId,
      'shop_id':widget.shop_id,
      'couponCode':couponController.text.trim().toString()
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

  Future<void> AddOfferAPI() async {

    print("<==============ADD OFFER API==================>");

    _hashData = true;
    setProgress(true);

    SessionHelper session = await SessionHelper.getInstance(context);
    String userId = session.get(SessionHelper.USER_ID) ?? "0";


    Map data = {
      'user_id': userId,
      'offer_id':id,
    };

    print("Request =============>" + data.toString());
    try {
      var res = await http.post(Uri.parse(Apis.addCoupon), body: data);
      print("Response ============>" + res.body);

      if (res.statusCode == 200) {
        try {
          final jsonResponse = jsonDecode(res.body);
          AddOfferModel model = AddOfferModel.fromJson(jsonResponse);

          if (model.status == "true") {
            _hashData = false;

            setState(() {
              _addOffersModel = model;
              print("*************************IDofoffer*************************** ${id}");
            });
            Helper.moveToScreenwithPushreplaceemt(context,
                ReviewPayment(shop_id: widget.shop_id,
                  coupon:couponController.text.trim().toString(),
                  discount: discount,
                ));

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

  Future<void> getshopofferapplyApi() async {

    print("<==============getshopofferApi==================>");

    _hashData = true;
    setProgress(true);

    SessionHelper session = await SessionHelper.getInstance(context);
    String userId = session.get(SessionHelper.USER_ID) ?? "0";


    Map data = {
      'user_id': userId,
      'shop_id':widget.shop_id,
      'couponCode':couponController.text.trim().toString()
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

            Helper.moveToScreenwithPushreplaceemt(context,
                ReviewPayment(shop_id: widget.shop_id,
                  coupon:couponController.text.trim().toString(),
                  discount: discount,
                ));


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
