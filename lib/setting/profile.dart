import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import '../generated/l10n.dart';
import '../helper/apis.dart';
import '../model/get_profile_model.dart';
import 'edit_profile.dart';
import '../helper/constant.dart';
import '../helper/image.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  bool _hashData = false;
  bool _isVisible = false;
  String img="";
  File? _image;
  GetProfileModel? _getprofileModel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Helper.checkInternet(getprofileApi());
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
        title:_getprofileModel==null?Container(): Text(
          _getprofileModel!.data!.name == "" ? "User" : _getprofileModel!.data!.name.toString(),
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
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: InkWell(
                onTap: () {
                  Helper.moveToScreenwithPush(context, EditProfile());
                },
                child: Image.asset(
                  ProjectImage.editprofile,
                  height: 40,
                  width: 40,
                )),
          ),
        ],
      ),
      body: Stack(
        children: [
          _getprofileModel == null
              ? _hashData
                  ? Container()
                  : Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                          child: Text(
                            S.of(context).NoDetailsFound,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 25),
                      )))
              : Container(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: Container(
                            decoration: BoxDecoration(boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(1),
                                  blurRadius: 10,
                                  offset: Offset(0, 1))
                            ], shape: BoxShape.circle),
                            height: 80,
                            width: 80,
                            child: Stack(
                              children: [
                                ClipOval(
                                  child:CachedNetworkImage(
                                          imageUrl:img.isEmpty?"":img.toString(),

                                          // _getprofileModel!
                                          //         .data!.image!.isEmpty
                                          //     ? ""
                                          //     : _getprofileModel!.data!.image!
                                          //         .toString(),
                                          fit: BoxFit.fill,
                                          width: 80,
                                          height: 80,
                                          placeholder: (context, url) =>
                                              LinearProgressIndicator(
                                            color:
                                                Colors.white.withOpacity(0.2),
                                            backgroundColor:
                                                Colors.white.withOpacity(.5),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              Container(
                                            width: 100,
                                            height: 100,
                                            // padding: EdgeInsets.symmetric(vertical: 25.0),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(20),
                                                ),
                                                color: Color(0xFFD9D9D9)),
                                            child: Center(
                                              child: Icon(
                                                Icons.person,
                                                size: 40,
                                                color: AppColor.primaryColor,
                                              ),
                                            ),
                                          ),
                                        )
                                ),
                                // Positioned(
                                //   bottom: 0,
                                //     right: 0,
                                //     child: InkWell(
                                //       onTap: () {
                                //         Helper.moveToScreenwithPush(context, EditProfile(image: _profileModel!.userData![0].image.toString(),));
                                //       },
                                //         child: Icon(Icons.circle_rounded,color: AppColor.primaryColor,size: 25,)))
                              ],
                            ),
                          ),
                        ),

                        Text(
                          S.of(context).Name,
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          )),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          // width: MediaQuery.of(context).size.width/1.1,
                          decoration: BoxDecoration(
                            // border: Border.all(color: AppColor.secondaryColor, width: 2),
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 2,
                                offset:
                                    Offset(0, 1), // changes position of shadow
                              ),
                            ],
                            // color: AppColor.textfeildclr,
                          ),

                          child: TextFormField(
                              controller: nameController,
                              keyboardType: TextInputType.text,
                              cursorColor: Colors.white,
                              enabled: false,
                              // controller: phoneController,
                              decoration: InputDecoration(
                                hintText: _getprofileModel!.data!.name
                                            .toString() ==
                                        ""
                                    ? "Enter Your Name"
                                    : _getprofileModel!.data!.name.toString(),
                                hintStyle: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey,
                                  ),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
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
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                              textInputAction: TextInputAction.next,
                              validator: (name) {
                                if (name!.isEmpty) {
                                  return "Please enter name";
                                } else if (name.length > 3) {
                                  return "Name must be of minimum 3 letters";
                                }
                              }),
                        ),

                        SizedBox(
                          height: 20,
                        ),

                        Text(
                          S.of(context).MobileNumber,
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          )),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          // width: MediaQuery.of(context).size.width/1.1,
                          decoration: BoxDecoration(
                            // border: Border.all(color: AppColor.secondaryColor, width: 2),
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 2,
                                offset:
                                    Offset(0, 1), // changes position of shadow
                              ),
                            ],
                            // color: AppColor.textfeildclr,
                          ),

                          child: TextFormField(
                              controller: phoneController,
                              keyboardType: TextInputType.text,
                              cursorColor: Colors.white,
                              enabled: false,
                              // controller: phoneController,
                              decoration: InputDecoration(
                                hintText: _getprofileModel!.data!.phone
                                            .toString() ==
                                        ""
                                    ? "Phone Number"
                                    : _getprofileModel!.data!.phone.toString(),
                                hintStyle: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey,
                                  ),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
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
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                              textInputAction: TextInputAction.next,
                              validator: (name) {
                                if (name!.isEmpty) {
                                  return "Please enter number";
                                } else if (name.length != 10) {
                                  return "Name must be of 10 digits";
                                }
                              }),
                        ),

                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          S.of(context).EmailAddress,
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          )),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          // width: MediaQuery.of(context).size.width/1.1,
                          decoration: BoxDecoration(
                            // border: Border.all(color: AppColor.secondaryColor, width: 2),
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 2,
                                offset:
                                    Offset(0, 1), // changes position of shadow
                              ),
                            ],
                            // color: AppColor.textfeildclr,
                          ),

                          child: TextFormField(
                              controller: emailController,
                              keyboardType: TextInputType.text,
                              cursorColor: Colors.white,
                              enabled: false,
                              decoration: InputDecoration(
                                hintText: _getprofileModel!.data!.email
                                            .toString() ==
                                        ""
                                    ? "Email"
                                    : _getprofileModel!.data!.email.toString(),
                                hintStyle: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey,
                                  ),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
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
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                              textInputAction: TextInputAction.next,
                              validator: (name) {
                                if (name!.isEmpty) {
                                  return "Please enter name";
                                } else if (name.length > 3) {
                                  return "Name must be of minimum 3 letters";
                                }
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
              nameController.text = _getprofileModel!.data!.name.toString();
              phoneController.text = _getprofileModel!.data!.phone.toString();
              emailController.text = _getprofileModel!.data!.email.toString();
                img= _getprofileModel!.data!.image.toString();
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
