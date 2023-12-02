import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:serviceapplatest/helper/constant.dart';
import '../bottom_screens/bottom.dart';
import '../bottom_screens/home_screen.dart';
import '../helper/image.dart';
import '../others/feedback.dart';

  class PaymentSuccessful extends StatefulWidget {
    const PaymentSuccessful({Key? key}) : super(key: key);

    @override
    State<PaymentSuccessful> createState() => _PaymentSuccessfulState();
  }

  class _PaymentSuccessfulState extends State<PaymentSuccessful> {
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Color(0xFFe9e9e9),
            appBar:  AppBar(
              elevation: 0,
              toolbarHeight:100,
              titleSpacing: 0,
              backgroundColor: Color(0xFFf5f5f5),
              centerTitle: true,
              title: Text(
                "Booking Confirmation",
                style: GoogleFonts.poppins(textStyle: TextStyle(
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
            ),
            body: Stack(
              children: [
                   Container(
                     height: MediaQuery.of(context).size.height,
                     width: MediaQuery.of(context).size.width,
                     padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                     child: Column(

                       children: [
                         SizedBox(height: 20,),
                         Image.asset(ProjectImage.rightSym,height: 200,),
                         //Text Payment Successful...................................
                         SizedBox(height: 30,),
                         Text("Payement Successful",
                           style: TextStyle
                             (fontWeight: FontWeight.w600,
                               color: Color(0xFF222222),fontSize: 20,
                           ),
                         ),
                         SizedBox(height: 10,),
                         Text("Transucation number:149538292332",
                           style: TextStyle
                             (fontWeight: FontWeight.w600,
                             color: Color(0xFF8c8c8c),fontSize: 15,
                           ),
                         ),
                         Divider(
                           color: Color(0xFF8c8c8c),
                           height: 30,
                           thickness: 2,
                           indent: 0,
                           endIndent: 15,
                         ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text("Amount Paid",
                                style: TextStyle
                                  (fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  color: Color(0xFF222222)),),
                              Text("\$277",
                                style: TextStyle
                                  (fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF20be79)),)

                            ],
                          ),
                          SizedBox(height: 15,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                           children: [
                             Text("Payed By",
                               style: TextStyle
                                 (fontSize: 15,
                                   fontWeight: FontWeight.w500,
                                   color: Color(0xFF222222)),),
                             Text("Debit Card",
                               style: TextStyle
                                 (fontSize: 15,
                                   fontWeight: FontWeight.w500,
                                   color: Color(0xFF20be79)),)
                           ],
                         ),

                         SizedBox(height: 60,),
                         ElevatedButton(
                           style: ElevatedButton.styleFrom(
                             primary: Color(0xFF09bdfc),
                             minimumSize: const Size.fromHeight(50),
                             shape: RoundedRectangleBorder( //to set border radius to button
                                 borderRadius: BorderRadius.circular(25)
                             ),
                             // NEW
                           ),
                           onPressed: () {
                           //  Navigator.push(context, MaterialPageRoute(builder: (context) =>Bottom()));
                             Navigator.push(context,MaterialPageRoute(builder: (context)=>FeedBack()));
                           },
                           child: const Text(
                             'Go to Home',
                             style: TextStyle(fontSize: 24),
                           ),
                         ),
                       ],
                     ),
                   )
                ],

            )
      );
    }
  }
