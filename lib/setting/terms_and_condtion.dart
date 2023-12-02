import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';import 'package:serviceapplatest/helper/constant.dart';

import '../helper/apis.dart';
import '../helper/image.dart';
import '../model/term_condition_model.dart';
import 'package:http/http.dart'as http;

class TermsConditionScreen extends StatefulWidget {
  const TermsConditionScreen({Key? key}) : super(key: key);

  @override
  State<TermsConditionScreen> createState() => _TermsConditionScreenState();
}

class _TermsConditionScreenState extends State<TermsConditionScreen> {
  bool _hashData = false;
  bool _isVisible = false;
  TermConditionModel?_termConditionModel;
  void initState() {
    // TODO: implement initState
    super.initState();
    Helper.checkInternet(termsconditionapi());
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
          "Terms and condition",
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
      body:_termConditionModel == null
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
              ))): Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image.asset(ProjectImage.terms,
              //   height: 200,
              //   width: MediaQuery.of(context).size.width/2,
              //   fit: BoxFit.fill,),
              Center(child: Image.asset(ProjectImage.terms2)),
              SizedBox(height: 20,),
              Text(
                  _termConditionModel!.terms![0].terms.toString(),
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    )
                ),
              ),
              // SizedBox(height: 20,),
              // MaterialButton(
              //   color: Color(0xFF09BDFC),
              //   minWidth: MediaQuery.of(context).size.width,
              //   height: 55,
              //   textColor: Colors.white,
              //   child: Text("I Agree",
              //     style: GoogleFonts.poppins(
              //         color: Colors.white,
              //         fontWeight: FontWeight.w600,
              //         fontSize: 18
              //     ),
              //   ),
              //   shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(30)),
              //   onPressed: () {
              //   },
              // ),

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
  Future<void> termsconditionapi() async {
    print("<=============termsconditionapi =============>");

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
      var res = await http.post(Uri.parse(Apis.getTerms), body: data);
      print("Response ============>" + res.body);

      if (res.statusCode == 200) {
        print("jaydeep ============>");
        try {
          final jsonResponse = jsonDecode(res.body);
          TermConditionModel model = TermConditionModel.fromJson(jsonResponse);

          if (model.status == "true") {
            print("Model status true");

            setProgress(false);
            _hashData = false;

            setState(() {
              _termConditionModel = model;

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
