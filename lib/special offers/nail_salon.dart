//
//
// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:http/http.dart'as http;
// import '../helper/apis.dart';
// import '../helper/constant.dart';
// import '../helper/image.dart';
// import '../model/get_offer_model.dart';
// import '../top salons/top_salon.dart';
//
// class NailSalon extends StatefulWidget {
//   const NailSalon({Key? key}) : super(key: key);
//
//   @override
//   State<NailSalon> createState() => _NailSalonState();
// }
//
// class _NailSalonState extends State<NailSalon> {
//
//   final List<OfferModel> _offermodel = [
//     OfferModel(image: ProjectImage.specialoffer, name: "Hair Salon"),
//     OfferModel(image: ProjectImage.specialoffer, name: "Nail Salon"),
//     OfferModel(image: ProjectImage.specialoffer, name: "Skin care"),
//     OfferModel(image: ProjectImage.specialoffer, name: "Skin care"),
//   ];
//
//   final List<TopSalonModel> _topsalonlist = [
//     TopSalonModel(image: ProjectImage.nailsalon, name: "Hair Salon"),
//     TopSalonModel(image: ProjectImage.nailsalon, name: "Nail Salon"),
//     TopSalonModel(image: ProjectImage.nailsalon, name: "Skin care"),
//     TopSalonModel(image: ProjectImage.nailsalon, name: "Skin care"),
//     TopSalonModel(image: ProjectImage.nailsalon, name: "Skin care"),
//   ];
//   bool _isVisible = false;
//   bool _hashData = false;
//   GetOfferModel?_getOfferModel;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body:  Container(
//         height: MediaQuery.of(context).size.height,
//         width: MediaQuery.of(context).size.width ,
//         padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               // Container(
//               //   height: 250,
//               //   child: ListView.builder(
//               //       scrollDirection: Axis.horizontal,
//               //       padding: EdgeInsets.symmetric(horizontal: 0),
//               //       itemCount: 10,
//               //       itemBuilder: (BuildContext context, int index) {
//               //         return   Container(
//               //           width: MediaQuery.of(context).size.width,
//               //           height: 240,
//               //           child: ListView.builder(
//               //               scrollDirection: Axis.horizontal,
//               //             shrinkWrap: true,
//               //               physics: NeverScrollableScrollPhysics(),
//               //               itemCount: _offermodel.length,
//               //               itemBuilder: (BuildContext context, int index) {
//               //                 return Container(
//               //                   height: 280,
//               //                   margin: EdgeInsets.symmetric(horizontal: 30),
//               //                   child: Column(
//               //                     children: [
//               //                       Container(
//               //                         width: 300,
//               //                         child: Row(
//               //                           mainAxisAlignment:
//               //                           MainAxisAlignment.spaceBetween,
//               //                           children: [
//               //                             Text(
//               //                               "Special Offers",
//               //                               style: GoogleFonts.poppins(
//               //                                   textStyle: TextStyle(
//               //                                     fontSize: 18,
//               //                                     fontWeight: FontWeight.w500,
//               //                                     color: AppColor.primaryColor,
//               //                                   )),
//               //                             ),
//               //                             Icon(Icons.arrow_forward)
//               //                           ],
//               //                         ),
//               //                       ),
//               //                       SizedBox(
//               //                         height: 20,
//               //                       ),
//               //                       Stack(
//               //                         children: [
//               //                           Container(
//               //                             height: 160,
//               //                             width: 300,
//               //                             decoration: BoxDecoration(
//               //                               borderRadius: BorderRadius.circular(10),
//               //                             ),
//               //                             child: Image.asset(_offermodel[index].image,fit: BoxFit.fill,),
//               //                           ),
//               //                         ],
//               //                       ),
//               //                     ],
//               //                   ),
//               //                 );
//               //               }),
//               //         );
//               //       }),
//               // ),
//               Container(
//                 width: 300,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       "Special Offers",
//                       style: GoogleFonts.poppins(
//                           textStyle: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.w500,
//                             color: AppColor.primaryColor,
//                           )),
//                     ),
//                     Icon(Icons.arrow_forward)
//                   ],
//                 ),
//               ),
//               SizedBox(height: 20,),
//               Container(
//                 width: MediaQuery.of(context).size.width,
//                 height: 180,
//                 child: ListView.builder(
//                     scrollDirection: Axis.horizontal,
//                     itemCount: _offermodel.length,
//                     itemBuilder: (BuildContext context, int index) {
//                       return Container(
//                         // height: 100,
//                         margin: EdgeInsets.symmetric(horizontal: 10),
//                         child: Column(
//                           children: [
//                             Container(
//                               height: 160,
//                               width: 300,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(20),
//                               ),
//                               child: Image.asset(_offermodel[index].image,
//                                 fit: BoxFit.fill,),
//                             ),
//                           ],
//                         ),
//                       );
//                     }),
//               ),
//               // ListView.builder(
//               //     scrollDirection: Axis.vertical,
//               //     physics: NeverScrollableScrollPhysics(),
//               //     shrinkWrap: true,
//               //     itemCount: _topsalonlist.length,
//               //     itemBuilder: (BuildContext context, int index) {
//               //       return Container(
//               //         height: 250,
//               //         margin: EdgeInsets.symmetric(horizontal: 30),
//               //         child: Column(
//               //           children: [
//               //             Stack(
//               //               children: [
//               //                 Container(
//               //                   height: 160,
//               //                   width: 300,
//               //                   decoration: BoxDecoration(
//               //                     borderRadius: BorderRadius.circular(10),
//               //                   ),
//               //                   child: Image.asset(_topsalonlist[index].image,fit: BoxFit.fill,),
//               //                 ),
//               //               ],
//               //             ),
//               //             SizedBox(
//               //               height: 20,
//               //             ),
//               //             Container(
//               //               width: 300,
//               //               child: Row(
//               //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               //                 crossAxisAlignment: CrossAxisAlignment.start,
//               //                 children: [
//               //                   Column(
//               //                     crossAxisAlignment: CrossAxisAlignment.start,
//               //                     mainAxisAlignment: MainAxisAlignment.start,
//               //                     children: [
//               //                       Text(
//               //                         "Fingertip",
//               //                         style: GoogleFonts.poppins(
//               //                             textStyle: TextStyle(
//               //                               fontSize: 16,
//               //                               fontWeight: FontWeight.w500,
//               //                               color: AppColor.primaryColor,
//               //                             )),
//               //                       ),
//               //                       Text(
//               //                         "13 Kalani nagar",
//               //                         style: GoogleFonts.poppins(
//               //                             textStyle: TextStyle(
//               //                               fontSize: 14,
//               //                               fontWeight: FontWeight.w400,
//               //                               color: AppColor.greytext,
//               //                             )),
//               //                       ),
//               //
//               //                     ],
//               //                   ),
//               //                   Row(
//               //                     children: [
//               //                       Text(
//               //                         "5.0 Ratings",
//               //                         style: GoogleFonts.poppins(
//               //                             textStyle: TextStyle(
//               //                               fontSize: 14,
//               //                               fontWeight: FontWeight.w400,
//               //                               color: Color(0XFFB8B8B8),
//               //                             )),
//               //                       ),
//               //                     ],
//               //                   )
//               //                 ],
//               //               ),
//               //             ),
//               //           ],
//               //         ),
//               //       );
//               //     }),
//               InkWell(
//                 onTap: () {
//                   // Helper.moveToScreenwithPush(context, TopSalon());
//                 },
//                 child: ListView.builder(
//                     scrollDirection: Axis.vertical,
//                     physics: NeverScrollableScrollPhysics(),
//                     shrinkWrap: true,
//                     itemCount: _topsalonlist.length,
//                     itemBuilder: (BuildContext context, int index) {
//                       return Container(
//                         height: MediaQuery.of(context).size.height*0.35,
//                         margin: EdgeInsets.symmetric(horizontal: 20),
//                         child: Column(
//                           children: [
//                             Container(
//                               height: 160,
//                               width: MediaQuery.of(context).size.height*0.38,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                               child: Image.asset(_topsalonlist[index].image,fit: BoxFit.fill,),
//                             ),
//                             SizedBox(
//                               height: 20,
//                             ),
//                             Container(
//                               // width: MediaQuery.of(context).size.width*0.80,
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Column(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     mainAxisAlignment: MainAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         "V styles Salon",
//                                         style: GoogleFonts.poppins(
//                                             textStyle: TextStyle(
//                                               fontSize: 16,
//                                               fontWeight: FontWeight.w500,
//                                               color: AppColor.primaryColor,
//                                             )),
//                                       ),
//                                       Text(
//                                         "13 Anoop nagar",
//                                         style: GoogleFonts.poppins(
//                                             textStyle: TextStyle(
//                                               fontSize: 14,
//                                               fontWeight: FontWeight.w400,
//                                               color: AppColor.greytext,
//                                             )),
//                                       ),
//                                     ],
//                                   ),
//                                   Text(
//                                     "5.0 Ratings",
//                                     style: GoogleFonts.poppins(
//                                         textStyle: TextStyle(
//                                           fontSize: 14,
//                                           fontWeight: FontWeight.w400,
//                                           color: Color(0XFFB8B8B8),
//                                         )),
//                                   )
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       );
//                     }),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
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
//       'shop_id':widget.shop_id
//     };
//
//     print("Request =============>" + data.toString());
//     try {
//       var res = await http.post(Uri.parse(Apis.getOffers), body: data);
//       print("Response ============>" + res.body);
//
//       if (res.statusCode == 200) {
//         try {
//           final jsonResponse = jsonDecode(res.body);
//           GetOfferModel model = GetOfferModel.fromJson(jsonResponse);
//
//           if (model.status == "true") {
//             _hashData = false;
//
//             setState(() {
//               _getOfferModel = model;
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
//
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
//   setProgress(bool show) {
//     if (mounted)
//       setState(() {
//         _isVisible = show;
//       });
//   }
// }
//
//
// class TopSalonModel {
//   String image = "";
//   String name = "";
//
//   TopSalonModel({required this.image, required this.name});
// }
//
//
// class OfferModel {
//   String image = "";
//   String name = "";
//
//   OfferModel({required this.image, required this.name});
// }
