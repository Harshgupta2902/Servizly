
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';



class AppColor {
  static  Color primaryColor = const Color(0xFF222222);
  static  Color greytext = const Color(0xFF7A7A7A);
  static  Color starclr = const Color(0xFFFFCC00);
  static  Color selectTime = const Color(0xFF09bdfc);
  static  Color unSelected = const Color(0xFFF5FEFD);

  static  Color ontap = const Color(0xff666666);
  static  Color container = const Color(0xff333333);
  static  Color red = const Color(0xffF02252);
  static  Color green = const Color(0xff3CE4A3);
  static  Color textbelow = const Color(0xFFfef6f6);
  static  Color primaryTextXColor = const Color(0xFF455959);
  static  Color pickupLoction = const Color(0xFF4285f4);
  static  Color CFDclr = const Color(0xffe7273b);
  static  Color CFDclrr = const Color(0xffd218ae);
  static  Color inprgesstop = const Color(0xff5cc99f);
  static  Color inprogreeclrr = const Color(0xff99da83);
  static  Color inprogreebotm = const Color(0xff5bd576);
  static  Color orderdetailclr = const Color(0xfffee6e4);
  static  Color mdgbor = const Color(0xfffD4D4D4);
  static  Color shadow = const Color(0xfffFF6B00);
  static  Color textcolor = const Color(0xff1F1F1F);

  // Urvashi

  static  Color btn = const Color(0xff3b9ad1);
  static  Color personaltxtclr = const Color(0xffded9d9);
  static  Color btnlinear = const Color(0xff3dbff5);
  static  Color cleanclr = const Color(0xffe3edfe);
  static  Color xclrclean = const Color(0xff82aef8);
  static  Color greytxt = const Color(0xffd8d8d8);
  static  Color finalordergreentxt = const Color(0xffcae8c8);
  static  Color acceptcontainer = const Color(0xff6ec569);
  static  Color shirtcontainer = const Color(0xfff4f4f4);
  static  Color deliverd = const Color(0xffdde9fd);


  //Pankaj Devda
  static  Color OrderColor = const Color(0xfffce8e8);





}


class SessionHelper {
  static late SharedPreferences sharedPreferences;

  static late SessionHelper _sessionHelper;

  // USER
  static const String USER_ID = "USER_ID";
  static const String NAME = "NAME";
  static const String NUMBER = "NUMBER";
  static const String EMAIL = "EMAIL";
  static const String IMAGE = "IMAGE";
  static const String LATITUDE = "LATITUDE";
  static const String LONGITUDE = "LONGITUDE";
  static const String LANGAUGE = "LANGAUGE";
  static const String PASTSELECTLANGUAGESESSION = "PASTSELECTLANGUAGESESSION";




  static Future<SessionHelper> getInstance(BuildContext context) async {
    _sessionHelper = new SessionHelper();
    sharedPreferences = await SharedPreferences.getInstance();

    return _sessionHelper;
  }

  String? get(String key) {
    return sharedPreferences.getString(key);
  }

  put(String key, String value) {
    sharedPreferences.setString(key, value);
  }

  clear() {
    sharedPreferences.clear();
  }
  remove(String key) {
    sharedPreferences.remove(key);
  }
}


class Helper {

  /*================ progress bar ================*/

  static Widget progressBar(BuildContext context, bool _isVisible){

    return Visibility(
        maintainSize: true,
        maintainAnimation: true,
        maintainState: true,
        visible: _isVisible,
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          // margin: EdgeInsets.only(top: 20),
          color: Colors.black54,
          child: Center(
             child: SpinKitSpinningLines(size: 60.0, color: AppColor.primaryColor, lineWidth: 3,),
          ),
        )
    );
  }

  static Widget getProgressBarWhite(BuildContext context, bool _isVisible){

    return Visibility(
        maintainSize: true,
        maintainAnimation: true,
        maintainState: true,
        visible: _isVisible,
        child: Container(
          margin: EdgeInsets.only(top: 20),
          child: Center(
             child: SpinKitSpinningLines(size: 60.0, color: Colors.black, lineWidth: 3,),
          ),
        )
    );
  }


  /*================ check Internet ================*/

  static Future<void> checkInternet(Future<dynamic> callback) async{

    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {

      callback.asStream();
      // callback.call();

    } else {
      Fluttertoast.showToast(msg: StaticMessages.CHECK_INTERNET);
    }
  }

  static Future<bool> internet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      return true ;
      // callback.call();

    } else {
      Fluttertoast.showToast( msg:StaticMessages.CHECK_INTERNET);
      return false ;
    }
  }

  /*================ next Focus ================*/

  static void nextFocus(BuildContext context, FocusNode currentFocus,FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  /*================ open web ================*/

  // static Future<bool> launchUrl(String url) async{
  //
  //   if (await canLaunch(url)) {
  //     await launch(url);
  //     return true;
  //   } else {
  //     print( 'Could not launch $url');
  //     return false;
  //   }
  // }

  /*================ for navigation ================*/

  static Future<void> moveToScreenwithPush(BuildContext context, dynamic nextscreen) async{
    await Navigator.push(context, MaterialPageRoute(builder: (context) => nextscreen));
  }

  static moveToScreenwithPushreplaceemt(BuildContext context, dynamic nextscreen){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => nextscreen));
  }


  static moveToScreenwithRoutClear(BuildContext context, nextscreen){

    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
        nextscreen()), (Route<dynamic> route) => false);
  }

  static popScreen(BuildContext context){
    Navigator.pop(context);
  }
/*================ for navigation ================*/


/*================ share sheet ================*/


// static  void  shareSheet(  BuildContext context,String shareData)  {
//   {
//     Share.share(shareData);
//     // Share.share(shareData, subject: 'Look what I made!');
//     //  Share.shareFiles([shareData], text: 'Great picture');
//     // Share.shareFiles([shareData, shareData]);
//
//   }
// }

}

class StaticMessages {
  static const CHECK_INTERNET = "Please Check Internet Connection.";
  static const API_ERROR = "Somethig went worng";
}
/*================ ToastMessage ================*/


class ToastMessage {
  static void msg(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        fontSize: 16.0,
         backgroundColor: Colors.transparent,
        textColor: Colors.black);
  }

  static void alertmsg(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        fontSize: 16.0,
         backgroundColor: Colors.transparent,
        textColor: Colors.black);
  }
}
 class CoustomeWidget extends StatelessWidget {
   String  text ='';

   @override
   Widget build(BuildContext context) {
     return Container(
           child: AlertDialog(
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
                     Text("Delete Account ? ",style: GoogleFonts.poppins(
                         textStyle: TextStyle(
                           fontSize: 20,
                           fontWeight: FontWeight.w500,
                           color: Color(0xFFEB4738),
                         )),),
                     SizedBox(height: 20),
                     Text("Want to delete?",
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
                           child: Text("Cancel",
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
                           child: Text("Delete",
                             style: GoogleFonts.poppins(
                                 color:Colors.red,
                                 fontWeight: FontWeight.w600,
                                 fontSize: 17
                             ),
                           ),
                           shape: RoundedRectangleBorder(
                               borderRadius: BorderRadius.circular(30)),
                           onPressed: () {


                           },
                         ),
                       ],
                     )
                   ],
                 )
             ),
           ),
     );
   }

 }
