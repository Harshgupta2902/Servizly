import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';

import '../helper/constant.dart';

class Review extends StatefulWidget {




  @override
  State<Review> createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height:MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 90,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RichText(
                          text: TextSpan(children: [
                            TextSpan(text: "5.0",
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      fontSize: 24, fontWeight: FontWeight.w500,color:AppColor.primaryColor ),
                                )),
                            WidgetSpan(
                              child: Transform.translate(
                                offset: const Offset(-2, 4),
                                child: Text(
                                    '/5',
                                    //superscript is usually smaller in size
                                    style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          fontSize: 16, fontWeight: FontWeight.w500,color:AppColor.primaryColor ),
                                    )
                                ),
                              ),
                            )
                          ]),
                        ),
                        RatingBar.builder(
                          initialRating: 3,
                          minRating: 1,
                          itemSize: 20,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Color(0xFFFFCC00),
                          ),
                          onRatingUpdate: (rating) {
                            print(rating);
                          },
                        )
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      height: 40,
                      child: VerticalDivider(
                        color: Colors.grey,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 100,
                          child: Text("Based on\n40 Reviews",
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w400,color:AppColor.primaryColor ),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),

                      ],
                    ),
                  ],
                ),
              ),
              ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  itemCount: 4,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      child: Column(
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 20.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    RatingBar.builder(
                                      initialRating: 3,
                                      minRating: 1,
                                      itemSize: 25,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                                      itemBuilder: (context, _) => Icon(
                                        Icons.star,
                                        color: Color(0xFFFFCC00),
                                      ),
                                      onRatingUpdate: (rating) {
                                        print(rating);
                                      },
                                    ),
                                    Text("04/01/2023",
                                      style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            fontSize: 16, fontWeight: FontWeight.w400,color:AppColor.primaryColor ),
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Alex",
                                    style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          fontSize: 16, fontWeight: FontWeight.w400,color:AppColor.primaryColor ),
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  Text("Amazing",
                                    style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          fontSize: 16, fontWeight: FontWeight.w400,color:AppColor.primaryColor ),
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10.0),
                                child: Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                                  style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                      fontSize: 12, fontWeight: FontWeight.w400,color:AppColor.primaryColor,),
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ],
                          )

                        ],
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),




    );

  }
}
