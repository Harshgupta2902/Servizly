import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:serviceapplatest/bookings/reschedule_appintment.dart';
import 'package:serviceapplatest/helper/apis.dart';
import '../generated/l10n.dart';
import '../helper/constant.dart';
import '../helper/image.dart';
import 'package:http/http.dart' as http;
import '../model/appointment_model.dart';
import '../model/cancelled_model.dart';
import 'package:url_launcher/url_launcher.dart';


class Ongoing extends StatefulWidget {
  const Ongoing({Key? key}) : super(key: key);

  @override
  State<Ongoing> createState() => _OngoingState();
}

class _OngoingState extends State<Ongoing>{


  AppointmentListModel ?_appointmentListModel;
  bool _hashData = false;
  bool _isVisible = false;
  String booking_id="";
String service = "";
  final List<OfferModel> _offermodel = [
    OfferModel(image: ProjectImage.comb, name: "Hair Salon"),
    OfferModel(image: ProjectImage.girlappointment, name: "Nail Salon"),
    // OfferModel(image: ProjectImage.comb, name: "Hair Salon"),
    // OfferModel(image: ProjectImage.girlappointment, name: "Nail Salon"),
  ];



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     Helper.checkInternet(AppointmentListApi());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Stack(
        children: [
          _appointmentListModel == null ?
          _hashData ?
          Container() :
          Container(
            child: Center(
              child: Text(S.of(context).NoDataFound),
            ),
          ) :
          Container(
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.symmetric(horizontal: 0),
                //itemCount: _offermodel.length,
                itemCount:  _appointmentListModel!.bookingList!.length,
                itemBuilder: (BuildContext context, int index) {

                  final input =_appointmentListModel!.bookingList![index].service.toString();
                  final removedBrackets = input.substring(1, input.length - 1);
                  final parts = removedBrackets.split('[]');

                  var joined = parts.map((part) => "$part").join('[]');

                  print("join====================>${joined}");
                  service =  _appointmentListModel!.bookingList![index].service.toString().replaceAll('[', '').replaceAll(']', '');
                  print(service);

                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    height:150,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Container(
                            height: 150,
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
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      ClipOval(
                                        child: Container(
                                          color: Colors.transparent,
                                          child: CachedNetworkImage(
                                            imageUrl: _appointmentListModel!.bookingList![index].image.toString() ,
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
                                          Text(_appointmentListModel!.bookingList![index].saloonName.toString(),
                                            style: GoogleFonts.poppins(
                                                textStyle: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  color: Color(0xFF525252),
                                                )),
                                          ),
                                          Text(
                                            "${_appointmentListModel!.bookingList![index].appointmentDate.toString()} at ${_appointmentListModel!.bookingList![index].time.toString()}",
                                            style: GoogleFonts.poppins(
                                                textStyle: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color(0xFF838383),
                                                )),
                                          ),
                                          Text(
                                            service,
                                            // _appointmentListModel!.bookingList![index].service!.replaceAll(RegExp(r'\(|\)'), '').toString(),
                                            style: GoogleFonts.poppins(
                                                textStyle: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color: AppColor.greytext,
                                                )),
                                          ),
                                        ],
                                      ),
                                      InkWell(
                                        onTap: () {
                                          _makePhoneCall("8764485661");
                                        },
                                        child: Image.asset(ProjectImage.phone,height: 30,))
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          booking_id=_appointmentListModel!.bookingList![index].bookingId.toString();
                                          print("booking_id********************* ${booking_id}");
                                          showAlertDialog(context, booking_id);

                                        },
                                        child: Container(
                                          padding: EdgeInsetsDirectional.symmetric(horizontal: 10),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(25),
                                            border: Border.all(color: Colors.grey)
                                          ),
                                          height: 40,
                                          // width: 180,
                                          child: Center(
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                // Image.asset(ProjectImage.,height: 20,),
                                               Icon(Icons.delete,size: 20,),
                                                SizedBox(width: 5,),
                                                Text(S.of(context).CancelAppointments,
                                                    style: GoogleFonts.poppins(
                                                      textStyle: TextStyle(
                                                          fontSize: 14, fontWeight: FontWeight.w600),
                                                    )),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          print("${_appointmentListModel!.bookingList![index].shopId.toString()}");
                                          print("${_appointmentListModel!.bookingList![index].appointmentDate.toString()}");
                                          print("${_appointmentListModel!.bookingList![index].time.toString()}");
                                          print("${_appointmentListModel!.bookingList![index].bookingId.toString()}");
                                          Helper.moveToScreenwithPush(
                                              context, RescheduleAppointmentPage(
                                              shop_id: _appointmentListModel!.bookingList![index].shopId.toString(),
                                              date: _appointmentListModel!.bookingList![index].appointmentDate.toString(),
                                              time: _appointmentListModel!.bookingList![index].time.toString(),
                                              booking_id: _appointmentListModel!.bookingList![index].bookingId.toString()
                                          )
                                          );
                                        },
                                        child: Container(
                                          padding: EdgeInsetsDirectional.symmetric(horizontal: 10),

                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(25),
                                            color: Color(0xFF07A9B1),

                                          ),
                                          height: 40,
                                          child: Center(
                                            child: Text(S.of(context).Reschedule,
                                                style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                      fontSize: 15, fontWeight: FontWeight.w600),
                                                )),
                                          ),

                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
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

