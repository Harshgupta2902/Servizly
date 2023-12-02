import 'dart:convert';
// import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:http/http.dart' as http;
// import 'package:dotted_border/dotted_border.dart';
import 'package:fdottedline_nullsafety/fdottedline__nullsafety.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:intl/intl.dart';
import 'package:serviceapplatest/Payment/booking_details_page_at_home.dart';
// import 'package:serviceapplatest/Payment/add_new_address.dart';
import 'package:serviceapplatest/model/add_amount_coupon_model.dart';
import 'package:serviceapplatest/model/edite_booked_service_modal.dart';
import 'package:serviceapplatest/model/get_cart_details_model.dart';
// import 'package:serviceapplatest/top%20salons/top_salon.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:serviceapplatest/helper/constant.dart';
import '../Registration screen/date_time.dart';
import '../bottom_screens/bottom.dart';
import '../generated/l10n.dart';
import '../helper/apis.dart';
import '../helper/image.dart';
import '../model/add_booking_address_model.dart';
import '../model/add_booking_model.dart';
import '../model/add_service_model.dart';
import '../model/delete_coupon_model.dart';
import '../model/edit_booked_service_model.dart';
import '../model/get_Book_Totalmodal.dart';
import '../model/get_address_model.dart';
import '../model/get_card_details_model.dart';
import '../model/get_shop_detail_model.dart';
import '../model/get_shop_offer_model.dart';
import '../model/pay_booking_amount_model.dart';
import '../model/review_appointment_model.dart';
import '../setting/add_address_screen.dart';
import '../setting/apply_coupon.dart';
import '../top salons/top_salon.dart';
import 'addnewcard.dart';
import 'all_card.dart';
import 'package:lottie/lottie.dart';

import 'booking_details_page_at_shop.dart';



class ReviewPayment extends StatefulWidget {
  String shop_id = "";
  String coupon = "";
  String discount = "";

  ReviewPayment(
      {required this.shop_id,
        required this.coupon,
        required this.discount,
       });

  @override
  State<ReviewPayment> createState() => _ReviewPaymentState();
}

class _ReviewPaymentState extends State<ReviewPayment> {
  GlobalKey<ScaffoldState> _scaffoldKey =
  GlobalKey(); // Global Key Varialble.......................

  TextEditingController textFieldController = TextEditingController();
  // final formatter = DateFormat('dd-MM-yyyy');
  // DateTime selectedDate = DateTime.now();
  // String formattedDate = formatter.format(selectedDate);
  DateTime today = DateTime.now();

  void _onDaySelected(DateTime day, DateTime focusedDay){
    setState(() {
      today = day;
    });
  }
  var isVisible = false;
  String selectedTime = "9:00 AM";
  // String endTime = "10:00 AM";
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

  List activeTime=[];
  String selectTime= '';


  String _selectPlace = "";
  //  var index;

  bool _showDocument = true;
  bool _hashData = false;
  bool _isVisible = false;

  double price = 0.0;
  double check = 0.0;
  double total = 0.0;
  double famount = 0.0;
  double cal = 0;

  String num = "10";
  String dateAndTime = "";

  String selectAddress = "";
  String selectLandmark = "";
  String address = "";
  String location = "";
  String type = "";

  List totalPrice = [];
  int totalAmount = 0;
  List services = [];
  List prices = [];
  List isItemInList = [];


  ReviewAppointmentModel? _reviewAppointmentModel;

  GetShopOfferModel? _getShopOfferModel;
  EditeBookedService? _editBookedService;
  GetAddressModel? _getaddressmodel;

  // AddAmountCouponModel? _addAmountCouponModel;

  AddBookingAddressModel? _addBookingAddressModel;

  GetCardDetailsModel? _getCardDetailsModel;
  GetCartDetailsModel? _getCartDetailsModel;
  PayBookingAmountModel? _payBookingAmountModel;
  deleteCouponModel? _deleteCouponModel;
  double percentage = 0;
  get time => null;
  get date => null;

  String cards = "";

  double offAmount = 0.0;

  EditBookedServiceModel?_editBookedServiceModel;
  GetBookTotal? _getBookTotalmodal;
  Getshopdetailmodel?_getshopdetailmodel;



  int newSum = 0;
  int count=0;
  var addserviceparameter = "";

