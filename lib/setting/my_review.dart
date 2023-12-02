import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart'as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:serviceapplatest/helper/constant.dart';

import '../generated/l10n.dart';
import '../helper/apis.dart';
import '../helper/image.dart';
import '../model/get_review_model.dart';

class MyReview extends StatefulWidget {
  const MyReview({Key? key}) : super(key: key);

  @override
  State<MyReview> createState() => _MyReviewState();
}

class _MyReviewState extends State<MyReview> {
  bool _hashData = false;
  bool _isVisible = false;
  GetReviewModel?_getReviewModel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Helper.checkInternet(MyreviewApi());
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
          S.of(context).MyReviews,
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

        ],
      ),
      body: Stack(
        children: [
          _getReviewModel == null
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
                        fontSize: 25),
                  )))
              : Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
             child: ListView.builder(
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.symmetric(horizontal: 0),
                //itemCount: _offermodel.length,
                itemCount:  _getReviewModel!.userReviews!.length,
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
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ClipOval(
                                  child: Container(
                                    color: Colors.transparent,
                                    child: CachedNetworkImage(
                                      imageUrl: _getReviewModel!.userReviews![index].image.toString() ,
                                      //widget.image,
                                      fit: BoxFit.fill,
                                      width: 60,
                                      height: 60,
                                      placeholder: (context, url) =>
                                          LinearProgressIndicator(
                                            color: Colors.grey.withOpacity(0.2),
                                            backgroundColor:
                                            Colors.grey.withOpacity(.5),
                                          ),
                                      errorWidget: (context, url, error) =>
                                          Container(
                                            width: 60,
                                            height: 60,

                                            // padding: EdgeInsets.symmetric(vertical: 25.0),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(20),
                                                ),
                                                color: Color(0xFFD9D9D9)),
                                            child: Center(
                                              child: Icon(
                                                Icons.person,
                                                size: 30,
                                                color: AppColor.primaryColor,
                                              ),
                                              // child: Image.asset(ProjectImage.meditation_girl3,
                                              //   width: 150, height: 300,fit: BoxFit.cover,),
                                            ),
                                          ),
                                    ),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(_getReviewModel!.userReviews![index].saloonName.toString(),
                                      style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xFF525252),
                                          )),
                                    ),
                                    Text(_getReviewModel!.userReviews![index].comment.toString(),
                                      style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xFF525252),
                                          )),
                                    ),
                                  ],
                                ),
                                RatingBar.builder(
                                  initialRating: double.parse(_getReviewModel!.userReviews![index].rating.toString()),
                                  minRating: 1,
                                  itemSize: 15,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  ignoreGestures: true,
                                  itemCount: 5,
                                  itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                                  itemBuilder: (context, _) => Icon(
                                    Icons.star,
                                    color: Color(0xFFFFCC00),
                                  ),
                                  onRatingUpdate: (rating) {
                                    print(rating);
                                  },
                                )

                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),

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

  Future<void> MyreviewApi() async {
    print("<=============MyreviewApi =============>");

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
      var res = await http.post(Uri.parse(Apis.getMyReviews), body: data);
      print("Response ============>" + res.body);

      if (res.statusCode == 200) {
        print("jaydeep ============>");
        try {
          final jsonResponse = jsonDecode(res.body);
          GetReviewModel model = GetReviewModel.fromJson(jsonResponse);

          if (model.status == "true") {
            print("Model status true");

            setProgress(false);
            _hashData = false;

            setState(() {
              _getReviewModel=model;
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
