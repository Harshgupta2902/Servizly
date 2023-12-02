import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Registration screen/login.dart';
import '../generated/l10n.dart';
import '../setting/refund_complete_screen.dart';
import 'appointments.dart';
import '../helper/apis.dart';
import '../helper/constant.dart';
import '../helper/image.dart';
import '../model/logout_model.dart';
import '../others/feedback.dart';
import '../setting/about.dart';
import '../setting/add_address_screen.dart';
import '../setting/help_center.dart';
import '../setting/language.dart';
import '../setting/my_review.dart';
import '../setting/profile.dart';
import '../setting/refund.dart';
import '../setting/terms_and_condtion.dart';
import 'package:http/http.dart'as http;

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  bool _hashData = false;
  bool _isVisible = false;
  String _isselect = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        toolbarHeight: 100,
        titleSpacing: 0,
        backgroundColor: Color(0xFFFFFFFF),
        centerTitle: true,
        title: Text(
          S.of(context).Settings,
          style: GoogleFonts.poppins(
              textStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          )),
        ),
      ),
      body: Container(
        color: Color(0xFFf8f8f8),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              InkWell(
                onTap: () {
                  Helper.moveToScreenwithPush(context, Profile());
                  setState(() {
                    _isselect = "1";
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color:   _isselect=="1"? Colors.black12:Colors.transparent,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  child: Row(
                    children: [
                      _isselect == "1"
                          ? Image.asset(
                              ProjectImage.user,
                              height: 30,
                            )
                          : Image.asset(
                              ProjectImage.user,
                              height: 30,
                            ),
                      SizedBox(
                        width: 20,
                      ),
                      _isselect == "1"
                          ? Text(
                        S.of(context).Profile,
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF1D1D1D),
                              )),
                            )
                          : Text(
                        S.of(context).Profile,
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF1D1D1D),
                              )),
                            )
                    ],
                  ),
                ),
              ),
              Divider(
                color: Color(0xFFDBDBDB),
                thickness: 1,
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    _isselect = "2";
                  });
                  Helper.moveToScreenwithPush(context, AddAddressScreen());
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color:   _isselect=="2"? Colors.black12:Colors.transparent,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  child: Row(
                    children: [
                      _isselect == "2"
                          ? Image.asset(
                              ProjectImage.address,
                              height: 30,
                            )
                          : Image.asset(
                              ProjectImage.address,
                              height: 30,
                            ),
                      SizedBox(
                        width: 20,
                      ),
                      _isselect == "2"
                          ? Text(
                        S.of(context).AddAddress,
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF1D1D1D),
                              )),
                            )
                          : Text(
                        S.of(context).AddAddress,
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF1D1D1D),
                              )),
                            )
                    ],
                  ),
                ),
              ),
              Divider(
                color: Color(0xFFDBDBDB),
                thickness: 1,
              ),
              InkWell(
                onTap: () {

                  setState(() {
                    _isselect = "3";
                    Helper.moveToScreenwithPush(context, MyReview());
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color:   _isselect=="3"? Colors.black12:Colors.transparent,
                  ),

                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  child: Row(
                    children: [
                      _isselect == "3"
                          ? Image.asset(
                        ProjectImage.review,
                        height: 30,
                      )
                          : Image.asset(
                        ProjectImage.review,
                        height: 30,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      _isselect == "3"
                          ? Text(
                        S.of(context).MyReviews,
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF1D1D1D),
                            )),
                      )
                          : Text(
                        S.of(context).MyReviews,
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF1D1D1D),
                            )),
                      )
                    ],
                  ),
                ),
              ),
              Divider(
                color: Color(0xFFDBDBDB),
                thickness: 1,
              ),
              InkWell(
                onTap: () {
                  Helper.moveToScreenwithPush(context, LaunguageScreen());
                  // Helper.moveToScreenwithPush(context, Appointments());
                  setState(() {
                    _isselect="4";
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color:   _isselect=="4"? Colors.black12:Colors.transparent,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  child: Row(
                    children: [
                     _isselect=="4"? Image.asset(
                        ProjectImage.language,
                        height: 30,
                      ):Image.asset(
                       ProjectImage.language,
                       height: 30,
                     ),
                      SizedBox(
                        width: 20,
                      ),
                      _isselect=="4"?  Text(
                        S.of(context).Language,
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF1D1D1D),
                        )),
                      ): Text(
                        S.of(context).Language,
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF1D1D1D),
                            )),
                      )
                    ],
                  ),
                ),
              ),
              Divider(
                color: Color(0xFFDBDBDB),
                thickness: 1,
              ),
              InkWell(
                onTap: () {
                  Helper.moveToScreenwithPush(context, TermsConditionScreen());
                  setState(() {
                    _isselect = "5";
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color:   _isselect=="5"? Colors.black12:Colors.transparent,
                  ),

                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  child: Row(
                    children: [
                      _isselect == "5"
                          ? Image.asset(
                        ProjectImage.terms,
                        height: 30,
                      )
                          : Image.asset(
                        ProjectImage.terms,
                        height: 30,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      _isselect == "5"
                          ? Text(
                        S.of(context).TermsAndCondition,
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF1D1D1D),
                            )),
                      )
                          : Text(
                        S.of(context).TermsAndCondition,
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF1D1D1D),
                            )),
                      )
                    ],
                  ),
                ),
              ),
              Divider(
                color: Color(0xFFDBDBDB),
                thickness: 1,
              ),
              InkWell(
                onTap: () {
                  Helper.moveToScreenwithPush(context, RefundCompleteScreen());
                  setState(() {
                    _isselect = "6";
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color:   _isselect=="6"? Colors.black12:Colors.transparent,
                  ),

                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  child: Row(
                    children: [
                      _isselect == "6"
                          ? Image.asset(
                        ProjectImage.refund,
                        height: 30,
                      )
                          : Image.asset(
                        ProjectImage.refund,
                        height: 30,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      _isselect == "6"
                          ? Text(
                        S.of(context).Refund,
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF1D1D1D),
                            )),
                      )
                          : Text(
                        S.of(context).Refund,
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF1D1D1D),
                            )),
                      )
                    ],
                  ),
                ),
              ),
              Divider(
                color: Color(0xFFDBDBDB),
                thickness: 1,
              ),
              InkWell(
                onTap: () {
                  Helper.moveToScreenwithPush(context, About());
                  setState(() {
                    _isselect="7";
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color:   _isselect=="7"? Colors.black12:Colors.transparent,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  child: Row(
                    children: [
                    _isselect=="7"?  Image.asset(
                        ProjectImage.about,
                        height: 30,
                      ): Image.asset(
                      ProjectImage.about,
                      height: 30,
                    ),
                      SizedBox(
                        width: 20,
                      ),
                      _isselect=="7"?  Text(
                        S.of(context).AboutUs,
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                          fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF1D1D1D),
                        )),
                      ):Text(
                        S.of(context).AboutUs,
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF1D1D1D),
                            )),
                      )
                    ],
                  ),
                ),
              ),
              Divider(
                color: Color(0xFFDBDBDB),
                thickness: 1,
              ),
              InkWell(
                onTap: () {
                  Helper.moveToScreenwithPush(context, HelpCenter());
                  setState(() {
                    _isselect="8";
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color:   _isselect=="8"? Colors.black12:Colors.transparent,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  child: Row(
                    children: [
                      _isselect=="8"?     Image.asset(
                        ProjectImage.headphones,
                        height: 30,
                      ): Image.asset(
                        ProjectImage.headphones,
                        height: 30,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      _isselect=="8"?       Text(
                        S.of(context).HelpCenter,
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                          fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF1D1D1D),
                        )),
                      ): Text(
                        S.of(context).HelpCenter,
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF1D1D1D),
                            )),
                      )
                    ],
                  ),
                ),
              ),
              Divider(
                color: Color(0xFFDBDBDB),
                thickness: 1,
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    Helper.checkInternet(showAlertDialog(context, ""));

                    _isselect="9";
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color:   _isselect=="9"? Colors.black12:Colors.transparent,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  child: Row(
                    children: [
                      _isselect=="9" ?   Icon(Icons.delete):Icon(Icons.delete) ,
                    // Image.asset(
                      //   ProjectImage.logoutunselected,
                      //   height: 30,
                      // ),

                      SizedBox(
                        width: 20,
                      ),
                      _isselect=="9"?    Text(
                        S.of(context).DeleteAccount,
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            )),
                      ): Text(
                        S.of(context).DeleteAccount,
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            )),
                      )
                    ],
                  ),
                ),
              ),
              Divider(
                color: Color(0xFFDBDBDB),
                thickness: 1,
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    Helper.checkInternet(LogoutApi());

                    _isselect="10";
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color:   _isselect=="10"? Colors.black12:Colors.transparent,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  child: Row(
                    children: [
                      _isselect=="10" ?    Image.asset(
                        ProjectImage.logout,
                        height: 30,
                      ): Image.asset(
                        ProjectImage.logoutunselected,
                        height: 30,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      _isselect=="10"?    Text(
                        S.of(context).log_Out,
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                          fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFFF14656),
                        )),
                      ): Text(
                        S.of(context).log_Out,
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFFF14656),
                            )),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context, String whichImage) {

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      scrollable: false,
      insetPadding: EdgeInsets.symmetric(horizontal: 0),
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Container(
          padding: EdgeInsets.symmetric(horizontal:  20,vertical: 20),
          margin: EdgeInsets.only(top: 50),
          height: MediaQuery.of(context).size.height/4,
          width: 380,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.white),
          child:
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(S.of(context).DeleteAccount,style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFFEB4738),
                  )),),
              SizedBox(height: 20),
              Text(S.of(context).WantToDelete,
                style: GoogleFonts.poppins(
                    color: Color(0xFF474747),
                    fontWeight: FontWeight.w600,
                    fontSize: 15
                ),
              ),
              SizedBox(height: 30),


              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MaterialButton(
                    color: Colors.white,
                    minWidth: 100,
                    height: 45,
                    textColor: Colors.black  ,
                    child: Text(S.of(context).Cancel,
                      style: GoogleFonts.poppins(
                          color:Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 17
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    onPressed: () {
                      // deleteImage(whichImage);
                      Helper.popScreen(context);
                      print("which image---->${whichImage}");
                    },
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  MaterialButton(
                    color: Colors.white,
                    minWidth: 100,
                    height: 45,
                    textColor: Colors.white,
                    child: Text(S.of(context).Delete,
                      style: GoogleFonts.poppins(
                          color:Colors.red,
                          fontWeight: FontWeight.w600,
                          fontSize: 17
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    onPressed: () {
                    Helper.checkInternet( deleteApi());

                    },
                  ),
                ],
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
  Future<void> LogoutApi() async {
    void setProgress(bool check) {
      setState(() {
        _isVisible = check;
      });
    }
    setProgress(true);

    print("<=============Logout api================>");

    SessionHelper sessionHelper =await SessionHelper.getInstance(context);
    var user_id  =  sessionHelper.get(SessionHelper.USER_ID);
    Map values = {
      'user_id':user_id
    };

    try {
      print(values);

      var res = await http.post(Uri.parse(Apis.logout),body: values);

      print(res.body);

      if (res.statusCode == 200) {

        try {

          final jsonResponse = jsonDecode(res.body);

          LogoutModel model = LogoutModel.fromJson(jsonResponse);

          print(model.status);

          if (model.status == 'true') {

            print("---------------------login");

            // Helper.moveToScreenwithPush
            //   (context, OtpScreen(number: numberController.text.toString(),));
            SessionHelper().clear();
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                LoginScreen()), (Route<dynamic> route) => false);
            //
            // SessionHelper sessionHelper = await SessionHelper.getInstance(context);
            // sessionHelper.put(SessionHelper.USER_ID,model.data!.userId.toString());
            // sessionHelper.put(SessionHelper.EMAIL,model.data!.email.toString());
            // sessionHelper.put(SessionHelper.IMAGE,model.data!.image.toString());

            setProgress(false);
            ToastMessage.msg(model.message.toString());



          } else {
            setProgress(false);
            ToastMessage.msg(model.message.toString());
          }
        } catch (e) {
          print('hello + $e');
        }
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteApi() async {
    void setProgress(bool check) {
      setState(() {
        _isVisible = check;
      });
    }
    setProgress(true);

    print("<=============Logout api================>");

    SessionHelper sessionHelper =await SessionHelper.getInstance(context);
    var user_id  =  sessionHelper.get(SessionHelper.USER_ID);
    Map values = {
      'user_id':user_id
    };

    try {
      print(values);

      var res = await http.post(Uri.parse(Apis.deleteAccount),body: values);

      print(res.body);

      if (res.statusCode == 200) {

        try {

          final jsonResponse = jsonDecode(res.body);

          LogoutModel model = LogoutModel.fromJson(jsonResponse);

          print(model.status);

          if (model.status == 'true') {

            print("---------------------login");

            // Helper.moveToScreenwithPush
            //   (context, OtpScreen(number: numberController.text.toString(),));
            // SessionHelper().clear();
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                LoginScreen()), (Route<dynamic> route) => false);

            // SessionHelper sessionHelper = await SessionHelper.getInstance(context);
            // sessionHelper.put(SessionHelper.USER_ID,model.data!.userId.toString());
            // sessionHelper.put(SessionHelper.EMAIL,model.data!.email.toString());
            // sessionHelper.put(SessionHelper.IMAGE,model.data!.image.toString());

            setProgress(false);
            ToastMessage.msg(model.message.toString());



          } else {
            setProgress(false);
            ToastMessage.msg(model.message.toString());
          }
        } catch (e) {
          print('hello + $e');
        }
      }
    } catch (e) {
      print(e);
    }
  }

  setProgress(bool show) {
    if (mounted)
      setState(() {
        _isVisible = show;
      });

  }
}
