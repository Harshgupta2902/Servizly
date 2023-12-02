import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart'as http;
import '../generated/l10n.dart';
import '../helper/apis.dart';
import '../helper/constant.dart';
import '../helper/image.dart';
import '../model/login_model.dart';
import 'otp_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController numberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isVisible=false;
  bool isValidated = false;
  String deviceToken="";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDeviceTokenToSendNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 80),
                    child: Text(
                      "Log In",
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
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
                                offset: Offset(0, 1), // changes position of shadow
                              ),
                            ],
                            // color: AppColor.textfeildclr,
                          ),
                          child: TextFormField(
                              textInputAction: TextInputAction.done,
                              inputFormatters: [LengthLimitingTextInputFormatter(10)],
                              keyboardType: TextInputType.number,
                              cursorColor: Colors.white,
                               controller: numberController,
                              decoration: InputDecoration(
                                hintText: S.of(context).Mobileno,
                                hintStyle:
                                GoogleFonts.poppins(
                                    textStyle:const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey,
                                    ),
                                ),
                                contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
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
                              style: const TextStyle(
                                color: Colors.black,
                              ),

                            validator: (value) {
                              if (numberController.text.isEmpty) {
                                ToastMessage.msg ("${S.of(context).Pleaseenternumber}");
                              }
                              else if(numberController.text.length<10  || numberController.text.length >10 ){
                                ToastMessage.msg(S.of(context).Numberlimit);
                              }else {
                                isValidated  = true;
                              }

                            },
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        MaterialButton(
                          color: Color(0xFF0ABDFC),
                          minWidth: 340,
                          height: 50,
                          textColor: Colors.white,
                          child: Text(S.of(context).Submit,
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w500),
                              )),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          onPressed: () {
                            if (_formKey.currentState!.validate() && isValidated == true) {
                              isValidated  = false;
                              _formKey.currentState!.save();
                              Helper.checkInternet(LoginApi());

                              // if (_formkey.currentState!.validate()) {
                              //   _formkey.currentState!.save();
                              // Helper.moveToScreenwithPush(
                              //     context, const VerificationScreen());
                            }


                          },
                        ),
                        Container(
                            padding: EdgeInsets.symmetric(vertical: 120),
                            child: Image.asset(ProjectImage.Cleaning))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void setProgress(bool check) {
    setState(() {
      _isVisible = check;
    });
  }

  Future<void> getDeviceTokenToSendNotification() async {
    final FirebaseMessaging _fcm = FirebaseMessaging.instance;
    final token = await _fcm.getToken();
    deviceToken = token.toString();
    setState(() {
      deviceToken = token.toString();
    });
    print("Token Value $deviceToken");
  }

  Future<void> LoginApi() async {

    setProgress(true);

    print("<=============LoginApi================>");

    Map values = {
      'phone':numberController.text.trim().toString(),
      'device_token': deviceToken
    };

    try {
      print(values);

      var res = await http.post(Uri.parse(Apis.login),body: values);

      print(res.body);

      if (res.statusCode == 200) {

        try {

          final jsonResponse = jsonDecode(res.body);

          LoginModel model = LoginModel.fromJson(jsonResponse);

          print(model.status);

          if (model.status == 'true') {


            setProgress(false);
            ToastMessage.msg(model.message.toString());
            Helper.moveToScreenwithPush(
                context, OtpScreen(number: numberController.text,));
            // Helper.moveToScreenwithPush(context, OTP(phone: model.data!.phone.toString(),));



          } else {
            setProgress(false);
            if(model.message.toString()=="email not verified"){
              ToastMessage.msg(model.message.toString());
            }else{
              ToastMessage.msg(model.message.toString());
            }

          }
        } catch (e) {
          print('hello + $e');
        }
      }
    } catch (e) {
      print(e);
    }
  }
}
