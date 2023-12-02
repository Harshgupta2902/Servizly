
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../helper/constant.dart';

class PaymentOption extends StatefulWidget {
  const PaymentOption({Key? key}) : super(key: key);

  @override
  State<PaymentOption> createState() => _PaymentOptionState();
}

class _PaymentOptionState extends State<PaymentOption> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 100,
        titleSpacing: 0,
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          "Payment Option",
          style: GoogleFonts.poppins(
              textStyle: TextStyle(
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
          //   child: InkWell(
          //       onTap: () {
          //         Helper.moveToScreenwithPush(context, EditProfile());
          //       },
          //       child: Image.asset(ProjectImage.editprofile,height: 40,width: 40,)),
          // ),
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Container(
              height: 130,
              decoration: BoxDecoration(
                color: Colors.white,
                // border: Border.all(color: AppColor.secondaryColor, width: 2),
                borderRadius: BorderRadius.only(bottomLeft:Radius.circular(30),bottomRight:Radius.circular(30) ),
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
              child:  Column(children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 16),
                  height: 25,
                  width: 25,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border:
                      Border.all(width: 1.5, color: Colors.greenAccent)),
                  child:Text(
                    "Payment Option",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        )),
                  ),
                ),
                // Dash(
                //     direction: Axis.vertical,
                //     length: 130,
                //     dashLength: 15,
                //     dashColor: Colors.grey),
                // Container(
                //   height: 25,
                //   width: 25,
                //   decoration: BoxDecoration(
                //       shape: BoxShape.rectangle,
                //       border: Border.all(width: 2, color: Colors.grey)),
                //   child: Container(
                //     height: 20,
                //   ),
                // ),
              ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
