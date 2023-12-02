import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart'as http;
import 'package:serviceapplatest/helper/constant.dart';
import '../helper/apis.dart';
import '../helper/image.dart';
import '../model/add_review_model.dart';

class FeedBack extends StatefulWidget {
  const FeedBack({Key? key}) : super(key: key);

  @override
  State<FeedBack> createState() => _FeedBackState();
}

class _FeedBackState extends State<FeedBack> {
  bool _hashData = false;
  bool _isVisible = false;
  AddReviewModel?_addReviewModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Colors.white, //Scaffold background color...........................
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 100, //Appbar Size........................
        titleSpacing: 0,
        backgroundColor: Color(0xFFf5f5f5),
        centerTitle: true,
        title: Text(
          "FeedBack",
          style: GoogleFonts.poppins(
              textStyle: TextStyle(
            //Use GoogleFonts....................
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          )),
        ),
        leading: InkWell(
          onTap: () {
             Helper.popScreen(context);
          },
          //Containe For Round Back Buttone........................
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
      body: Stack(children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  Image.asset(
                    ProjectImage.feedbackrating,
                    height: 130,
                    width: 280,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0.0,vertical: 0),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      margin: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                      decoration: BoxDecoration(
                        color: Color(0xFFffffff),
                        border: Border.all(width: 1, color: Color(0xFFbdbdbd)),
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                             "Add photo",
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                )),
                          ),
                          Image.asset(
                            ProjectImage.tabImage,
                            height: 40,
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0.0,vertical: 0),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      margin: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                      decoration: BoxDecoration(
                        color: Color(0xFFffffff),
                        border: Border.all(width: 1, color: Color(0xFFbdbdbd)),
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                      ),
                      child: Text(
                        "Give Rating",
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            )),
                      ),
                    ),
                  ),
                  // Align(
                  //   alignment: AlignmentDirectional(-0.7, 0.0),
                  //   child: Container(
                  //     padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  //     decoration: BoxDecoration(
                  //       color: Color(0xFFffffff),
                  //       border: Border.all(width: 1, color: Colors.black),
                  //       borderRadius: BorderRadius.all(Radius.circular(50)),
                  //     ),
                  //     child: Row(
                  //       children: [
                  //         Text(
                  //           "Give Rating",
                  //           style: TextStyle(
                  //               color: Colors.black, fontWeight: FontWeight.w500),
                  //         )
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  SizedBox(
                    height: 10,
                  ),
                  RatingBar.builder(
                    itemSize: 45,
                    initialRating: 3,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    glowRadius: 30.0,
                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      print(rating);
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0.0,vertical: 0),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      margin: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                      decoration: BoxDecoration(
                        color: Color(0xFFffffff),
                        border: Border.all(width: 1, color: Color(0xFFbdbdbd)),
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                      ),
                      child: Text(
                        "Write Review",
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            )),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
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
                    child: TextField(
                      maxLines: 4,
                      decoration: InputDecoration(
                        hintText: "Type Something...",
                        hintStyle: TextStyle(fontSize: 16),
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 0, color: Colors.transparent),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none),
                        disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(30)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(30)),
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(30)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  MaterialButton(
                    color: Color(0xFF0ABDFC),
                    minWidth: 340,
                    height: 50,
                    textColor: Colors.white,
                    child: Text("Submit",
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        )),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    onPressed: () {

                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }

  setProgress(bool show) {
    if (mounted)
      setState(() {
        _isVisible = show;
      });
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
      var res = await http.post(Uri.parse(Apis.addReview), body: data);
      print("Response ============>" + res.body);

      if (res.statusCode == 200) {
        print("urvashi ============>");
        try {
          final jsonResponse = jsonDecode(res.body);
          AddReviewModel model = AddReviewModel.fromJson(jsonResponse);

          if (model.status == "true") {
            print("Model status true");

            setProgress(false);
            _hashData = false;

            setState(() {
              _addReviewModel = model;
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
}
