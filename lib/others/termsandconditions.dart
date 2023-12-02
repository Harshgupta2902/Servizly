import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:serviceapplatest/helper/constant.dart';
import '../helper/image.dart';

 class TermsAndConditions extends StatefulWidget {
   const TermsAndConditions({Key? key}) : super(key: key);

   @override
   State<TermsAndConditions> createState() => _TermsAndConditionsState();
 }

 class _TermsAndConditionsState extends State<TermsAndConditions> {
   @override
   Widget build(BuildContext context) {
     return Scaffold(
               backgroundColor: Color(0xFFfefefe),
                                           //AppBar.........................................
                appBar: AppBar(
                  elevation: 4,
                  toolbarHeight: 100,
                  titleSpacing: 0,
                  backgroundColor: Color(0xFFf5f5f5),
                  centerTitle:  true,
                  title: Text("Terms And Condition",
                      style: GoogleFonts.poppins(
                          fontSize: 20,fontWeight: FontWeight.w600
                      ,color: Colors.black),
                  ),
                leading: InkWell(
                  onTap: (){
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
                  padding: EdgeInsets.symmetric(horizontal: 25,vertical: 25),
                 child: Column(
                   children: [
                       Image.asset(ProjectImage.rmBag),
                     Text(
                       "Lorem Ipsum is simply dummy text of the printing and typesetting industry."
                           " Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,"
                           " when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                       style: GoogleFonts.poppins(
                           color: Color(0xFF7E7E7E),
                           fontWeight: FontWeight.w300,
                           fontSize: 20
                       ),
                     ),
                     SizedBox(height: 20,),
                     MaterialButton(
                       color: Color(0xFF09BDFC),
                       minWidth: MediaQuery.of(context).size.width,
                       height: 55,
                       textColor: Colors.white,
                       child: Text("I Agree",
                         style: GoogleFonts.poppins(
                             color: Colors.white,
                             fontWeight: FontWeight.w600,
                             fontSize: 18
                         ),
                       ),
                       shape: RoundedRectangleBorder(
                           borderRadius: BorderRadius.circular(30)),
                       onPressed: () {
                       },
                     ),

                   ],
                 ),
              ),


     );
   }
 }
