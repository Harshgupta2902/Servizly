import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:serviceapplatest/helper/constant.dart';
import 'helper/image.dart';

 class RefundScreen extends StatefulWidget {
   const RefundScreen({Key? key}) : super(key: key);

   @override
   State<RefundScreen> createState() => _RefundScreenState();
 }

 class _RefundScreenState extends State<RefundScreen> {
   String _selectPlace = "";
   @override
   Widget build(BuildContext context) {
     return  Scaffold(
       appBar: AppBar(
         elevation: 15,
         toolbarHeight: 100,
         titleSpacing: 0,
         backgroundColor: Color(0xFFFFFFFF),
         centerTitle: true,
         title: Text(
           "Refund",
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
       body: Container(
         width: MediaQuery.of(context).size.width,
         height: MediaQuery.of(context).size.height,

         padding: EdgeInsets.symmetric(horizontal: 40,vertical: 30),

         child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             Image.asset(ProjectImage.refund),
             Text("Why do you want to Refund?",
               style: GoogleFonts.poppins(
                   textStyle: TextStyle(
                     fontSize: 16,
                     fontWeight: FontWeight.w500,
                     color: Colors.black,
                   )),
             ),
             SizedBox(height: 15,),
             InkWell(
               onTap: () {
               //  _bottomSheetAtShop(context);
                 setState(() {
                   _selectPlace = "ChangeMind";
                   //_showDocument=true;
                 });
               },
               child: Row(

                 children: [
                   _selectPlace == "ChangeMind"
                       ? Icon(Icons.radio_button_checked_rounded,
                       color: AppColor.green, size: 18)
                       : Icon(Icons.radio_button_off,
                       size: 18, color: AppColor.primaryColor),
                   SizedBox(
                     width: 10,
                   ),
                   Text(
                     "I changed my mind",
                       style: GoogleFonts.poppins(
                           textStyle: TextStyle(
                             fontSize: 12,
                             fontWeight: FontWeight.w300,
                             color: Colors.black,
                           )),
                   ),
                 ],
               ),
             ),
             SizedBox(height: 15,),
             InkWell(
               onTap: () {
               //  _bottomSheetHomeVisit(context);
                 setState(() {
                   _selectPlace = "ScheduledTime";

                 });
               },
               child: Row(
                 children: [
                   _selectPlace == "ScheduledTime"
                       ? Icon(Icons.radio_button_checked_rounded,
                       color: AppColor.green, size: 18)
                       : Icon(Icons.radio_button_off,
                       size: 18, color: AppColor.primaryColor),
                   SizedBox(
                     width: 10,
                   ),
                   Text(
                     "I am unavailable at the "
                         "scheduled time",
                     style: GoogleFonts.poppins(
                         textStyle: TextStyle(
                           fontSize: 12,
                           fontWeight: FontWeight.w300,
                           color: Colors.black,
                         )),
                   ),
                 ],
               ),
             ),
             SizedBox(height: 15,),
             InkWell(
               onTap: () {
                 //  _bottomSheetAtShop(context);
                 setState(() {
                   _selectPlace = "ServiceProvider";
                   //_showDocument=true;
                 });
               },
               child: Row(
                 children: [
                   _selectPlace == "ServiceProvider"
                       ? Icon(Icons.radio_button_checked_rounded,
                       color: AppColor.green, size: 18)
                       : Icon(Icons.radio_button_off,
                       size: 18, color: AppColor.primaryColor),
                   SizedBox(
                     width: 10,
                   ),
                   Text(
                     "I found another service provider",
                     style: GoogleFonts.poppins(
                         textStyle: TextStyle(
                           fontSize: 12,
                           fontWeight: FontWeight.w300,
                           color: Colors.black,
                         )),
                   ),
                 ],
               ),
             ),
             SizedBox(height: 15,),
             InkWell(
               onTap: () {
                 //  _bottomSheetHomeVisit(context);
                 setState(() {
                   _selectPlace = "automatically";

                 });
               },
               child: Row(
                 children: [
                   _selectPlace == "automatically"
                       ? Icon(Icons.radio_button_checked_rounded,
                       color: AppColor.green, size: 18)
                       : Icon(Icons.radio_button_off,
                       size: 18, color: AppColor.primaryColor),
                   SizedBox(
                     width: 10,
                   ),
                   Text(
                     "My issue was resolved automatically ",
                     style: GoogleFonts.poppins(
                         textStyle: TextStyle(
                           fontSize: 12,
                           fontWeight: FontWeight.w300,
                           color: Colors.black,
                         )),
                   ),
                 ],
               ),
             ),

           ],
         ),
       ),


     );
   }


 }
