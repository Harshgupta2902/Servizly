import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:serviceapplatest/helper/constant.dart';
import '../Payment/addnewcard.dart';
import '../helper/image.dart';


 class ExpertProfile extends StatefulWidget {
   const ExpertProfile({Key? key}) : super(key: key);

   @override
   State<ExpertProfile> createState() => _ExpertProfileState();
 }

 class _ExpertProfileState extends State<ExpertProfile> {

   @override
   Widget build(BuildContext context) {
     return Scaffold(
       backgroundColor: Color(0xFFffffff),
           appBar:  AppBar(
             elevation: 0,
             toolbarHeight:100,
             titleSpacing: 0,
             backgroundColor: Color(0xFFf5f5f5),
             centerTitle: true,
             title: Text(
               "Salon",
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
            body: Column(
              children: [
                Stack(
                  children: [
                    Container
                      (
                      height:305,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.white,
                      child: Column(
                        children: [
                          Image.asset(ProjectImage.hairCutPic,height:206),
                          SizedBox(height: 10,),
                        ],
                      ),
                    ),
                    Positioned    (
                        top: 155,
                        left: 55,
                        child:Row(
                          children: [
                            Container(
                              height: 130,
                              width:  120,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: AssetImage(ProjectImage.Maskgroup),

                                ),
                                borderRadius: BorderRadius.all(Radius.circular(10),

                                ),
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
                              child: Column(
                                children: [
                                  Padding(
                                    padding:  EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                          ],
                                        ),


                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 50,),
                                Text("Alex",style: TextStyle(fontSize: 28,color: Color(0xFF373737),
                                    fontWeight: FontWeight.w600),
                                ),
                                SizedBox(height: 5,),
                                Text("Hair Saloan",style: TextStyle(fontSize: 28,color: Color(0xFF373737),
                                    fontWeight: FontWeight.w300),
                                ),
                                Row(
                                  children: [
                                    Image.asset(ProjectImage.star,height: 20,),
                                    SizedBox(width: 10,),
                                    Text("4.9",),
                                    SizedBox(width: 10,),
                                    Text("(59)",style: TextStyle(color: Color(0xFF9d9d9d)),)
                                  ],
                                )
                              ],
                            )
                          ],
                        )

                    ),
                  ],
                ),
                Container(
                  height: 50,
                  width:  300,
                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                  decoration: BoxDecoration(
                    border: Border.all(width: 2, color: Color(0xFFeeeeee)),
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    color: Color(0xFFffffff),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.green,
                      ),
                      BoxShadow(
                        color: Colors.white70,
                        spreadRadius: -50.0,
                        blurRadius: 50.0,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.circle,color: Color(0xFF515151),size: 30,),
                      Text("Home Visit",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 15),),
                      Text("At Salon",style: TextStyle(color: Color(0xFFa9a9a9),fontWeight: FontWeight.w600,fontSize: 15),)
                    ],
                  ),
                ),
                SizedBox(height: 15,),
                Expanded(
                  child: MediaQuery.removePadding(context: context, removeTop: true,
                    child: SingleChildScrollView(
                      child: ListView.builder(
                          itemCount: 10,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          physics: NeverScrollableScrollPhysics() ,
                          itemBuilder: (context,index) {
                            return Stack(
                              children: [
                                Padding(

                                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                  child: Container(
                                    margin: EdgeInsets.all(5),
                                    height: 80,
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width,
                                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                    decoration: BoxDecoration(
                                      border: Border.all(width: 2, color: Color(0xFFeeeeee)),
                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                      color: Color(0xFFffffff),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.green,
                                        ),
                                        BoxShadow(
                                          color: Colors.white70,
                                          spreadRadius: -50.0,
                                          blurRadius: 50.0,
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "Hair Cut", style: TextStyle(color: Color(0xFF373737),
                                                fontWeight: FontWeight.w500,
                                                fontSize: 20),
                                            ),
                                            SizedBox(width: 15,),
                                            Text("\$100", style: TextStyle(color: Color(0xFF373737),
                                                fontWeight: FontWeight.w400,
                                                fontSize: 20),
                                            )

                                          ],
                                        ),
                                        SizedBox(height: 10,),
                                        Text("45 min", style: TextStyle(color: Color(0xFF373737),
                                            fontWeight: FontWeight.w400,
                                            fontSize: 15),
                                        ),

                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 16,
                                  right: 0,
                                  child: Container(
                                    height:  50,
                                    width: 90,
                                    color: Colors.white,

                                    child: Column(
                                      children: [
                                        SizedBox(
                                            height:50, //height of button
                                            width:90, //width of button
                                            child:ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    primary: Color(0xFF737373), //background color of button
                                                    side: BorderSide(width:3, color:Color(0xFF737373)), //border width and color
                                                    elevation: 3, //elevation of button
                                                    shape: RoundedRectangleBorder( //to set border radius to button
                                                        borderRadius: BorderRadius.circular(10)
                                                    ),
                                                    padding: EdgeInsets.all(20) //content padding inside button
                                                ),
                                                onPressed: (){
                                                  //code to execute when this button is pressed.
                                                },
                                                child: Text("Book Now",style: TextStyle(fontSize: 10),)
                                            )
                                        )
                                      ],
                                    ),

                                  ),
                                )
                              ],
                            );
                          }
                      ),
                    ),
                  ),

                ),
                Positioned   (
                    bottom: 0,
                    child:Container(
                      height: 70,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10)
                        ),
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

                        children: [
                          Padding(
                            padding:  EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                 mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Image.asset(ProjectImage.solon_logo1,height: 40,),
                                    SizedBox(width: 15,),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text("Lemongrass Salon",style: TextStyle(fontSize: 15,color: Color(0xFF1D1D1D),
                                            fontWeight:FontWeight.w600 ),),
                                        SizedBox(height: 10,),
                                        Text("View Full Services",
                                          style: TextStyle
                                            (fontWeight: FontWeight.w600,
                                              fontSize: 10,
                                              color: Color(0xFF5f5f5f),decoration: TextDecoration.underline,),
                                        ),
                                      ],
                                    ),
                                    SizedBox(width: 50,),
                                    SizedBox(
                                      height: 50,
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.blue, //background color of button
                                              elevation: 3, //elevation of button
                                              shape: RoundedRectangleBorder( //to set border radius to button
                                                  borderRadius: BorderRadius.circular(5)
                                              ),
                                              padding: EdgeInsets.all(5) //content padding inside button
                                          ),
                                          onPressed: (){
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => AddNewCard()));
                                          },
                                          child: Text("Proceed to pay")
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(width: 20,),

                              ],

                            ),
                          ),
                        ],
                      ),
                    )
                )
              ],
            ),


     );

   }


 }
