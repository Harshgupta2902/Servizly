

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../helper/constant.dart';
import '../helper/image.dart';

class OurExpert extends StatefulWidget {
  const OurExpert({Key? key}) : super(key: key);

  @override
  State<OurExpert> createState() => _OurExpertState();
}

class _OurExpertState extends State<OurExpert> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight:100,
        titleSpacing: 0,
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          "Salon",
          style: GoogleFonts.poppins(textStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
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
          //   child: Image.asset(ProjectImage.hellowash,height: 55,width: 55,),
          // ),
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 400,
                  child: Image.asset(ProjectImage.ourExperts),
                ),
                Positioned(
                  bottom: 30,
                    left: 10,
                    right: 20,
                    child:  Center(
                      child: Row(
                        children: [
                          Container(
                            width: 100,
                            height: 120,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.red
                            ),
                            child: Image.asset(ProjectImage.alexexpert,fit: BoxFit.fill,),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Fingertip",
                                style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: AppColor.primaryColor,
                                    )),
                              ),
                              Text(
                                "13 Kalani nagar",
                                style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: AppColor.greytext,
                                    )),
                              ),

                            ],
                          ),
                        ],
                      ),
                    )),


              ],
            ),

          ],
        ),
      ),
    );
  }
}
