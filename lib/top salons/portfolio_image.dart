import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:serviceapplatest/helper/constant.dart';

import '../helper/image.dart';



class PortfolioImage extends StatefulWidget {
  String image="";

  PortfolioImage({required this.image});

  @override
  State<PortfolioImage> createState() => _PortfolioImageState();
}

class _PortfolioImageState extends State<PortfolioImage> {



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("image===============>${widget.image}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight:100,
        titleSpacing: 0,
        backgroundColor: Color(0xFFFFFFFF),
        centerTitle: true,
        title: Text(
          "Portfolio",
          style: GoogleFonts.poppins(textStyle: TextStyle(
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
      ),
      body: Container(
        height: MediaQuery.of(context).size.height*0.70,
        width:MediaQuery.of(context).size.width,
       padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
       child: ClipRRect(
         borderRadius: BorderRadius.circular(15),
         child: CachedNetworkImage(
           imageUrl:widget.image, //widget.image,
           fit: BoxFit.fill,
           width: 60,
           height: 60,
           placeholder: (context, url) =>
               LinearProgressIndicator(
                 color: Colors.grey.withOpacity(0.2),
                 backgroundColor:
                 Colors.grey.withOpacity(.5),
               ),
           errorWidget: (context, url, error) =>
               Container(
                 width: 240,
                 height: 220,
                 // padding: EdgeInsets.symmetric(vertical: 25.0),
                 decoration: BoxDecoration(
                     borderRadius: BorderRadius.all(
                       Radius.circular(20),
                     ),
                     color: Color(0xFFD9D9D9)),
                 child: Center(
                   child: Image.asset(ProjectImage.google,
                     width: 150, height: 300,fit: BoxFit.cover,),
                 ),
               ),
         ),
       ),
      ),
    );
  }
}
