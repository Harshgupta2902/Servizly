import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:serviceapplatest/bottom_screens/bottom.dart';
import 'package:serviceapplatest/helper/image.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:http/http.dart' as http;
import '../helper/apis.dart';

import 'package:serviceapplatest/helper/constant.dart';
import '../Registration screen/date_time.dart';
import '../model/reschedule_appointment_model.dart';

class RescheduleAppointmentPage extends StatefulWidget {



  String shop_id = "";
  String date = "";
  String time = "";
  String booking_id = "";

  RescheduleAppointmentPage(
      {required this.shop_id,
        required this.date,
        required this.time,
        required this.booking_id,
      });
  @override
  State<RescheduleAppointmentPage> createState() => _RescheduleAppointmentPageState();
}

class _RescheduleAppointmentPageState extends State<RescheduleAppointmentPage> {
  TextEditingController reasonController = TextEditingController();

  DateTime today = DateTime.now();
  bool _hashData = false;
  bool _isVisible = false;
  void _onDaySelected(DateTime day, DateTime focusedDay){
    setState(() {
      today = day;
    });
  }
  List<PassionModel> timeList = [
    PassionModel(time: "9:00 AM",),
    PassionModel(time: "10:00 AM",),
    PassionModel(time: "11:00 AM",),
    PassionModel(time: "12:00 PM",),
    PassionModel(time: "1:00 PM",),
    PassionModel(time: "2:00 PM",),
    PassionModel(time: "3:00 PM",),
    PassionModel(time: "4:00 PM",),
    PassionModel(time: "5:00 PM",),
    PassionModel(time: "6:00 PM",),
    PassionModel(time: "7:00 PM",),
    PassionModel(time: "8:00 PM",),
  ];
  String selectedTime = "";
  // String selectedTime = widget.time;
  RescheduleAppointmentModel? _rescheduleAppointmentModel;
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
          "Reschedule Appointment",
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
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Center(child: Text("Selected Date is " + today.toString().split(" ")[0])),
              // Center(child: Text("Selected Time is: $selectedTime")),
              /////////Calendar////////
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Container(
                  child: TableCalendar(
                    // enablePastDays: false,
                    locale: "en_US",
                    focusedDay: today,
                    firstDay: DateTime.now(),
                    lastDay: DateTime.now().add(Duration(days: 7)),
                    headerStyle: HeaderStyle(formatButtonVisible: false, titleCentered: true),
                    availableGestures: AvailableGestures.all,
                    onDaySelected: _onDaySelected,
                    selectedDayPredicate: (day) => isSameDay(day, today),
                    calendarFormat: CalendarFormat.twoWeeks,
                  ),
                ),
              ),
              SizedBox(height: 15,),
              Divider(thickness: 1,),
              SizedBox(height: 15,),
              ///////Time/////////
              Container(

                height: 60,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: timeList.length, //n
                    itemBuilder: (BuildContext ctx, index) {
                      // selectedTime = widget.time;
                      return Container(
                        height: 50,
                        width: 90,
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap:
                                  () {
                                setState(() {
                                  // print(new DateFormat('dd/MM/yyyy').parse(widget.date));
                                  // selectedTime = widget.time;
                                  selectedTime = timeList[index].time;
                                  print(selectedTime);
                                  // endTime = timeList[index+1].time;
                                  // isVisible = true;
                                });
                              },
                              child: Container(
                                decoration: selectedTime == timeList[index].time?
                                BoxDecoration(
                                    color:  Colors.white,
                                    borderRadius: BorderRadius.circular(30),
                                    border: Border.all(color: Color(0XFF4337AF),width: 2)
                                ):
                                BoxDecoration(
                                    color:  Colors.grey.shade50,
                                    borderRadius: BorderRadius.circular(30)
                                ),
                                child: Center(child: Text(timeList[index].time)),
                              ),
                            )
                        ),
                      );
                    }
                ),
              ),
              SizedBox(height: 15,),
              Divider(thickness: 1,),
              ///////Reason/////////
              TextFormField(
                  controller: reasonController,
                  keyboardType: TextInputType.text,
                  cursorColor: Colors.white,
                  maxLines: 5,
                  maxLength: 100,
                  // enabled: false,
                  // controller: phoneController,
                  decoration: InputDecoration(
                    // errorText: "Enter Reason",
                    hintText: "Enter Your Reason for Rescheduling",
                    hintStyle: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                    ),
                    // hintMaxLines: 5,
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    filled: true,
                    fillColor: Colors.transparent,
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
                  textInputAction: TextInputAction.done,
                  ),
              SizedBox(height: 15,),
              ///////Button/////////
              MaterialButton(
                color: Color(0xFF07A9B1),
                minWidth: 100,
                height: 45,
                textColor: Colors.white,
                child: Text("Reschedule",
                  style: GoogleFonts.poppins(
                      color:Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 17
                  ),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                onPressed: () {
                  showAlertDialog( context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> RescheduleAppointmentAPI() async {
    print("<==============RescheduleAppointmentAPI==================>");

    _hashData = true;
    setProgressWhite(true);

    SessionHelper session = await SessionHelper.getInstance(context);
    String userId = session.get(SessionHelper.USER_ID) ?? "0";

    Map data = {
    "user_id": userId,
    "booking_id":widget.booking_id,
    "rescheduleDate":today.toString().split(" ")[0],
    "rescheduleTime":selectedTime,
    "rescheduleReason":reasonController.text.trim().toString()
    };
    print("Request =============>" + data.toString());
    try {
      var res = await http.post(Uri.parse(Apis.rescheduleAppointment), body: data);
      print("Response get ===RescheduleAppointmentAPI=======>" + res.body);

      if (res.statusCode == 200) {
        try {
          final jsonResponse = jsonDecode(res.body);
          RescheduleAppointmentModel model = RescheduleAppointmentModel.fromJson(jsonResponse);

          print("model true");

          if (model.status == "true") {
            setState(() {
              _rescheduleAppointmentModel = model;
            });
            Helper.popScreen(context);
            Helper.moveToScreenwithPushreplaceemt(context, Bottom());

            setProgressWhite(false);
            _hashData = false;
            ToastMessage.msg(model.message.toString());
          }
          else {
            setProgressWhite(false);
            _hashData = false;
            print("false ### =====RescheduleAppointmentAPI=1======>");
            ToastMessage.msg(model.message.toString());
          }
        } catch (e) {
          _hashData = false;
          print("false =======RescheduleAppointmentAPI=2====>");
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
      print('Exception ==RescheduleAppointmentAPI====> ' + e.toString());
    }
  }
  setProgressWhite(bool show) {
    if (mounted)
      setState(() {
        _isVisible = show;
      });
  }
  showAlertDialog(BuildContext context) {
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      scrollable: false,
      insetPadding: EdgeInsets.symmetric(horizontal: 0),
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Container(
          padding: EdgeInsets.symmetric(horizontal:  20,vertical: 20),
          margin: EdgeInsets.only(top: 50),
          height: 200,
          width: 380,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.white),
          child:
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(ProjectImage.rescheduling, height: 50,width: 50,),
              SizedBox(height: 15),
              Text("Do you want to Reschedule Your Appointment",
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
                    color: Color(0xFF07A9B1),
                    minWidth: 100,
                    height: 45,
                    textColor: Colors.white  ,
                    child: Text("Cancel",
                      style: GoogleFonts.poppins(
                          color:Colors.white,
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
                    color: Color(0xFF07A9B1),
                    minWidth: 100,
                    height: 45,
                    textColor: Colors.white,
                    child: Text("Reschedule",
                      style: GoogleFonts.poppins(
                          color:Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 17
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    onPressed: () {
                      Helper.checkInternet(RescheduleAppointmentAPI());
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



}