  AddServiceModel? _addServiceModel;
  AddBookingModel? _addBookingModel;
  AddAmountCouponModel? _addAmountCouponModel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Helper.checkInternet(getaddressApi());
    Helper.checkInternet(getCartDetails());
    // Helper.checkInternet(getshopofferApi());
    _showDocument = false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () =>  loadData(),
      child: Scaffold(
        key: _scaffoldKey, // scaffoldkey..................................
        // backgroundColor: Colors.white,
        backgroundColor: Color(0xFFe9e9e9),
        body: SafeArea(
            child: _getCartDetailsModel == null
              ? _hashData
              ? Container()
              : Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                      child: Text(
                        S.of(context).NoDataFound,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 25
                        ),
                      )
                  )
              )
              : _getCartDetailsModel!.totalServices == "0"
              ?Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(ProjectImage.emptycart),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) =>
                                  Bottom()),
                              (Route<dynamic> route) => false);
                    },
                    child: Container(
                      height: 35,
                        width: 70,
                        decoration: BoxDecoration(
                          color: Colors.cyan,
                          borderRadius: BorderRadius.circular(12)
                        ),
                        child: Center(child: Text(S.of(context).Home,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20
                        ),))),
                  )
                ],
              ),
            )
              :Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          height: 40,
                          width: MediaQuery.of(context).size.width,
                          // color: Colors.green,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10, left: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap:(){
                                    Helper.moveToScreenwithPush(context, TopSalon(shop_id: _getCartDetailsModel!.cartData![0].shopId.toString(), totalAmount: _getCartDetailsModel!.sum.toString()));
                                  },
                                    child: Icon(Icons.arrow_back,size: 20,)),
                                SizedBox(width: 8,),
                                Text(S.of(context).BookServices,
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87
                                ),)),
                              ],
                            ),
                          ),
                        ),
                        Divider(
                          color: Colors.grey,thickness: 1,
                        ),
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
                                return Container(
                                  height: 50,
                                  width: 90,
                                  child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: InkWell(
                                        onTap:
                                            () {
                                          setState(() {
                                            selectedTime = timeList[index].time;
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
                        /////////Items//////////////
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              physics: NeverScrollableScrollPhysics(),
                              // padding: EdgeInsets.symmetric(horizontal: 10),
                              // padding: EdgeInsets.only(top: 10),
                              shrinkWrap: true,
                              itemCount:_getCartDetailsModel!.cartData!.length,
                              itemBuilder: (BuildContext context, int index) {
                                // print("index*****${index}");
                                return Container(
                                    margin: EdgeInsets.only(top: 10),
                                    height: 65,
                                    padding: EdgeInsets.symmetric(horizontal: 0, vertical: 15),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.grey.shade50,
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                          children: [

                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                  ProjectImage.haircutlogo,
                                                  height: 30,
                                                ),
                                                SizedBox(width: 10),
                                                Text(
                                                  _getCartDetailsModel!.cartData![index].serviceDetails!.serviceName.toString(),
                                                  style: GoogleFonts.poppins(
                                                      textStyle: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w500,
                                                        color: (Color(0xFF222222)),
                                                      )),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(today.toString().split(" ")[0],
                                                      style: TextStyle(
                                                          color: Colors.grey
                                                      ),)
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Text("$selectedTime",
                                                      style: TextStyle(
                                                          color: Colors.grey
                                                      ),)
                                                  ],
                                                )
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Row(
                                                  // mainAxisAlignment: MainAxisAlignment.center,
                                                  // crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    Icon(Icons.currency_rupee, size: 15,),
                                                    // Image.asset(
                                                    //   ProjectImage.rupeeSimbol,
                                                    //   width: 15,
                                                    // ),
                                                    Text(
                                                      _getCartDetailsModel!.cartData![index].serviceDetails!.price.toString(),
                                                      style: GoogleFonts.poppins(
                                                          textStyle: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight: FontWeight.bold,
                                                            color: (Color(0xFF222222)),
                                                          )),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            InkWell(
                                              //On Tab of Trashbin Delete alert Box Open.
                                              onTap: () {
                                                addserviceparameter = "1";
                                                _showDocument = true;
                                                Helper.checkInternet(AddservicesApi(
                                                    _getCartDetailsModel!.cartData![index].cartId.toString(),
                                                    _getCartDetailsModel!.cartData![index].serviceDetails!.serviceId.toString()
                                                )
                                                );
                                              }, // Image tapped
                                              child: Image.asset(
                                                ProjectImage.trashbin,
                                                height: 30,
                                              ),
                                            ),

                                          ],
                                        ),
                                      ],
                                    ));
                              }
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ///////Add Services Button///////////
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            children: [
                              InkWell(
                                  onTap: (){
                                    // Helper.popScreen(context);
                                    Helper.moveToScreenwithPush(context, TopSalon(shop_id: widget.shop_id, totalAmount: famount.toString()));
                                    // Helper.pop(context, );
                                  },
                                  child: Text("+ ${S.of(context).AddServices}",style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold ,color: Color(0XFF07A9B1)),))
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: () {
                            Helper.moveToScreenwithPush(context, ApplyCoupon(shop_id: _getCartDetailsModel!.cartData![0].shopId.toString(), totalAmount: _getCartDetailsModel!.totalAmount.toString()));
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric( horizontal: 15),
                            child: Container(
                              height: 74,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey.shade50,
                              ),
                              child: Container(
                                child: Padding(
                                  padding: const EdgeInsets.all(25.0),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        // mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Image.asset(
                                            ProjectImage.offer,
                                            // height: 25,
                                            // width: 25,
                                          ),

                                          SizedBox(
                                            width: 10,
                                            height: 10,
                                          ),

                                          Text(
                                            _getCartDetailsModel!.coupons!.offer.toString() == ""
                                                ? S.of(context).ApplyCoupon
                                                : _getCartDetailsModel!.coupons!.offer.toString(),
                                            style: GoogleFonts.poppins(
                                                textStyle: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  color: (Color(0xFF3a3a3a)),
                                                )),
                                          ),

                                          SizedBox(
                                            width: 15,
                                          ),
                                        ],
                                      ),
                                      _getCartDetailsModel!.coupons!.offer.toString().isEmpty
                                          ?Icon(Icons.arrow_forward_ios)
                                          :InkWell(
                                          onTap: () {
                                            Helper.checkInternet(deleteCouponApi());
                                          },
                                          child: Icon(Icons.delete))
                                      //Image.asset(ProjectImage.calendarSym,height: 20,),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(
                          height: 20,
                        ),

                        //Bill and Details Container.................................................
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            children: [
                              Text(
                                S.of(context).BillDetails,
                                style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: (Color(0xFF3a3a3a)),
                                    )),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Container(
                              height: 250,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey.shade100,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 2,
                                    blurRadius: 2,
                                    offset: Offset(
                                        0, 1), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 25.0, vertical: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          S.of(context).ItemTotal,
                                          style: GoogleFonts.poppins(
                                              textStyle: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                color: (Color(0xFF222222)),
                                              )),
                                        ),
                                        Row(
                                          children: [
                                            Image.asset(
                                              ProjectImage.rupeeSimbol,
                                              width: 15,
                                            ),
                                            Text(
                                              _getCartDetailsModel!.sum.toString(),
                                              style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                    color: (Color(0xFF222222)),
                                                  )),
                                            ),
                                          ],
                                        )
                                        //Image.asset(ProjectImage.calendarSym,height: 20,),
                                      ],
                                    ),
                                  ),
                                  _getCartDetailsModel!.totalDiscount.toString() == "0"
                                  ?Container()
                                  :Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 25.0, vertical: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 200,
                                          child: Text(
                                            S.of(context).Discount,
                                            style: GoogleFonts.poppins(
                                                textStyle: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  color: (Color(0xFF3a3a3a)),
                                                )),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Image.asset(
                                              ProjectImage.rupeeSimbol,
                                              width: 15,
                                            ),
                                            // Text(check.toString()),
                                            Text(_getCartDetailsModel!.totalDiscount.toString(),
                                              style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                    color: (Color(0xFF222222)),
                                                  )),),
                                          ],
                                        )
                                        //Image.asset(ProjectImage.calendarSym,height: 20,),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 25.0, vertical: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 200,
                                          child: Text(
                                            S.of(context).GST,
                                            style: GoogleFonts.poppins(
                                                textStyle: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  color: (Color(0xFF3a3a3a)),
                                                )),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Image.asset(
                                              ProjectImage.rupeeSimbol,
                                              width: 15,
                                            ),
                                            Text(_getCartDetailsModel!.totalTax.toString(),
                                              style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                    color: (Color(0xFF222222)),
                                                  )),),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: DottedLine(
                                      //DottedLine in Container.............
                                      direction: Axis.horizontal,
                                      lineLength: double.infinity,
                                      lineThickness: 2.0,
                                      dashLength: 2.0,
                                      dashColor: Color(0xFFbababa),
                                      // dashGradient: [Colors.red, Colors.blue],
                                      dashRadius: 0.0,
                                      dashGapLength: 2.0,
                                      dashGapColor: Colors.transparent,
                                      //dashGapGradient: [Colors.red, Colors.blue],
                                      dashGapRadius: 0.0,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                      children: [
                                        Container(
                                          width: 200,
                                          child: Text(
                                            S.of(context).Topay,
                                            style: GoogleFonts.poppins(
                                                textStyle: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: (Color(0xFF3a3a3a)),
                                                )),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Image.asset(
                                              ProjectImage.rupeeSimbol,
                                              width: 15,
                                            ),
                                            Text(
                                              _getCartDetailsModel!.totalAmount.toString(),
                                              style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    color: (Color(0xFF3a3a3a)),
                                                  )),
                                            ),
                                          ],
                                        )
                                        //Image.asset(ProjectImage.calendarSym,height: 20,),
                                      ],
                                    ),
                                  ),

                                ],
                              )),
                        ),
                        SizedBox(
                          height: 80,
                        ),
                      ],
                    ),
                  ),
                ),
                //Radio Buttone At shope & Home Visit.........................................
                Positioned(
                    bottom: 0,
                    child: Container(
                      height: 65,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Color(0XFF07A9B1)
                        // borderRadius: BorderRadius.circular(15)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            onTap: () {
                              Helper.checkInternet(AddBookingApi2());
                              // showAlertDialog(context);
                              setState(() {
                                _selectPlace = S.of(context).AtShop;
                                //_showDocument=true;
                              });
                            },
                            child: Row(
                              children: [
                                _selectPlace == S.of(context).AtShop
                                    ? Icon(Icons.radio_button_checked_rounded,
                                    color: AppColor.green, size: 18)
                                    : Icon(Icons.radio_button_off,
                                    size: 18,
                                    color: AppColor.primaryColor),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "At Shop",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              _bottomSheetHomeVisit(context);
                              print("amit=============>");

                              setState(() {
                                _selectPlace = S.of(context).HomeVisit;
                              });
                            },
                            child: Row(
                              children: [
                                _selectPlace == S.of(context).HomeVisit
                                    ? Icon(Icons.radio_button_checked_rounded,
                                    color: AppColor.green, size: 18)
                                    : Icon(Icons.radio_button_off,
                                    size: 18,
                                    color: AppColor.primaryColor),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Home visit",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                ),
              ],
            ),
          ),
        ),
    );

  }


  void calculation() {
    print("Calculate..1.....");
    setState(() {
      // for (int i = 0; i < _reviewAppointmentModel!.bookingDetails!.servicePrice!.length;i++)
      totalAmount = 0;
      for (int i = 0; i < _getCartDetailsModel!.cartData!.length;i++)
      {
        print("_getCartDetailsModel!.cartData![i].serviceDetails!.price.toString() ${_getCartDetailsModel!.cartData![i].serviceDetails!.price.toString()}");
        print("before totalAmount ${totalAmount}");
        totalAmount = totalAmount +int.parse(_getCartDetailsModel!.cartData![i].serviceDetails!.price.toString());
        print("..after TotalAmount..${totalAmount}...");
        famount = totalAmount + 10;

      }
    });
  }

  void calculate() {
    print("============Calculate=================");
    setState(() {
      totalAmount = 0;
      for (int i = 0; i < _getCartDetailsModel!.cartData!.length;i++)
      {
        print("_getCartDetailsModel!.cartData![i].serviceDetails!.price.toString() ${_getCartDetailsModel!.cartData![i].serviceDetails!.price.toString()}");
        print("before totalAmount ${totalAmount}");
        totalAmount = totalAmount +int.parse(_getCartDetailsModel!.cartData![i].serviceDetails!.price.toString());
        print("..after TotalAmount..${totalAmount}...");
      }
      check = (totalAmount * int.parse(widget.discount)) / 100;
      print("discount------------>${widget.discount}");
      print("checkAmount------------>${check.toString()}");
      // print("discount-----Model------->${_reviewAppointmentModel!.couponData!.offerOff.toString()}");
      famount = totalAmount - double.parse(check.toString()) + 10;
      print("total Amount===================>${total}}");
    });
  }

  Future<void> getCartDetails() async {
    print("<==============getCartDetails==================>");

    _hashData = true;
    setProgressWhite(true);

    SessionHelper session = await SessionHelper.getInstance(context);
    String userId = session.get(SessionHelper.USER_ID) ?? "0";

    Map data = {'user_id': userId};
    print("Request =============>" + data.toString());
    try {
      var res = await http.post(Uri.parse(Apis.getCartDetails), body: data);
      print("Response get ===getCartDetails=======>" + res.body);

      if (res.statusCode == 200) {
        try {
          final jsonResponse = jsonDecode(res.body);
          GetCartDetailsModel model = GetCartDetailsModel.fromJson(jsonResponse);

          print("amit=========1");

          if (model.status == "true") {
            setState(() {
              _getCartDetailsModel = model;
              print("_getCartDetailsModel!.cartData!.length ${_getCartDetailsModel!.cartData!.length}");
              // listing();
              if(widget.discount == ""){
                calculation();
              }
              else{
                calculate();
              }
            });

            setProgressWhite(false);
            _hashData = false;
            ToastMessage.msg(model.message.toString());
          }
          else {
            setProgressWhite(false);
            _hashData = false;
            print("false ### =====GetCartDetailsModel=1======>");
            ToastMessage.msg(model.message.toString());
          }
        } catch (e) {
          _hashData = false;
          print("false =======GetCartDetailsModel=2====>");
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
      print('Exception ==getreviewappointment====> ' + e.toString());
    }
  }

  Future<void> AddservicesApi(String id, String service) async {
    print("<==============AddservicesApi==================>");

    _hashData = true;
    setProgressWhite(true);

    SessionHelper session = await SessionHelper.getInstance(context);
    String userId = session.get(SessionHelper.USER_ID) ?? "0";


    Map data = {
      'user_id': userId,
      'cart_id':id,
      'isupdate': addserviceparameter,
      'shop_id': _getCartDetailsModel!.cartData![0].shopId.toString(),
      'service_id': service,
    };

    print("Request =============>" + data.toString());
    try {
      var res = await http.post(Uri.parse(Apis.addService), body: data);
      print("Response ============>" + res.body);

      if (res.statusCode == 200) {
        try {
          final jsonResponse = jsonDecode(res.body);
          AddServiceModel model = AddServiceModel.fromJson(jsonResponse);

          if (model.status == "true") {
            _hashData = false;

            setState((){
              _addServiceModel = model;
              Helper.checkInternet(getCartDetails());
            });


            print("Model status true");
            setProgressWhite(false);
            _hashData = false;
            ToastMessage.msg(model.message.toString());
          } else {
            setProgressWhite(false);
            _hashData = false;
            print("false ### ====add1========>");
            ToastMessage.msg(model.message.toString());
          }
        } catch (e) {
          _hashData = false;
          print("false =========add2===>");
          ToastMessage.msg(StaticMessages.API_ERROR);
          print('exception ==> ' + e.toString());
        }
      } else {
        _hashData = false;
        print("status code ==> add3" + res.statusCode.toString());
        ToastMessage.msg(StaticMessages.API_ERROR);
      }
    } catch (e) {
      _hashData = false;
      ToastMessage.msg(StaticMessages.API_ERROR);
      print('Exception ====add4==> ' + e.toString());
    }
  }

  Future<void> getshopofferApi() async {
    print("<==============getshopofferApi==================>");

    _hashData = true;
    setProgressWhite(true);

    SessionHelper session = await SessionHelper.getInstance(context);
    String userId = session.get(SessionHelper.USER_ID) ?? "0";

    Map data = {'user_id': userId, 'shop_id': _getCartDetailsModel!.cartData![0].shopId.toString()};

    print("Request =====getshopofferApi========>" + data.toString());
    try {
      var res = await http.post(Uri.parse(Apis.getShopOffers), body: data);
      print("Response ===getshopofferApi=========>" + res.body);

      if (res.statusCode == 200) {
        try {
          final jsonResponse = jsonDecode(res.body);
          GetShopOfferModel model = GetShopOfferModel.fromJson(jsonResponse);

          if (model.status == "true") {
            _hashData = false;

            setState(() {
              _getShopOfferModel = model;
            });

            print("Model status true");
            setProgressWhite(false);
            _hashData = false;
            ToastMessage.msg(model.message.toString());
          } else {
            setProgressWhite(false);
            _hashData = false;
            print("false ### ======getshopofferApi======>");
            ToastMessage.msg(model.message.toString());
          }
        } catch (e) {
          _hashData = false;
          print("false =====getshopofferApi=======>");
          ToastMessage.msg(StaticMessages.API_ERROR);
          print('exception ==> ' + e.toString());
        }
      } else {
        _hashData = false;
        print("status code =getshopofferApi=> " + res.statusCode.toString());
        ToastMessage.msg(StaticMessages.API_ERROR);
      }
    } catch (e) {
      _hashData = false;
      ToastMessage.msg(StaticMessages.API_ERROR);
      print('Exception ===getshopofferApi===> ' + e.toString());
    }
  }

  Future<void> getaddressApi() async {
    print("<=============getaddressApi =============>");

    SessionHelper sessionHelper = await SessionHelper.getInstance(context);
    String userId = sessionHelper.get(SessionHelper.USER_ID) ?? "0";

    print("<========getaddressApi=====userId =============>" + userId);
    _hashData = true;
    setProgressWhite(true);

    Map data = {
      'user_id': userId,
    };

    print("Request ====getaddressApi=========>" + data.toString());
    try {
      var res = await http.post(Uri.parse(Apis.getSavedAddress), body: data);
      print("Response ======getaddressApi======>" + res.body);

      if (res.statusCode == 200) {
        try {
          final jsonResponse = jsonDecode(res.body);
          GetAddressModel model = GetAddressModel.fromJson(jsonResponse);

          if (model.status == "true") {
            print("Model status true");

            setProgressWhite(false);
            _hashData = false;

            setState(() {
              _getaddressmodel = model;
              // nameController.text = _getprofileModel!.data!.name.toString();
              // phoneController.text = _getprofileModel!.data!.phone.toString();
              // emailController.text = _getprofileModel!.data!.email.toString();
              // img= _getprofileModel!.data!.image.toString();
              // print("===================image =========== ${img.toString()}");
              // select=_getprofileModel!.data!.gender.toString();
            });

            // ToastMessage.msg(model.message.toString());
          } else {
            setProgressWhite(false);
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
    setProgressWhite(false);
    _hashData = false;
  }

///////Home Visit
  Future<void> addAmountCouponApi() async {
    print("<==============addAmountCouponApi==================>");

    _hashData = true;
    setProgressWhite(true);

    SessionHelper session = await SessionHelper.getInstance(context);
    String userId = session.get(SessionHelper.USER_ID) ?? "0";

    Map data = {
      'user_id': userId,
      'amount': total.toString(),
      'coupon': (widget.coupon == "")
          ? _reviewAppointmentModel!.couponData!.offer.toString() == ""
          ? ""
          : _reviewAppointmentModel!.couponData!.offer.toString()
          : widget.coupon,
    };

    print("Request ====================>" + data.toString());
    try {
      var res = await http.post(Uri.parse(Apis.addAmountCoupon), body: data);
      print("Response==================>" + res.body);

      if (res.statusCode == 200) {
        try {
          final jsonResponse = jsonDecode(res.body);
          AddAmountCouponModel model =
          AddAmountCouponModel.fromJson(jsonResponse);

          print("Response========================>" + res.body);

          if (model.status == "true") {
            _hashData = false;

            setState(() {
              _addAmountCouponModel = model;
              _bottomSheetHomeVisit(context);
              // Helper.moveToScreenwithPush(context, AddNewAddress(
              //   booking_id: widget.booking_id,
              //   totalAmount: total.toString(),
              // ));
            });

            print("Model status true");
            setProgressWhite(false);
            _hashData = false;
            ToastMessage.msg(model.message.toString());
          } else {
            setProgressWhite(false);
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

  Future<void> AddBookingApi() async {
    print("<==============ADD BOOKING API HomeVisit==================>");

    _hashData = true;
    setProgressWhite(true);

    SessionHelper session = await SessionHelper.getInstance(context);
    String userId = session.get(SessionHelper.USER_ID) ?? "0";

    Map data = {
      'user_id': userId,
      'service': _getCartDetailsModel!.serviceList.toString(),
      'servicePrice': _getCartDetailsModel!.servicePrice.toString(),
      'shop_id': _getCartDetailsModel!.cartData![0].shopId.toString(),
      'date': today.toString().split(" ")[0],
      'time': selectedTime,
      'amount': _getCartDetailsModel!.totalAmount.toString(),
      'coupon': _getCartDetailsModel!.coupons!.offerId.toString(),
      'note': "",
      'location': "${type}",
      'address': "${address}, ${location}",
      // 'cart_id': "",
    };

    print("Request ====================>" + data.toString());
    try {
      var res = await http.post(Uri.parse(Apis.addBooking), body: data);
      print("Response==================>" + res.body);

      if (res.statusCode == 200) {
        try {
          final jsonResponse = jsonDecode(res.body);
          AddBookingModel model =  AddBookingModel.fromJson(jsonResponse);

          print("Response========================>" + res.body);

          if (model.status == "true") {
            _hashData = false;

            setState(() {

              _addBookingModel = model;
              // Helper.moveToScreenwithPush(context, Bottom());
            });
            // Helper.moveToScreenwithPush(context, BookingDetailsPage(user_id: userId, booking_id: _addBookingModel!.bookingId.toString()));
            Helper.moveToScreenwithPushreplaceemt(context, BookingDetailsPageAtHome(booking_id: _addBookingModel!.bookingId.toString()));
            print("Model status true");
            setProgressWhite(false);
            _hashData = false;
            ToastMessage.msg(model.message.toString());
          } else {
            setProgressWhite(false);
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
  Future<void> AddBookingApi2() async {
    print("<==============ADD BOOKING API Shop Visit==================>");

    _hashData = true;
    setProgressWhite(true);

    SessionHelper session = await SessionHelper.getInstance(context);
    String userId = session.get(SessionHelper.USER_ID) ?? "0";

    Map data = {
      'user_id': userId,
      'service': _getCartDetailsModel!.serviceList.toString(),
      'servicePrice': _getCartDetailsModel!.servicePrice.toString(),
      'shop_id': _getCartDetailsModel!.cartData![0].shopId.toString(),
      'date': today.toString().split(" ")[0],
      'time': selectedTime,
      'amount': _getCartDetailsModel!.totalAmount.toString(),
      'coupon': _getCartDetailsModel!.coupons!.offerId.toString(),
      'note': "",
      'location': "Shop",
      'address': "",
      // 'cart_id': "",
    };

    print("Request ====================>" + data.toString());
    try {
      var res = await http.post(Uri.parse(Apis.addBooking), body: data);
      print("Response==================>" + res.body);

      if (res.statusCode == 200) {
        try {
          final jsonResponse = jsonDecode(res.body);
          AddBookingModel model =  AddBookingModel.fromJson(jsonResponse);

          print("Response========================>" + res.body);

          if (model.status == "true") {
            _hashData = false;

            setState(() {

              _addBookingModel = model;
              // Helper.moveToScreenwithPush(context, Bottom());
            });
            Helper.moveToScreenwithPushreplaceemt(context, BookingDetailsPageAtShop(booking_id: _addBookingModel!.bookingId.toString()));

            print("Model status true");
            setProgressWhite(false);
            _hashData = false;
            ToastMessage.msg(model.message.toString());
          } else {
            setProgressWhite(false);
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

  Future<void> addBookingAddressApi() async {
    print("<==============addBookingAddressApi==================>");

    _hashData = true;
    setProgressWhite(true);

    SessionHelper session = await SessionHelper.getInstance(context);
    String userId = session.get(SessionHelper.USER_ID) ?? "0";

    Map data = {
      'user_id': userId,
      'booking_id': "",
      'location': "Shop",
      'address': "",
    };

    print("Request ====================>" + data.toString());
    try {
      var res = await http.post(Uri.parse(Apis.addBookingAddress), body: data);
      print("Response==================>" + res.body);

      if (res.statusCode == 200) {
        try {
          final jsonResponse = jsonDecode(res.body);
          AddBookingAddressModel model =
          AddBookingAddressModel.fromJson(jsonResponse);

          print("Response========================>" + res.body);

          if (model.status == "true") {
            _hashData = false;

            setState(() {
              _addBookingAddressModel = model;
              _bottomSheetAtShop(context);
            });

            print("Model status true");
            setProgressWhite(false);
            _hashData = false;
            ToastMessage.msg(model.message.toString());
          } else {
            setProgressWhite(false);
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

  Future<void> getCardDetailsApi() async {
    print("<==============getCardDetailsApi==================>");

    _hashData = true;
    setProgressWhite(true);

    SessionHelper session = await SessionHelper.getInstance(context);
    String userId = session.get(SessionHelper.USER_ID) ?? "0";

    Map data = {
      'user_id': userId,
    };

    print("Request ====================>" + data.toString());
    try {
      var res = await http.post(Uri.parse(Apis.getCardDetails), body: data);
      print("Response==================>" + res.body);

      if (res.statusCode == 200) {
        try {
          final jsonResponse = jsonDecode(res.body);
          GetCardDetailsModel model =
          GetCardDetailsModel.fromJson(jsonResponse);

          print("Response========================>" + res.body);

          if (model.status == "true") {
            _hashData = false;

            setState(() {
              _getCardDetailsModel = model;

              _getCardDetailsModel!.cardDetails![0].cardnumber
                  .toString()
                  .substring(6, int.parse(cards));

              print("card------------------------------${cards}");
            });

            print("Model status true");
            setProgressWhite(false);
            _hashData = false;
            ToastMessage.msg(model.message.toString());
          } else {
            setProgressWhite(false);
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

  Future<void> deleteCouponApi() async {
    print("<==============getCardDetailsApi==================>");

    _hashData = true;
    setProgressWhite(true);

    SessionHelper session = await SessionHelper.getInstance(context);
    String userId = session.get(SessionHelper.USER_ID) ?? "0";

    Map data = {
      'user_id': userId,
    };

    print("Request ====================>" + data.toString());
    try {
      var res = await http.post(Uri.parse(Apis.deleteCoupon), body: data);
      print("Response==================>" + res.body);

      if (res.statusCode == 200) {
        try {
          final jsonResponse = jsonDecode(res.body);
          deleteCouponModel model =
          deleteCouponModel.fromJson(jsonResponse);

          print("Response========================>" + res.body);

          if (model.status == "true") {
            _hashData = false;

            setState(() {
              _deleteCouponModel = model;
              Helper.checkInternet(getCartDetails());
            });

            print("Model status true");
            setProgressWhite(false);
            _hashData = false;
            ToastMessage.msg(model.message.toString());
          } else {
            setProgressWhite(false);
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

  setProgressWhite(bool show) {
    if (mounted)
      setState(() {
        _isVisible = show;
      });
  }

  _bottomSheetFilter(context) {
    showModalBottomSheet<void>(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        context: context,
        elevation: 0,
        isScrollControlled: true,
        // backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.70,
                  padding: EdgeInsets.all(10),
                  child: Builder(
                    builder: (context) {
                      final double height = MediaQuery.of(context).size.height;
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 120,
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        //Payment Method.......................................
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                                alignment: Alignment.topRight,
                                child: InkWell(
                                  onTap: () {
                                    Helper.popScreen(context);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(05),
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey,
                                            blurRadius: 7,
                                            offset: Offset(3, 5),
                                          ),
                                        ],
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(20),
                                        ),
                                        color: Colors.white),
                                    child: Icon(
                                      Icons.clear,
                                      size: 20,
                                      color: Colors.black,
                                    ),
                                  ),
                                )),
                            Text(
                              S.of(context).PaymentMethod,
                              style: GoogleFonts.poppins(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            //Divider............................................
                            Divider(
                              color: Color(0xFFb8b8b8),
                              height: 5,
                              thickness: 1,
                              indent: 0,
                              endIndent: 15,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            //Google
                            InkWell(
                              onTap: () {
                                setState(() {
                                  _selectPlace = "Google Pay";
                                });
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                        ProjectImage.google,
                                        width: 30,
                                      ),
                                      SizedBox(
                                        width: 30,
                                      ),
                                      Text(
                                        "Google Pay",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                  _selectPlace == "Google Pay"
                                      ? Image.asset(
                                    ProjectImage.checklist,
                                    height: 30,
                                    width: 30,
                                  )
                                      : Icon(Icons.radio_button_checked_rounded,
                                      color: Color(0xFFD9D9D9), size: 25)
                                  // Icon(Icons.radio_button_off,
                                  //     size: 18, color: AppColor.primaryColor),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  _selectPlace = "Phone Pay";
                                });
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                        ProjectImage.phonepay,
                                        width: 30,
                                      ),
                                      SizedBox(
                                        width: 30,
                                      ),
                                      Text(
                                        "Phone Pay",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(
                                        width: 82,
                                      ),

                                      // SizedBox(
                                      //   width: 10,
                                      // ),
                                    ],
                                  ),
                                  _selectPlace == "Phone Pay"
                                      ? Image.asset(
                                    ProjectImage.checklist,
                                    height: 30,
                                    width: 30,
                                  )
                                      : Icon(Icons.radio_button_checked_rounded,
                                      color: Color(0xFFD9D9D9), size: 25)
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  _selectPlace = "Paytm";
                                });
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Image.asset(
                                        ProjectImage.paytem,
                                        width: 30,
                                      ),
                                      SizedBox(
                                        width: 30,
                                      ),
                                      Text(
                                        "Paytm",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(
                                        width: 82,
                                      ),

                                      // SizedBox(
                                      //   width: 10,
                                      // ),
                                    ],
                                  ),
                                  _selectPlace == "Paytm"
                                      ? Image.asset(
                                    ProjectImage.checklist,
                                    height: 30,
                                    width: 30,
                                  )
                                      : Icon(Icons.radio_button_checked_rounded,
                                      color: Color(0xFFD9D9D9), size: 25)
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AddNewCard()));
                              },
                              child: Container(
                                // height: 80,
                                padding: const EdgeInsets.all(16.0),
                                decoration: BoxDecoration(
                                  color: Color(0xFFffffff),
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Color(0xFFe2e2e2),
                                        blurRadius: 15.0,
                                        spreadRadius: 5.0,
                                        offset: Offset(
                                          1.0,
                                          1.0,
                                        ))
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      ProjectImage.pluse,
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Add debit / card card",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 15),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "Save and Pay Via Card",
                                          style: TextStyle(
                                              color: Color(0xFF1D1D1D),
                                              fontWeight: FontWeight.w400,
                                              fontSize: 10),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Save Card",
                                  style: GoogleFonts.poppins(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),
                                ),
                                InkWell(
                                  onTap: () {
                                    Helper.moveToScreenwithPush(
                                        context,
                                        AllCards(
                                          total: total.toString(),
                                        ));
                                  },
                                  child: Text(
                                    S.of(context).ViewAll,
                                    style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(ProjectImage.visa1, height: 30),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Image.asset(ProjectImage.password, height: 10),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text("1234",
                                        // _getCardDetailsModel!.cardDetails!.isEmpty?
                                        //     "1234":
                                        // _getCardDetailsModel!.cardDetails![0].cardnumber.toString().substring(6,
                                        // int.parse(cards))==null?
                                        // "1234":
                                        // _getCardDetailsModel!.cardDetails![0].cardnumber.toString().substring(6,
                                        //     int.parse(cards)),
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xFF737b82))),
                                  ],
                                ),
                                Image.asset(ProjectImage.select, height: 30),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            MaterialButton(
                              color: Color(0xFF0ABDFC),
                              minWidth: 310,
                              height: 50,
                              textColor: Colors.white,
                              child: Text("Confirm",
                                  style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        fontSize: 20, fontWeight: FontWeight.w500),
                                  )),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              onPressed: () {
                                // Helper.popScreen(context);
                                Helper.checkInternet(AddBookingApi());
                                // Helper.checkInternet(PayBookingAmountApi());
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              });
        });
  }

  _bottomSheetHomeVisit(context) {
    showModalBottomSheet<void>(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        context: context,
        elevation: 0,
        isScrollControlled: true,
        // backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            height: MediaQuery.of(context).size.height / 2,
            child: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        _getaddressmodel!.addressList!.isEmpty
                            ? Container(
                                height: MediaQuery.of(context).size.height / 4,
                                child: Center(child: Text(S.of(context).NoDetailsFound,)),
                                )
                            :  ListView.builder(
                          // scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            // physics: NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            itemCount: _getaddressmodel!.addressList!.length,
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                onTap: () {
                                  print("_getaddressmodel!.addressList![index].flatNumber.toString() ${_getaddressmodel!.addressList![index].landmark.toString()}");
                                  print("_getaddressmodel!.addressList![index].flatNumber.toString() ${_getaddressmodel!.addressList![index].flatNumber.toString()}");
                                  _bottomSheetHomeAddress( context, _getaddressmodel!.addressList![index].landmark.toString(), _getaddressmodel!.addressList![index].flatNumber.toString());
                                  address = _getaddressmodel!.addressList![index].landmark.toString();
                                  location = _getaddressmodel!.addressList![index].flatNumber.toString();
                                  type = _getaddressmodel!.addressList![index].type.toString();

                                  print("******************Address*********************${type}");
                                  print("******************Location*********************${address}, ${location}");
                                },
                                child: Container(
                                    margin: EdgeInsets.symmetric( horizontal: 10),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                          children: [
                                            _getaddressmodel!.addressList![index].type =="Home"
                                                ? Image.asset(ProjectImage.home)
                                                : Image.asset(ProjectImage.navigation),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Container(
                                              width: 200,
                                              child: Column(
                                                crossAxisAlignment:CrossAxisAlignment.start,
                                                children: [
                                                  Text(_getaddressmodel!.addressList![index].type.toString(),
                                                    style:GoogleFonts.poppins(
                                                        textStyle:
                                                        TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:FontWeight.w500,
                                                          color: Colors.black,
                                                        )
                                                    ),
                                                  ),
                                                  Text(_getaddressmodel!.addressList![index].landmark .toString(),
                                                    style:GoogleFonts.poppins(
                                                      textStyle: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w400,
                                                        color: Colors.black,
                                                        overflow:TextOverflow.ellipsis,
                                                      ),
                                                    ),
                                                  ),
                                                  Text(_getaddressmodel!.addressList![index].flatNumber .toString(),
                                                    style:GoogleFonts.poppins(
                                                      textStyle: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w400,
                                                        color: Colors.black,
                                                        overflow:TextOverflow.ellipsis,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Icon(Icons.arrow_forward_ios)
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Divider(
                                          color: Colors.grey,
                                          height: 2,
                                          thickness: 1,
                                          indent: 0,
                                          endIndent: 15,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    )),
                              );
                            }
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 23.0, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  Helper.moveToScreenwithPush(
                                      context,
                                      AddAddressScreen());

                                },
                                child: Row(
                                  children: [
                                    Image.asset(ProjectImage.newAddress,
                                        color: Colors.blue),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      child: Text(
                                        S.of(context).AddNewAddress,
                                        style: GoogleFonts.poppins(
                                            textStyle: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black,
                                            )),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Icon(Icons.arrow_forward_ios)
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          );
        });
  }

  Widget buildSheet(context) {
    return DraggableScrollableSheet(
        initialChildSize: 0.8, //New
        maxChildSize: 0.8, // New
        minChildSize: 0.3,
        expand: true, //New
        builder: (_, controller) => Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ), //New
          // padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              ListView.builder(
                // scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  // physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  itemCount: _getaddressmodel!.addressList!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        Helper.popScreen(context);
                        _bottomSheetHomeAddress(context, _getaddressmodel!.addressList![index].landmark.toString(), _getaddressmodel!.addressList![index].flatNumber.toString());
                        // bottomDetailsSheet(_getaddressmodel!.addressList![index].flatNumber.toString());
                      },
                      child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  _getaddressmodel!
                                      .addressList![index].type ==
                                      "Home"
                                      ? Image.asset(ProjectImage.home)
                                      : Image.asset(
                                      ProjectImage.navigation),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    width: 200,
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          _getaddressmodel!
                                              .addressList![index].type
                                              .toString(),
                                          style: GoogleFonts.poppins(
                                              textStyle: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black,
                                              )),
                                        ),
                                        Text(
                                          _getaddressmodel!
                                              .addressList![index]
                                              .flatNumber
                                              .toString(),
                                          style: GoogleFonts.poppins(
                                            textStyle: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black,
                                              overflow:
                                              TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Icon(Icons.arrow_forward_ios)
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Divider(
                                color: Colors.grey,
                                height: 2,
                                thickness: 1,
                                indent: 0,
                                endIndent: 15,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          )),
                    );
                  }),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 23.0, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Helper.moveToScreenwithPush(
                            context,
                            AddAddressScreen());
                      },
                      child: Row(
                        children: [
                          Image.asset(ProjectImage.newAddress,
                              color: Colors.blue),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            child: Text(
                              S.of(context).AddNewAddress,
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios)
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  _bottomSheetHomeAddress(context, String selectLandmark, String selectAddress) {
    showModalBottomSheet<void>(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
        ),
        context: context,
        elevation: 0,
        isScrollControlled: true,
        // backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Container(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Service deliver to",
                                    style: GoogleFonts.poppins(
                                        color: Color(0xFF1D1D1D),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18),
                                  ),
                                  Container(
                                    width: 10,
                                    height: 20,
                                    child: VerticalDivider(
                                      color: Colors.black,
                                      thickness: 2,
                                    ),
                                  ),
                                  Text("40 MINS",
                                      style: GoogleFonts.poppins(
                                          color: Color(0xFF1D1D1D),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18)),
                                ],
                              ),
                              Container(
                                width: 250,
                                child: Text("${selectLandmark} ${selectAddress}",
                                  style: GoogleFonts.poppins(
                                      color: Color(0xFF555555),
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14),
                                  maxLines: 1,
                                ),
                              )
                            ],
                          ),
                          Container(
                            padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border:
                                Border.all(color: Color(0xFFD1D1D1), width: 1)),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.home,
                                  color: Colors.black,
                                  size: 25,
                                ),
                                // Icon(
                                //   Icons.keyboard_arrow_down_rounded,
                                //   color: Colors.black,
                                //   size: 25,
                                // ),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      FDottedLine(
                        color: Color(0xFF777777),
                        width: MediaQuery.of(context).size.width,
                        strokeWidth: 1.0,
                        dottedLength: 5.0,
                        space: 5.0,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                // mainAxisAlignment: MainAxisAlignment.start,
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset(ProjectImage.rupeeSimbol, height: 15),
                                  Text(
                                    _getCartDetailsModel!.totalAmount.toString(),
                                    style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                        )),
                                  ),
                                ],
                              ),
                              Text(
                                S.of(context).ViewDetailedBill,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                    color: Color(0xFF1BA571)),
                              )
                            ],
                          ),
                          MaterialButton(
                            color: Color(0xFF0ABDFC),
                            minWidth: 100,
                            height: 50,
                            textColor: Colors.white,
                            child: Text(
                              S.of(context).ProceedToPay,
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  )),
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            onPressed: () {
                              Helper.popScreen(context);
                              _bottomSheetFilter(context);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              });
        });
  }

  _bottomSheetAtShop(context) {
    showModalBottomSheet<void>(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        context: context,
        elevation: 0,
        isScrollControlled: true,
        // backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
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
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.start,
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(ProjectImage.rupeeSimbol, height: 15),
                              Text(
                                total.toString(),
                                style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                    )),
                              ),
                            ],
                          ),
                          Text(
                            "View Detailed Bill",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                                color: Color(0xFF1BA571)),
                          )
                        ],
                      ),
                      SizedBox(
                        width: 68,
                      ),
                      MaterialButton(
                        color: Color(0xFF0ABDFC),
                        minWidth: 100,
                        height: 50,
                        textColor: Colors.white,
                        child: Text(
                          "Proceed to pay",
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              )),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        onPressed: () {
                          Helper.popScreen(context);
                          _bottomSheetFilter(context);
                        },
                      ),
                    ],
                  ),
                );
              });
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
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          margin: EdgeInsets.only(top: 50),
          height: 400,
          width: 380,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30), color: Colors.white),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Lottie.asset(ProjectImage.paymentsuccessful,height: 150, ),
              Text(
                "Payment Successful",
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF1ba571),
                    )),
              ),
              Text(
                "Transaction number : 149538292331",
                style: GoogleFonts.poppins(
                    color: Color(0xFF8C8C8C),
                    fontWeight: FontWeight.w400,
                    fontSize: 12),
              ),
              SizedBox(
                height: 10,
              ),
              DottedLine(
                direction: Axis.horizontal,
                lineLength: double.infinity,
                lineThickness: 1.0,
                dashLength: 4.0,
                dashColor: Color(0xFFdedede),
                dashGapLength: 2.0,
                dashGapColor: Colors.transparent,
                dashGapRadius: 4.0,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Amount Paid",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF8C8C8C),
                        )),
                  ),
                  Text(
                    _getCartDetailsModel!.totalAmount.toString(),
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF8C8C8C),
                        )),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Bank",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF8C8C8C),
                        )),
                  ),
                  Text(
                    "SBI",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF8C8C8C),
                        )),
                  ),
                ],
              ),
              SizedBox(
                height: 25,
              ),
              MaterialButton(
                color: Colors.white,
                minWidth: 200,
                height: 45,
                textColor: Colors.white,
                elevation: 20,
                child: Text(
                  "Ok",
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 17),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                onPressed: () {
                  print("tap--------------------->");
                  Helper.checkInternet(AddBookingApi());
                },
              )
            ],
          )),
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
  loadData() async {
    // leave();
    Helper.moveToScreenwithPushreplaceemt(context, TopSalon(shop_id: _getCartDetailsModel!.cartData![0].shopId.toString(), totalAmount: _getCartDetailsModel!.sum.toString()));
  }



}