  Future<void> CancelledApi(String id) async {
    print("<=============CancelledApi =============>");

    SessionHelper sessionHelper = await SessionHelper.getInstance(context);
    String userId = sessionHelper.get(SessionHelper.USER_ID) ?? "0";

    print("<=============userId =============>" + userId);
    _hashData = true;
    setProgress(true);

    Map data = {
      'user_id': userId,
      'booking_id':id
    };

    print("Request =============>" + data.toString());
    try {
      var res = await http.post(Uri.parse(Apis.CancelAppointment), body: data);
      print("Response ============>" + res.body);

      if (res.statusCode == 200) {

        try {
          final jsonResponse = jsonDecode(res.body);
          CancelledModel model = CancelledModel.fromJson(jsonResponse);

          if (model.status == "true") {
            print("Model status true");
            setProgress(false);
            _hashData = false;

            setState(() {
              Helper.checkInternet(AppointmentListApi());
              Helper.popScreen(context);
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

  Future<void> AppointmentListApi() async {
    print("<=============AppointmentListApi =============>");

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
      var res = await http.post(Uri.parse(Apis.AppointmentList), body: data);
      print("Response ============>" + res.body);

      if (res.statusCode == 200) {

        try {
          final jsonResponse = jsonDecode(res.body);
          AppointmentListModel model = AppointmentListModel.fromJson(jsonResponse);

          if (model.status == "true") {
            print("Model status true");

            setProgress(false);
            _hashData = false;

            setState(() {
              _appointmentListModel=model;
              // service =  _appointmentListModel!.bookingList!.service.toString().replaceAll('[', '').replaceAll(']', '');
              // print("${service}");
            });

            // ToastMessage.msg(model.message.toString());
          } else {
            _appointmentListModel=null;

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

  showAlertDialog(BuildContext context, String id) {

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      scrollable: false,
      insetPadding: EdgeInsets.symmetric(horizontal: 0),
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Container(
          padding: EdgeInsets.symmetric(horizontal:  20,vertical: 20),
          margin: EdgeInsets.only(top: 50),
          height: 250,
          width: 380,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.white),
          child:
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Cancel Appointment ",style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFFEB4738),
                  )),),
              SizedBox(height: 20),
              Text("All the Services of previous saloon will be removed from card",
                style: GoogleFonts.poppins(
                    color: Color(0xFF474747),
                    fontWeight: FontWeight.w400,
                    fontSize: 15
                ),
              ),
              SizedBox(height: 20),
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
                          color:Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 17
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    onPressed: () {
                      Helper.checkInternet(CancelledApi(id));
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

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }
}

class OfferModel {
  String image = "";
  String name = "";

  OfferModel({required this.image, required this.name});
}
