import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:http/http.dart'as http;
import 'package:pinput/pinput.dart';
import '../generated/l10n.dart';
import '../helper/apis.dart';
import '../helper/constant.dart';
import '../helper/image.dart';
import '../model/otp_model.dart';
import 'enable_location.dart';

class OtpScreen extends StatefulWidget {
  String number="";
     OtpScreen({required this.number});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {

  bool _isVisible=false;
  Timer? _timer;
  int _start = 60;

  TextEditingController otpController = TextEditingController();

   CountdownTimerController? controller;


  @override
  void initState() {
    super.initState();
    startTimer();

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child:  Padding(
          padding:  EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 50),
                  child: Text(
                    S.of(context).EnterOTP,
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        )),
                  ),
                ),
                Container(
                  margin:EdgeInsets.symmetric(horizontal: 10) ,
                  width: MediaQuery.of(context).size.width,
                  child: Pinput(
                    length: 6,
                    controller: otpController,
                    forceErrorState: true,
                    errorText: '',
                    defaultPinTheme: PinTheme(
                        width: 60,
                        textStyle: TextStyle(color: Colors.black,fontSize: 22),
                        height: 60,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.transparent,
                            border: Border.all(color: Colors.grey)
                        )
                    ),
                    keyboardType: TextInputType.number,

                    // controller: otpController,
                    validator: (pin)

                    {
                      if (pin!.length < 6) return null;
                      return 'Pin can not be less than 4 digit';
                    },
                  ),
                ),
                Text("${S.of(context).OTPExpire} ${_start} sec",
                  style: GoogleFonts.poppins(
                    color: Color(0xFF1D1D1D),
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
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
                  child: Text(S.of(context).Submit,
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      )),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  onPressed: () {
                    Helper.checkInternet(OtpApi());
                    // Helper.moveToScreenwithPushreplaceemt(
                    //     context, LocationScreen());
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                MaterialButton(
                  color:Color(0xFFFFFFFF),
                  minWidth: 150,
                  height: 45,
                  textColor: Color(0xFF1D1D1D),
                  child: Text(S.of(context).ResendOtp,
                    style: GoogleFonts.poppins(
                        color: Color(0xFF1D1D1D),
                        fontWeight: FontWeight.w600,
                        fontSize: 15
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  onPressed: () {
                    setState(() {
                      if(_start==0){
                        _start=60;
                        startTimer();
                        // resendVerificationCode("+91"+widget.number, widget.forceResendingToken);
                      }
                    });
                  },
                ),
                Container(
                    padding: EdgeInsets.symmetric(vertical: 120),
                    child: Image.asset(ProjectImage.Cleaning)),

              ],
            ),
          ),
        ),







      ),
    );
  }

  Future<void> OtpApi() async {
    void setProgress(bool check) {
      setState(() {
        _isVisible = check;
      });
    }
    setProgress(true);

    print("<=============otpApi================>");



    Map values = {
      'phone':widget.number,
      'otp':otpController.text.toString()
    };

    try {
      print(values);

      var res = await http.post(Uri.parse(Apis.verifyOtp),body: values);

      print(res.body);

      if (res.statusCode == 200) {

        try {

          final jsonResponse = jsonDecode(res.body);

          OtpModel model = OtpModel.fromJson(jsonResponse);

          print(model.status);

          if (model.status == 'true') {

            print("---------------------login");

            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                LocationScreen()), (Route<dynamic> route) => false);

            // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
            //     HomeBottom()), (Route<dynamic> route) => false);
            //
            SessionHelper sessionHelper = await SessionHelper.getInstance(context);
            sessionHelper.put(SessionHelper.USER_ID,model.data!.userId.toString());
            // sessionHelper.put(SessionHelper.NAME,model.data![0]!.name.toString());
            // sessionHelper.put(SessionHelper.DOB,model.data![0].dob.toString());
            // sessionHelper.put(SessionHelper.IMAGE,model.data![0].image![0].toString());
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

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
          (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();

          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }




}
