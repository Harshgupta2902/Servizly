import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:serviceapplatest/helper/apis.dart';
import 'package:http/http.dart'as http;
import 'package:serviceapplatest/model/Date_and_Time_model.dart';
import 'package:serviceapplatest/top%20salons/top_salon.dart';
import '../Payment/review_order.dart';
import '../helper/constant.dart';
import '../model/add_booking_details.dart';
import '../model/get_shop_data_modal.dart';
import '../setting/order_details.dart';


class DateTimeScreen extends StatefulWidget {
  String shopId;
  String bookingId;
  String date="";
  String time="";
  String  sum="";

  DateTimeScreen({required this.shopId,required this.bookingId,required this.time,required this.date,required this.sum});

  @override

  State<DateTimeScreen> createState() => _DateTimeScreenState();
}

class _DateTimeScreenState extends State<DateTimeScreen> {

  GetShopDataModal?_getShopDataApi;
  bool _isVisible = false;
  bool _hashData = false;
  DateAndTime? _dateAndTime;
  AddBookingDetailsModal? addBookingDate;
  List selectDateList = [] ;
  List activeTime=[];

  String showDate="";
  String selectTime= '';
  bool _showDocument = true;

  final List<Map> myProducts =
  List.generate(100000, (index) => {"id": index, "name": "Product $index"})
      .toList();
  List<PassionModel> timeList = [
    PassionModel(time: "12:00 AM", ),
    PassionModel(time: "1:00 AM",),
    PassionModel(time: "2:00 AM",),
    PassionModel(time: "3:00 AM",),
    PassionModel(time: "4:00 AM",),
    PassionModel(time: "5:00 AM",),
    PassionModel(time: "6:00 AM",),
    PassionModel(time: "7:00 AM",),
    PassionModel(time: "8:00 AM",),
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
    PassionModel(time: "9:00 PM",),
    PassionModel(time: "10:00 PM",),
    PassionModel(time: "11:00 PM",),
  ];
  final List<WeeknameModel>_listweekname=[

    WeeknameModel(daysname: "Sat", daysnumber: "7"),
    WeeknameModel(daysname: "Sun", daysnumber: "8"),
    WeeknameModel(daysname: "Mon", daysnumber: "9"),
    WeeknameModel(daysname: "Tue", daysnumber: "10"),
    WeeknameModel(daysname: "Wed", daysnumber: "11"),
    WeeknameModel(daysname: "Thr", daysnumber: "12"),
    WeeknameModel(daysname: "Fri", daysnumber: "13"),
  ];
  String _isSelect="";
  String _isSelectDate ="";
  String _isTime="";
  String _selectfinalDate = '' ;
  void initState() {
    // TODO: implement initState
    super.initState();
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String curDate = formatter.format(now);
    print("here dekho===>${curDate.toString()}");
    showDate=curDate;
    Helper.checkInternet(getShopDataApi());
    Helper.checkInternet(getDayesOfweekApi());
    // Helper.checkInternet(addBookingDateApi());
  }
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 100,
        titleSpacing: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Date & Time",
          style: GoogleFonts.poppins(
              textStyle: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.black,
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
      body: Stack(

        children: [
          _dateAndTime == null
              ?_hashData
              ? Container()
              :Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Center(
                  child: Text("No data found",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,color: Colors.black,
                        fontSize: 25
                    ),
                  )
              )) :
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(

              child: Column(

                children: [

                  Container(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      height: MediaQuery.of(context).size.height / 3.4,
                      width: MediaQuery.of(context).size.width,
                      // width: MediaQuery.of(context).size.width/1.1,
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
                        // color: AppColor.textfeildclr,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Date & Time",
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                )),
                          ),
                          Text(
                            "January",
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                )),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          InkWell(
                            onTap: () {
                              // Helper.moveToScreenwithPush(context, OderDetails());


                            },
                            child: Container(
                              //width: MediaQuery.of(context).size.width,
                              height: 80,
                              width: MediaQuery.of(context).size.width,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  // physics: NeverScrollableScrollPhysics(),
                                  padding: EdgeInsets.symmetric(horizontal: 0),
                                  itemCount: _dateAndTime!.datesList!.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    var dateListModel = _dateAndTime!.datesList![index];
                                    return InkWell(
                                        onTap: () {
                                          // Helper.moveToScreenwithPush(context, OderDetails(booking_id: '',shop_id: widget.shopId,));

                                          setState(() {
                                            _isSelect=_dateAndTime!.datesList![index].day!.toString();
                                            _isSelectDate=_dateAndTime!.datesList![index].date!.toString();
                                            print("******IsSeleced${_isSelect}");
                                            print("******Is_Selected_Date${_isSelectDate}");
                                            // _isSelect=_listweekname[index].daysname;
                                            if(_selectfinalDate == dateListModel.date){
                                              _selectfinalDate = '';
                                            }else{
                                              _selectfinalDate = dateListModel.date.toString();
                                              print("date before func===>${_selectfinalDate}");
                                              showDate=_selectfinalDate;
                                              print("dekho===>${_selectfinalDate == dateListModel.date.toString() }");
                                              print("dekho===>${_selectfinalDate.toString()}========= ${dateListModel.date.toString() }");
                                              selectTime="";
                                              getShopDataApi();
                                            }
                                          });
                                        },
                                        child:
                                        _isSelect == _dateAndTime!.datesList![index].day!.toString()
                                            ?
                                        Container(
                                          margin: EdgeInsets.symmetric(horizontal: 10),
                                          height: 100,
                                          width: 80   ,
                                          decoration: BoxDecoration(
                                              color: AppColor.selectTime,
                                              borderRadius: BorderRadius.circular(10),
                                              border: Border.all(color: AppColor.primaryColor)
                                          ),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                _dateAndTime!.datesList![index].day!.toString(),
                                                //  _dateAndTime!.datesList![index].day!.toString(),
                                                style: GoogleFonts.poppins(
                                                    textStyle: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight: FontWeight.w400,
                                                      color: Colors.white,
                                                    )),
                                              ),
                                              Text(
                                                _dateAndTime!.datesList![index].newFormat!.toString(),
                                                //_dateAndTime!.datesList![index].date!.toString(),
                                                style: GoogleFonts.poppins(
                                                    textStyle: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight: FontWeight.w400,
                                                      color:Colors.white,
                                                    )),
                                              ),
                                            ],
                                          ),
                                        ) :
                                        Container(
                                          margin: EdgeInsets.symmetric(horizontal: 10),
                                          height: 100,
                                          width: 80,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              border: Border.all(color: AppColor.primaryColor),
                                              color: Colors.white),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                _dateAndTime!.datesList![index].day!.toString()
                                                ,
                                                // _listweekname[index].daysname,
                                                style: GoogleFonts.poppins(
                                                    textStyle: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight: FontWeight.w400,
                                                      color: Colors.black,
                                                    )),
                                              ),
                                              Text(
                                                _dateAndTime!.datesList![index].newFormat!.toString(),

                                                // _listweekname[index].daysnumber,
                                                style: GoogleFonts.poppins(
                                                    textStyle: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight: FontWeight.w400,
                                                      color: Colors.black,
                                                    )),
                                              ),
                                            ],
                                          ),
                                        )
                                    );
                                  }),
                            ),
                          ),
                        ],
                      )),
                  // ListView.builder(
                  //
                  //      shrinkWrap: true,
                  //      scrollDirection: Axis.vertical,
                  //     physics: NeverScrollableScrollPhysics(),
                  //     //
                  //     padding: EdgeInsets.symmetric(horizontal: 20),
                  //     itemCount: timeList.length,
                  //
                  //     itemBuilder: (BuildContext context, int index) {
                  //
                  //       return InkWell(
                  //         // onTap: () {
                  //         // //  Helper.moveToScreenwithPush(context, ReviewPayment());
                  //         //   activeTime.contains(timeList[index].time)?
                  //         //   setState((){
                  //         //
                  //         //     selectTime=timeList[index].time;
                  //         //     print("selected time ${selectTime}");
                  //         //   });
                  //         // },
                  //         onTap:
                  //         activeTime.contains(timeList[index].time)
                  //
                  //             ? () {
                  //           setState((){
                  //             // if(_isSelected==index) {
                  //             //   _isSelected.remove(index);
                  //             // }
                  //             // else{
                  //             //   _isSelected.add(index);
                  //             // }
                  //             selectTime=timeList[index].time;
                  //             print("selected time ${selectTime}");
                  //
                  //
                  //           });
                  //           print('_isSelected'+ selectTime.toString());
                  //         }
                  //             :(){
                  //           ToastMessage.msg("You can't select this time");
                  //         },
                  //         child: Container(
                  //           decoration: BoxDecoration(
                  //             //border:Border.all(color: Colors.grey, width: 1) ,
                  //               color: activeTime.contains(timeList[index].time)
                  //                   ? selectTime == timeList[index].time ?AppColor.primaryColor:Colors.white
                  //                   : Colors.grey
                  //
                  //               //borderRadius: BorderRadius.circular(30),
                  //
                  //           ),
                  //
                  //           margin: EdgeInsets.symmetric(horizontal: 10),
                  //           height: 80,
                  //           width: 80,
                  //           child: Column(
                  //             crossAxisAlignment: CrossAxisAlignment.start,
                  //             mainAxisAlignment: MainAxisAlignment.center,
                  //             children: [
                  //
                  //               Text(
                  //                 timeList[index].time,
                  //                 style: GoogleFonts.poppins(
                  //                     textStyle: TextStyle(
                  //                       fontSize: 20,
                  //                       fontWeight: FontWeight.w400,
                  //                       color:AppColor.primaryColor,
                  //                     )),
                  //               ),
                  //               Divider(
                  //                 color: Colors.grey,
                  //               )
                  //             ],
                  //           ),
                  //         ),
                  //       );
                  //     }),
                  Container(
                    height: 500,
                    child: Column(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 20,horizontal: 20),
                            child: GridView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                padding: EdgeInsets.zero,
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  childAspectRatio: 2.8,
                                  crossAxisSpacing: 20,
                                  mainAxisSpacing: 20,
                                ),
                                itemCount: timeList.length, //names.length,
                                itemBuilder: (BuildContext ctx, index) {
                                  var textfeildclr;

                                  return Container(
                                    padding:EdgeInsets.symmetric(horizontal: 0) ,
                                    child: InkWell(
                                      onTap:
                                      activeTime.contains(timeList[index].time)

                                          ? () {
                                        setState((){
                                          // if(_isSelected==index) {
                                          //   _isSelected.remove(index);
                                          // }
                                          // else{
                                          //   _isSelected.add(index);
                                          // }
                                          selectTime=timeList[index].time;
                                          print("selected here  time ${selectTime}");


                                        });
                                        print('_isSelected'+ selectTime.toString());
                                      }
                                          :null,

                                      child: Container(
                                        //  padding: EdgeInsets.all(10),
                                          width: 90,
                                          height: 40,
                                          decoration: activeTime.contains(timeList[index].time)
                                              ? selectTime == timeList[index].time ?
                                          BoxDecoration(
                                            border:Border.all(color: Color(0xFFdceef4), width: 2) ,
                                            // color:_isSelect=='5:00 AM'? Colors.amber:Colors.black,
                                            color:  activeTime.contains(timeList[index].time)
                                                ? selectTime == timeList[index].time ?AppColor.selectTime:Color(0xFF8AFF8A)
                                                : Color(0xFFdceef4),
                                            borderRadius: BorderRadius.circular(20),
                                          ) :
                                          BoxDecoration(
                                            border:Border.all(color: Color(0xFF008000), width: 2) ,
                                            // color:_isSelect=='5:00 AM'? Colors.amber:Colors.black,
                                            color:  activeTime.contains(timeList[index].time)
                                                ? selectTime == timeList[index].time ?AppColor.selectTime:Colors.white
                                                : Color(0xFFE9E9E9),
                                            borderRadius: BorderRadius.circular(20),
                                          ):
                                          BoxDecoration(
                                            border:Border.all(color: Color(0xFFdceef4), width: 2) ,
                                            // color:_isSelect=='5:00 AM'? Colors.amber:Colors.black,
                                            color:  activeTime.contains(timeList[index].time)
                                                ? selectTime == timeList[index].time ?AppColor.selectTime:Color(0xFF8AFF8A)
                                                : Color(0xFFdceef4),
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                          child:Center(
                                            child:Text(timeList[index].time,
                                              style: TextStyle(
                                                // color: _isSelect=='5:00 AM'? Colors.black:Colors.white,
                                                  color:  activeTime.contains(timeList[index].time)
                                                      ? selectTime == timeList[index].time ?Colors.white:Colors.black
                                                      : Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500
                                              ),
                                            ),
                                          )
                                      ),
                                    ),
                                  );
                                }
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20,)

                ],
              ),
            ),
          ),
          Positioned(
              bottom: 5,
              left: 15,
              right: 15,
              child:  Padding(
                padding: EdgeInsets.symmetric(horizontal: 0),
                child: InkWell(
                  onTap: (){
                    // _bottomSheetFilter(context);
                  },
                  child: Visibility(
                    maintainAnimation: true,
                    // maintainSize: true,
                    maintainState: true,
                    visible: _showDocument,
                    child:   Center(
                      child: SizedBox(
                          height: 50,
                          width: 200,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: AppColor.selectTime, //background color of button
                                elevation: 3, //elevation of button
                                shape: RoundedRectangleBorder( //to set border radius to button
                                    borderRadius: BorderRadius.circular(30)
                                ),
                                padding: EdgeInsets.all(5) //content padding inside button
                            ),
                            onPressed: (){
                              print("Date ***************${_isSelectDate.toString()}");
                              print("time ***************${_isTime}");
                              print("bookingId=========>${ widget.bookingId}");
                              // print("Booking_id===============>${addBookingDate!.data!.bookingId.toString()}");
                              Helper.checkInternet(addBookingDateApi());

                            },
                            child:  Text("Submit",style:
                            GoogleFonts.poppins(textStyle:
                            TextStyle(fontSize: 16,fontWeight: FontWeight.w500
                              ,color: Colors.white,
                            )
                            ),
                            ),
                          )
                      ),
                    ),
                  ),
                ),
              )),
          Helper.getProgressBarWhite(context, _isVisible)
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

  Future<void>getDayesOfweekApi() async{
    SessionHelper sessionHelper = await SessionHelper.getInstance(context);
    String userId = sessionHelper.get(SessionHelper.USER_ID) ?? "0";
    Map data = {
      'user_id': userId,
      'shop_id': widget.shopId,
    };
    print('*******map data***********${data}*********');
    try{
      var res = await http.post(Uri.parse(Apis.getDaysofWeek), body:data);
      print("************** API Responce ********************${res}");


      if(res.statusCode ==200){
        try{
          final jsonResponse = jsonDecode(res.body);
          DateAndTime model = DateAndTime.fromJson(jsonResponse);
          if (model.status == "true") {
            _hashData = false;
            setState(() {
              _dateAndTime = model;
              _isSelect = _dateAndTime!.datesList![0].day.toString();
              _isSelectDate = _dateAndTime!.datesList![0].date.toString();
              _selectfinalDate = _dateAndTime!.currentDate!.date.toString();
              showDate=_selectfinalDate;
              print("****_selectfinalDate*****${_selectfinalDate}");
              print("****showDate*****${showDate}");
              for(var temp = 0; temp <= _dateAndTime!.datesList!.length-1; temp++){
                print("temp==>${temp.toString()}");
                selectDateList.add(_dateAndTime!.datesList![temp].newFormat);
              }
              _selectfinalDate =_dateAndTime!.currentDate!.date.toString();
              print("***_dateAndTime!.currentDate!.date.toString();***${_dateAndTime!.currentDate!.date.toString()}");
              print("***_selectfinalDate***${_selectfinalDate}");
              showDate=_selectfinalDate;
              print("***showDateRajat***${showDate}");


            });
            print("Model status true");
            setProgress(false);
            _hashData = false;
            ToastMessage.msg(model.message.toString());

          }
          else {
            setProgress(false);
            _hashData = false;
            print("false ### ============>");
            ToastMessage.msg(model.message.toString());
          }

        }
        catch (e) {
          _hashData = false;
          print("false ============>");
          ToastMessage.msg(StaticMessages.API_ERROR);
          print('exception ==> ' + e.toString());
        }
      }
      else {
        _hashData = false;
        print("status code ==> " + res.statusCode.toString());
        ToastMessage.msg(StaticMessages.API_ERROR);
      }
    } catch (e) {
      _hashData = false;
      ToastMessage.msg(StaticMessages.API_ERROR);
      print('Exception ======> ' + e.toString());
    }
  }

  Future<void> addBookingDateApi() async{

    print("*********addBookingDetailsApi********");

    SessionHelper sessionHelper = await SessionHelper.getInstance(context);
    String userId = sessionHelper.get(SessionHelper.USER_ID) ?? "0";

    print("****_isSelectDate*******in API${_isSelectDate}");
    print("****_isSelectTime*******in API${selectTime}");

    Map data = {
      'user_id': userId,
      //'shop_id': widget.shopId,
      'booking_id': widget.bookingId,
      'date':     _isSelectDate,
      'time': selectTime

    };
    print(" **************data***********${data}");

    print("***************data********Addbookingapi  Rajaty******${data}");
    try{
      var res = await http.post(Uri.parse(Apis.addBookingDate), body:data);

      print("*********************res*************${res}****  ${data}*********");

      if(res.statusCode ==200){
        try{
          final jsonResponse = jsonDecode(res.body);
          AddBookingDetailsModal model = AddBookingDetailsModal.fromJson(jsonResponse);
          if (model.status == "true") {
            _hashData = false;

            print("susses");
            setState(() {
              addBookingDate = model;
              Navigator.push(
                  context, CupertinoPageRoute(
                  builder: (context)=>ReviewPayment(shop_id: "shop_id", coupon: "coupon", discount: "discount")
              )
              ).then
                ((value){
                print("date***2*****$selectTime}");
                print("date*2*******${widget.time}");
                Navigator.pop<String>(context,selectTime);
              });

              // Helper.moveToScreenwithPush(context,
              //     ReviewPayment(shop_id: widget.shopId,
              //   booking_id:addBookingDate!.data!.bookingId.toString(), coupon: '', discount: '', date:addBookingDate!.data!.appointmentDate.toString(), time: addBookingDate!.data!.time.toString(), sum: widget.sum,));

            });
            print("Model status true****************addBookingDate************************************");
            setProgress(false);
            _hashData = false;
            ToastMessage.msg(model.message.toString());

          }
          else {
            setProgress(false);
            _hashData = false;
            print("false ### ============>");
            ToastMessage.msg(model.message.toString());
          }

        }
        catch (e) {
          _hashData = false;
          print("false =====error=======>");
          ToastMessage.msg(StaticMessages.API_ERROR);
          print('exception ==> ' + e.toString());
        }
      }
      else {
        _hashData = false;
        print("status code ==> " + res.statusCode.toString());
        ToastMessage.msg(StaticMessages.API_ERROR);
      }
    } catch (e) {
      _hashData = false;
      ToastMessage.msg(StaticMessages.API_ERROR);
      print('Exception ======> ' + e.toString());
    }
  }
  Future<void> getShopDataApi() async {
    _hashData = true;
    setProgress(true);
    //  print("<==============GetProfileApi==================>");

    _hashData = true;
    setProgress(true);

    SessionHelper session = await SessionHelper.getInstance(context);
    String userId = session.get(SessionHelper.USER_ID) ?? "0";


    Map data = {
      'user_id': userId,
      "shop_id": widget.shopId,
    };

    // print("Request =============>" + data.toString());
    try {
      var res = await http.post(Uri.parse(Apis.getShopData), body: data);
      // print("Response ============>" + res.body);

      if (res.statusCode == 200) {
        try {
          final jsonResponse = jsonDecode(res.body);
          GetShopDataModal model = GetShopDataModal.fromJson(jsonResponse);

          if (model.status == "true") {
            _hashData = false;

            setState(() {
              _getShopDataApi = model;
              _isTime =  _getShopDataApi!.shopTiming![0].timing.toString();
              // print("***********shopTiming${_isTime}");
              activeTime.clear();
              var shopTimeOpenClose=_getShopDataApi!.shopTiming![0].timing.toString();
              //   print("*********${shopTimeOpenClose}");
              var tempTimeOpenClose=shopTimeOpenClose.split("-");
              // print("****tempTimeOpenClose*****${tempTimeOpenClose}");

              timeList.forEach((element){
                print("time iin list===>${element.time}");
                DateTime dateTimeFromList = DateFormat('hh:mm a').parse(element.time.toString());

                print("tempTimeOpenClose=0==>${tempTimeOpenClose[0]}");
                print("ttempTimeOpenClose=1==>${tempTimeOpenClose[1]}");


                DateTime dateTimeStart = DateFormat('hh:mm a').parse(tempTimeOpenClose[0].trim().toString());
                DateTime dateTimeEnd = DateFormat('hh:mm a').parse(tempTimeOpenClose[1].trim().toString());
                DateTime dateTimeNow = DateFormat('hh:mm a').parse(DateFormat.jm().format(DateTime.now()));
                print("showdate===>${showDate}");
                // if(showDate==DateTime.now().day)
                var now = new DateTime.now();
                var formatter = new DateFormat('yyyy-MM-dd');
                String formattedDateToday = formatter.format(now);
                print("showDate==1=>${showDate.toString()}");
                print("formattedDateToday==1=>${formattedDateToday.toString()}");
                //   showDate = _dateAndTime!.datesList![0].date.toString();
                if(showDate==formattedDateToday){
                  print("showDate=2==>${showDate.toString()}");
                  print("formattedDateToday=2==>${formattedDateToday.toString()}");
                  if((dateTimeFromList.isAtSameMomentAs(dateTimeStart) || dateTimeFromList.isAfter(dateTimeStart)
                  ) && (dateTimeFromList.isAtSameMomentAs(dateTimeEnd) || dateTimeFromList.isBefore(dateTimeEnd))
                  ){
                    if(dateTimeFromList.isAfter(dateTimeNow)){
                      print("dateTimeFromList= if =>${element.time}");
                      activeTime.add(element.time);
                    }else{
                      print("Do nothing 2");
                    }


                  }else{
                    print("Do nothing");
                  }
                }
                else{
                  print("showDate3=>${showDate.toString()}");
                  print("formattedDateToday=3==>${formattedDateToday.toString()}");
                  if((dateTimeFromList.isAtSameMomentAs(dateTimeStart) || dateTimeFromList.isAfter(dateTimeStart)) &&
                      (dateTimeFromList.isAtSameMomentAs(dateTimeEnd) || dateTimeFromList.isBefore(dateTimeEnd))

                  ){
                    print("dateTimeFromList= else=>${element.time}");
                    activeTime.add(element.time);

                  }else{
                    print("Do nothing");
                  }
                }



              });

            });

            print("Model status true*********rajat");
            setProgress(false);
            _hashData = false;
            ToastMessage.msg(model.message.toString());
          } else {
            setProgress(false);
            _hashData = false;
            print("false ### ============>");
            ToastMessage.msg(model.message.toString());
          }
        } catch (e) {
          _hashData = false;
          print("false ============>");
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
      print('Exception ======> ' + e.toString());
    }
  }

}

class WeeknameModel{
  String daysname="";
  String daysnumber="";

  WeeknameModel({required this.daysname,required this.daysnumber});

}
class PassionModel{


  String time = '';


  PassionModel({required this.time,});
}

