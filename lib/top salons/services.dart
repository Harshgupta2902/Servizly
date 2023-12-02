// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import '../Helper/constant.dart';
// import '../Payment/review_order.dart';
// import '../Registration screen/date_time.dart';
// import '../helper/apis.dart';
// import '../helper/image.dart';
// import 'package:http/http.dart'as http;
//
// import '../model/add_service_model.dart';
// import '../model/get_shop_detail_model.dart';
// import '../model/home_model.dart';
//
//
// class Servicesscreen extends StatefulWidget {
//   const Servicesscreen({Key? key}) : super(key: key);
//
//   @override
//   State<Servicesscreen> createState() => _ServicesscreenState();
// }
//
// class _ServicesscreenState extends State<Servicesscreen> {
//
//   String _isselect = "0";
//   bool check = false;
//   bool checktwo = false;
//   bool checkthree = false;
//
//   bool _showDocument = true;
//   bool _isVisible = false;
//   bool _hashData = false;
//   AddServicesmodel?_addServicesmodel;
//   Getshopdetailmodel?_getshopdetailmodel;
//
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     Helper.checkInternet(getShopDetailsApi());
//     _showDocument = false;
//
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           _getshopdetailmodel==null
//               ?_hashData
//               ? Container()
//               :Container(
//               height: MediaQuery.of(context).size.height,
//               width: MediaQuery.of(context).size.width,
//               child: Center(
//                   child: Text("No data found",
//                     style: TextStyle(
//                         fontWeight: FontWeight.bold,color: Colors.black,
//                         fontSize: 25
//                     ),
//                   )
//               )) :
//           ListView.builder(
//               scrollDirection: Axis.vertical,
//               padding: EdgeInsets.symmetric(horizontal: 20),
//               itemCount: _getshopdetailmodel!.shopServiceList!.length,
//               itemBuilder: (BuildContext context, int index) {
//                 return   Container(
//                   margin:EdgeInsets.symmetric(vertical: 10) ,
//                   child: Column(
//                     children: [
//                       Container(
//                         padding: EdgeInsets.symmetric(horizontal: 10),
//                         height: 60,
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.grey.withOpacity(0.2),
//                               spreadRadius: 2,
//                               blurRadius: 2,
//                               offset: Offset(0, 1), // changes position of shadow
//                             ),
//                           ],
//                         ),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(_getshopdetailmodel!.shopServiceList![index].serviceName.toString(),
//                                 style: GoogleFonts.poppins(
//                                   textStyle: TextStyle(
//                                       fontSize: 16, fontWeight: FontWeight.w400,color:AppColor.primaryColor ),
//                                 )),
//                             Text("\$ ${_getshopdetailmodel!.shopServiceList![index].price.toString()}",
//                                 style: GoogleFonts.poppins(
//                                   textStyle: TextStyle(
//                                       fontSize: 16, fontWeight: FontWeight.w400,color:AppColor.primaryColor),
//                                 )),
//                             MaterialButton(
//                               color: Color(0xFF09BDFC),
//                               textColor: Colors.white,
//                               minWidth: 30,
//                               padding: EdgeInsets.symmetric(horizontal: 20),
//                               child: Text("Book",
//                                   style: GoogleFonts.poppins(
//                                     textStyle: TextStyle(
//                                         fontSize: 14, fontWeight: FontWeight.w400,color:Colors.white),
//                                   )),
//                               shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(5)),
//                               onPressed: () {
//                                 setState(() {
//                                   Helper.checkInternet(AddservicesApi());
//                                   _showDocument=true;
//                                 });
//                               },
//                             ),
//                           ],
//                         ),
//                       )
//                     ],
//                   ),
//                 );
//               }),
//           Positioned(
//               bottom: 5,
//               left: 15,
//               right: 15,
//               child:  Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 0),
//                 child: InkWell(
//                   onTap: (){
//                     // _bottomSheetFilter(context);
//                   },
//                   child: Visibility(
//                     maintainAnimation: true,
//                     // maintainSize: true,
//                     maintainState: true,
//                     visible: _showDocument,
//                     child: Container(
//                       width: MediaQuery.of(context).size.width,
//             padding: EdgeInsets.symmetric(horizontal: 30,vertical: 15),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(12),
//                     color: Color(0xFF09BDFC),
//                     // boxShadow: [
//                     //   BoxShadow(
//                     //     color: Colors.grey.withOpacity(0.2),
//                     //     spreadRadius: 2,
//                     //     blurRadius: 2,
//                     //     offset: Offset(0, 1), // changes position of shadow
//                     //   ),
//                     // ],
//             ),
//             child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             children: [
//                               Text("1 Item",
//                                   style: GoogleFonts.poppins(
//                                     textStyle: TextStyle(
//                                         fontSize: 14, fontWeight: FontWeight.w400,color:Colors.white ),
//                                   )),
//                               Text(" | ",
//                                   style: GoogleFonts.poppins(
//                                     textStyle: TextStyle(
//                                         fontSize: 14, fontWeight: FontWeight.w400,color:Colors.white ),
//                                   )),
//                               Text("277",
//                                   style: GoogleFonts.poppins(
//                                     textStyle: TextStyle(
//                                         fontSize: 14, fontWeight: FontWeight.w400,color:Colors.white ),
//                                   )),
//                             ],
//                           ),
//                           Text("From : Lemongrass Salon",
//                               style: GoogleFonts.poppins(
//                                 textStyle: TextStyle(
//                                     fontSize: 10, fontWeight: FontWeight.w300,color:Colors.white ),
//                               )),
//                         ],
//                       ),
//                       InkWell(
//                         onTap: () {
//
//                           // _bottomSheetFilter(context);
//                            // Helper.moveToScreenwithPush(context, DateTimeScreen());
//                         },
//                         child: Container(
//                           width: 80,
//                           child: Text("View Cart",
//                               style: GoogleFonts.poppins(
//                                 textStyle: TextStyle(
//                                     fontSize: 16, fontWeight: FontWeight.w400,
//                                     color:Colors.white),
//                               )),
//                         ),
//                       ),
//
//                     ],
//             ),
//           ),
//                   ),
//                 ),
//               )),
//           Helper.getProgressBarWhite(context, _isVisible)
//         ],
//       ),
//     );
//   }
//
//   _bottomSheetFilter(context) {
//     showModalBottomSheet<void>(
//       shape:  RoundedRectangleBorder(
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(30),
//           topRight: Radius.circular(30),
//         ),
//       ),
//       context: context,
//       elevation: 0,
//       isScrollControlled:true,
//       // backgroundColor: Colors.transparent,
//       builder: (BuildContext context) {
//         return
//           StatefulBuilder(
//               builder: (BuildContext context, StateSetter setState) {
//                 return SizedBox(
//                   height: 400,
//                   child: Container(
//                     padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(30),
//                       color: Colors.white,
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         SizedBox(
//                           height: 10,
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Icon(Icons.close,color: Colors.transparent,),
//                             InkWell(
//                                 onTap: () {
//                                   Helper.popScreen(context);
//                                 },
//                                 child: Icon(Icons.close)),
//                           ],
//                         ),
//                         Container(
//                           padding: EdgeInsets.symmetric(vertical: 10),
//                           child: Text("Choose your facial",
//                               style: GoogleFonts.poppins(
//                                 textStyle: TextStyle(
//                                     fontSize: 18, fontWeight: FontWeight.w600,color:AppColor.primaryColor ),
//                               )),
//                         ),
//                         Divider(
//                           color: Colors.grey,
//                         ),
//                         Column(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Container(
//                                 padding: EdgeInsets.symmetric(vertical: 15),
//                                 child:
//
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text("Brightening Facial",
//                                         style: GoogleFonts.poppins(
//                                           textStyle: TextStyle(
//                                               fontSize: 18,
//                                               fontWeight: FontWeight.w400,
//                                               color:AppColor.primaryColor ),
//                                         )),
//                                     Container(
//                                       padding: EdgeInsets.symmetric(vertical: 0),
//                                       margin: EdgeInsets.symmetric(vertical: 0),
//                                       child: InkWell(
//                                         onTap: () {
//                                           setState(() {
//                                             if (check == true) {
//                                               check = false;
//
//                                             } else {
//                                               check = true;
//                                             }
//                                           });
//                                         },
//                                         child: Container(
//                                           height: 30,
//                                           width: 30,
//                                           decoration: BoxDecoration(
//                                               borderRadius: BorderRadius.circular(2),
//                                               color: Colors.transparent),
//                                           child: Stack(
//                                             children: [
//                                               Positioned(
//                                                 bottom: 0,
//                                                 child: Container(
//                                                   decoration: BoxDecoration(
//                                                     borderRadius:
//                                                     BorderRadius.circular(2),
//                                                     color: Color(0xFFd9d9d9),
//                                                   ),
//                                                   height: 25,
//                                                   width: 25,
//                                                 ),
//                                               ),
//                                               check == true
//                                                   ? Positioned(
//                                                   bottom: 0,
//                                                   right: 8,
//                                                   left: 5,
//                                                   child: Image.asset(
//                                                     ProjectImage.check,
//                                                     height: 20,
//                                                     width: 20,
//                                                   ))
//                                                   : SizedBox()
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 )
//
//
//
//                             ),
//                             Container(
//                               padding: EdgeInsets.symmetric(vertical: 15),
//                               child:
//
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text("Classic Facial",
//                                         style: GoogleFonts.poppins(
//                                           textStyle: TextStyle(
//                                               fontSize: 18, fontWeight: FontWeight.w400
//                                               ,color:AppColor.primaryColor ),
//                                         )),
//                                     Container(
//                                       padding: EdgeInsets.symmetric(vertical: 0),
//                                       margin: EdgeInsets.symmetric(vertical: 0),
//                                       child: InkWell(
//                                         onTap: () {
//                                           setState(() {
//                                             if (checktwo == true) {
//                                               checktwo = false;
//
//                                             } else {
//                                               checktwo = true;
//                                             }
//                                           });
//                                         },
//                                         child: Container(
//                                           height: 30,
//                                           width: 30,
//                                           decoration: BoxDecoration(
//                                               borderRadius: BorderRadius.circular(2),
//                                               color: Colors.transparent),
//                                           child: Stack(
//                                             children: [
//                                               Positioned(
//                                                 bottom: 0,
//                                                 child: Container(
//                                                   decoration: BoxDecoration(
//                                                     borderRadius:
//                                                     BorderRadius.circular(2),
//                                                     color: Color(0xFFd9d9d9),
//                                                   ),
//                                                   height: 25,
//                                                   width: 25,
//                                                 ),
//                                               ),
//                                               checktwo == true
//                                                   ? Positioned(
//                                                   bottom: 0,
//                                                   right: 8,
//                                                   left: 5,
//                                                   child: Image.asset(
//                                                     ProjectImage.check,
//                                                     height: 20,
//                                                     width: 20,
//                                                   ))
//                                                   : SizedBox()
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 )
//
//
//
//
//                             ),
//                             Container(
//                               padding: EdgeInsets.symmetric(vertical: 15),
//                               child:
//                               Row(
//                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text("Hydrated Facial",
//                                         style: GoogleFonts.poppins(
//                                           textStyle: TextStyle(
//                                               fontSize: 18, fontWeight: FontWeight.w400,color:AppColor.primaryColor ),
//                                         )),
//                                     Container(
//                                       padding: EdgeInsets.symmetric(vertical: 0),
//                                       margin: EdgeInsets.symmetric(vertical: 0),
//                                       child: InkWell(
//                                         onTap: () {
//                                           setState(() {
//                                             if (checkthree == true) {
//                                               checkthree = false;
//
//                                             } else {
//                                               checkthree = true;
//                                             }
//                                           });
//                                         },
//                                         child: Container(
//                                           height: 30,
//                                           width: 30,
//                                           decoration: BoxDecoration(
//                                               borderRadius: BorderRadius.circular(2),
//                                               color: Colors.transparent),
//                                           child: Stack(
//                                             children: [
//                                               Positioned(
//                                                 bottom: 0,
//                                                 child: Container(
//                                                   decoration: BoxDecoration(
//                                                     borderRadius:
//                                                     BorderRadius.circular(2),
//                                                     color: Color(0xFFd9d9d9),
//                                                   ),
//                                                   height: 25,
//                                                   width: 25,
//                                                 ),
//                                               ),
//                                               checkthree == true
//                                                   ? Positioned(
//                                                   bottom: 0,
//                                                   right: 8,
//                                                   left: 5,
//                                                   child: Image.asset(
//                                                     ProjectImage.check,
//                                                     height: 20,
//                                                     width: 20,
//                                                   ))
//                                                   : SizedBox()
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 )
//                             ),
//                             Center(
//                               child: Container(
//                                 padding: EdgeInsets.symmetric(vertical: 20),
//                                 child: MaterialButton(
//                                   color: Color(0xFF09BDFC),
//                                   textColor: Colors.white,
//                                   minWidth: 320,
//                                   padding: EdgeInsets.symmetric(horizontal: 20,vertical: 15),
//                                   child: Text("Confirm",
//                                       style: GoogleFonts.poppins(
//                                         textStyle: TextStyle(
//                                             fontSize: 18, fontWeight: FontWeight.w500,
//                                             color:Colors.white),
//                                       )),
//                                   shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(30)),
//                                   onPressed: () {
//                                     Helper.moveToScreenwithPush(context, DateTimeScreen());
//                                     // Helper.moveToScreenwithPush(context, ReviewPayment());
//                                     // Helper.popScreen(context);
//                                   },
//                                 ),
//                               ),
//                             ),
//                           ],
//                         )
//
//                       ],
//                     ),
//                   ),
//                 );
//               }
//           );
//
//       },
//     );
//   }
//
//   setProgress(bool show) {
//     if (mounted)
//       setState(() {
//         _isVisible = show;
//       });
//   }
//
//   Future<void> AddservicesApi() async {
//
//     print("<==============AddservicesApi==================>");
//
//     _hashData = true;
//     setProgress(true);
//
//     SessionHelper session = await SessionHelper.getInstance(context);
//     String userId = session.get(SessionHelper.USER_ID) ?? "0";
//
//
//     Map data = {
//       'user_id': userId,
//       'service': "hair",
//       'shop_id': "1",
//     };
//
//     print("Request =============>" + data.toString());
//     try {
//       var res = await http.post(Uri.parse(Apis.addService), body: data);
//       print("Response ============>" + res.body);
//
//       if (res.statusCode == 200) {
//         try {
//           final jsonResponse = jsonDecode(res.body);
//           AddServicesmodel model = AddServicesmodel.fromJson(jsonResponse);
//
//           if (model.status == "true") {
//             _hashData = false;
//             _bottomSheetFilter(context);
//             setState(() {
//               _addServicesmodel = model;
//               // nameController.text =_getprofileModel!.data!.name.toString() ;
//               // phoneController.text =_getprofileModel!.data!.phone.toString() ;
//               // emailController.text =_getprofileModel!.data!.email.toString() ;
//
//               // showDate =dob ;
//               // img =_profileModel!.userData![0].image![0].toString();
//
//             });
//
//             print("Model status true");
//             setProgress(false);
//             _hashData = false;
//             ToastMessage.msg(model.message.toString());
//             // _nameController.text=model.data!.name!;
//             // _emailController.text=model.data!.email!;
//             // _phoneController.text.data!.phone!;
//
//             // //Helper.moveToScreenwithPush(context, EditProfile());
//             // SessionHelper sessionHelper =await SessionHelper.getInstance(context);
//             // print("userId blah==========>${model.data!.userId.toString()}");
//             // sessionHelper.put(SessionHelper.USER_ID,model.data!.userId.toString());
//             // sessionHelper.put(SessionHelper.FULLNAME,model.data!.fullName.toString());
//             // sessionHelper.put(SessionHelper.EMAIL,model.data!.email.toString());
//             // sessionHelper.put(SessionHelper.PASSWORD,passwordController.text.trim());
//             // sessionHelper.put(SessionHelper.GENDER,model.data!.gender.toString());
//             // sessionHelper.put(SessionHelper.DOB,model.data!.dob.toString());
//             // sessionHelper.put(SessionHelper.IMAGE,model.data!.image.toString());
//             // sessionHelper.put(SessionHelper.FIREBASEID,model.data!.firebaseId.toString());
//             // sessionHelper.put(SessionHelper.IS_ACTIVE,model.data!.isActive.toString());
//             // sessionHelper.put(SessionHelper.LOCATION_STATUS,model.data!.locationStatus.toString());
//           } else {
//             setProgress(false);
//             _hashData = false;
//             print("false ### ============>");
//             ToastMessage.msg(model.message.toString());
//           }
//         } catch (e) {
//           _hashData = false;
//           print("false ============>");
//           ToastMessage.msg(StaticMessages.API_ERROR);
//           print('exception ==> ' + e.toString());
//         }
//       } else {
//         _hashData = false;
//         print("status code ==> " + res.statusCode.toString());
//         ToastMessage.msg(StaticMessages.API_ERROR);
//       }
//     } catch (e) {
//       _hashData = false;
//       ToastMessage.msg(StaticMessages.API_ERROR);
//       print('Exception ======> ' + e.toString());
//     }
//   }
//
//   Future<void> getShopDetailsApi() async {
//
//     print("<==============getShopDetailsApi==================>");
//
//     _hashData = true;
//     setProgress(true);
//
//     SessionHelper session = await SessionHelper.getInstance(context);
//     String userId = session.get(SessionHelper.USER_ID) ?? "0";
//
//
//     Map data = {
//       'user_id': userId,
//       'shop_id':"1"
//     };
//
//     print("Request =============>" + data.toString());
//     try {
//       var res = await http.post(Uri.parse(Apis.getShopDetails), body: data);
//       print("Response ============>" + res.body);
//
//       if (res.statusCode == 200) {
//         try {
//           final jsonResponse = jsonDecode(res.body);
//           Getshopdetailmodel model = Getshopdetailmodel.fromJson(jsonResponse);
//
//           if (model.status == "true") {
//             _hashData = false;
//
//             setState(() {
//               _getshopdetailmodel = model;
//               // nameController.text =_getprofileModel!.data!.name.toString() ;
//               // phoneController.text =_getprofileModel!.data!.phone.toString() ;
//               // emailController.text =_getprofileModel!.data!.email.toString() ;
//
//               // showDate =dob ;
//               // img =_profileModel!.userData![0].image![0].toString();
//
//             });
//
//             print("Model status true");
//             setProgress(false);
//             _hashData = false;
//             ToastMessage.msg(model.message.toString());
//             // _nameController.text=model.data!.name!;
//             // _emailController.text=model.data!.email!;
//             // _phoneController.text.data!.phone!;
//
//             // //Helper.moveToScreenwithPush(context, EditProfile());
//             // SessionHelper sessionHelper =await SessionHelper.getInstance(context);
//             // print("userId blah==========>${model.data!.userId.toString()}");
//             // sessionHelper.put(SessionHelper.USER_ID,model.data!.userId.toString());
//             // sessionHelper.put(SessionHelper.FULLNAME,model.data!.fullName.toString());
//             // sessionHelper.put(SessionHelper.EMAIL,model.data!.email.toString());
//             // sessionHelper.put(SessionHelper.PASSWORD,passwordController.text.trim());
//             // sessionHelper.put(SessionHelper.GENDER,model.data!.gender.toString());
//             // sessionHelper.put(SessionHelper.DOB,model.data!.dob.toString());
//             // sessionHelper.put(SessionHelper.IMAGE,model.data!.image.toString());
//             // sessionHelper.put(SessionHelper.FIREBASEID,model.data!.firebaseId.toString());
//             // sessionHelper.put(SessionHelper.IS_ACTIVE,model.data!.isActive.toString());
//             // sessionHelper.put(SessionHelper.LOCATION_STATUS,model.data!.locationStatus.toString());
//           } else {
//             setProgress(false);
//             _hashData = false;
//             print("false ### ============>");
//             ToastMessage.msg(model.message.toString());
//           }
//         } catch (e) {
//           _hashData = false;
//           print("false ============>");
//           ToastMessage.msg(StaticMessages.API_ERROR);
//           print('exception ==> ' + e.toString());
//         }
//       } else {
//         _hashData = false;
//         print("status code ==> " + res.statusCode.toString());
//         ToastMessage.msg(StaticMessages.API_ERROR);
//       }
//     } catch (e) {
//       _hashData = false;
//       ToastMessage.msg(StaticMessages.API_ERROR);
//       print('Exception ======> ' + e.toString());
//     }
//   }
//
// }
//
//
//
// // _bottomSheetPickup(context){
// //   showModalBottomSheet(
// //     isScrollControlled: true,
// //     shape: const RoundedRectangleBorder(
// //       borderRadius: BorderRadius.only(
// //           topLeft: Radius.circular(60),
// //           topRight: Radius.circular(60)
// //       ),
// //     ),
// //     context: context,
// //     builder: (context){
// //       return
// //        ;
// //     },
// //   );
// // }
