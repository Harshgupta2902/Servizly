

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../helper/constant.dart';
import '../helper/image.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
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
          "Notification",
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
      body: ListView.builder(
        scrollDirection: Axis.vertical,
      padding: EdgeInsets.symmetric(horizontal: 20),
      itemCount: 10,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          height: 100,
          child: Row(
            children: [
              Container(
                child: Image.asset(ProjectImage.girl,height: 60),
              ),
              SizedBox(
                width: 10,
              ),
              Flexible(child: Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry.", style: GoogleFonts.poppins(textStyle: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ))))
            ],
          ),
        );
      }),
    );
  }
}
