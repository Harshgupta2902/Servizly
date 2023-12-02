import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../helper/constant.dart';
import '../../helper/image.dart';
import 'Registration screen/login.dart';


class PageViewScreen extends StatefulWidget {
  const PageViewScreen({Key? key}) : super(key: key);

  @override
  State<PageViewScreen> createState() => _PageViewScreenState();
}

class _PageViewScreenState extends State<PageViewScreen> {

  String? image1;
  String? image2;
  String? image3;

@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController();
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            /// [PageView.scrollDirection] defaults to [Axis.horizontal].
            /// Use [Axis.vertical] to scroll vertically.
            controller: controller,
            allowImplicitScrolling: true,
            children:[
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                // decoration: BoxDecoration(
                //     image: DecorationImage(
                //         image: AssetImage(ProjectImage.welcome1),
                //         fit: BoxFit.fill
                //     )
                // ),
                child: Padding(
                  padding:  const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 20,horizontal: 0),
                          child: Image.asset(ProjectImage.welcome1)),
                      Text("How to install the App?",
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold
                            )),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 40,horizontal: 0),
                        child: Center(
                          child: Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text.",
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xff7E7E7E),
                                    fontWeight: FontWeight.w300
                                )),
                          ),
                        ),
                      ),
                      // SizedBox(height: 55,),
                      // Image.asset(ProjectImage.logo),
                      // Expanded(child: SizedBox()),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.circle,color: Colors.black,size: 15,),
                              SizedBox(width: 15,),
                              Icon(Icons.circle,size: 15,color: Colors.black.withOpacity(.4)),
                              SizedBox(width: 15,),
                              Icon(Icons.circle,size: 15,color: Colors.black.withOpacity(.4))
                            ],
                          ),
                          ElevatedButton(onPressed:() {Helper.moveToScreenwithPushreplaceemt(context, LoginScreen());} ,
                            child: Icon(Icons.arrow_forward_ios), style: ElevatedButton.styleFrom(
                              primary: Colors.black,
                              shape: CircleBorder(),
                              padding: EdgeInsets.all(15),
                            ),
                          ),
                        ],
                      ),

                    ],
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                // decoration: BoxDecoration(
                //     image: DecorationImage(
                //         image: AssetImage(ProjectImage.welcome1),
                //         fit: BoxFit.fill
                //     )
                // ),
                child: Padding(
                  padding:  const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          padding: EdgeInsets.symmetric(vertical: 20,horizontal: 0),
                          child: Image.asset(ProjectImage.welcome2)),
                      Text("How to Book service?",
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold
                            )),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 40,horizontal: 0),
                        child: Center(
                          child: Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text.",
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xff7E7E7E),
                                    fontWeight: FontWeight.w300
                                )),
                          ),
                        ),
                      ),
                      // SizedBox(height: 55,),
                      // Image.asset(ProjectImage.logo),
                      // Expanded(child: SizedBox()),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [

                              Icon(Icons.circle,size: 15,color: Colors.black.withOpacity(.4)),
                              SizedBox(width: 15,),
                              Icon(Icons.circle,color: Colors.black,size: 15,),

                              SizedBox(width: 15,),
                              Icon(Icons.circle,size: 15,color: Colors.black.withOpacity(.4))
                            ],
                          ),
                          ElevatedButton(onPressed:() {Helper.moveToScreenwithPushreplaceemt(context, LoginScreen());} ,
                            child: Icon(Icons.arrow_forward_ios), style: ElevatedButton.styleFrom(
                              primary: Colors.black,
                              shape: CircleBorder(),
                              padding: EdgeInsets.all(15),
                            ),
                          ),
                        ],
                      ),

                    ],
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                // decoration: BoxDecoration(
                //     image: DecorationImage(
                //         image: AssetImage(ProjectImage.welcome1),
                //         fit: BoxFit.fill
                //     )
                // ),
                child: Padding(
                  padding:  const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          padding: EdgeInsets.symmetric(vertical: 20,horizontal: 0),
                          child: Image.asset(ProjectImage.welcome3)),
                      Text("How to pay for service?",
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold
                            )),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 40,horizontal: 0),
                        child: Center(
                          child: Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text.",
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xff7E7E7E),
                                    fontWeight: FontWeight.w300
                                )),
                          ),
                        ),
                      ),
                      // SizedBox(height: 55,),
                      // Image.asset(ProjectImage.logo),
                      // Expanded(child: SizedBox()),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.circle,size: 15,color: Colors.black.withOpacity(.4)),
                              SizedBox(width: 15,),
                              Icon(Icons.circle,size: 15,color: Colors.black.withOpacity(.4)),
                              SizedBox(width: 15,),
                              Icon(Icons.circle,color: Colors.black,size: 15,),
                            ],
                          ),
                          ElevatedButton(onPressed:() {Helper.moveToScreenwithPushreplaceemt(context, LoginScreen());} ,
                            child: Icon(Icons.arrow_forward_ios), style: ElevatedButton.styleFrom(
                              primary: Colors.black,
                              shape: CircleBorder(),
                              padding: EdgeInsets.all(15),
                            ),
                          ),
                        ],
                      ),

                    ],
                  ),
                ),
              ),
              // Container(
              //   height: MediaQuery.of(context).size.height,
              //   width: MediaQuery.of(context).size.width,
              //   decoration:  BoxDecoration(
              //       image: DecorationImage(
              //           image: AssetImage(ProjectImage.welcome2),
              //           fit: BoxFit.fill
              //       )
              //   ),
              //   child: Padding(
              //     padding:  const EdgeInsets.only(left: 40.0,bottom: 60),
              //     child: Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         const SizedBox(height: 55,),
              //         Image.asset(ProjectImage.logo),
              //         const Expanded(child: SizedBox()),
              //
              //         Row(
              //           children: [
              //             Icon(Icons.circle,size: 20,color: Colors.white.withOpacity(.4)),
              //             const SizedBox(width: 15,),
              //             const Icon(Icons.circle,color: Colors.white,size: 20,),
              //             const SizedBox(width: 15,),
              //             Icon(Icons.circle,size: 20,color: Colors.white.withOpacity(.4))
              //           ],
              //         ),
              //         const SizedBox(height: 50,),
              //
              //         Text("Home Pickup & Delivery\nService",
              //           style: GoogleFonts.quicksand(
              //               textStyle: TextStyle(
              //                   fontSize: 20,
              //                   height: 2,
              //                   color: Colors.white,
              //                   fontWeight: FontWeight.w300
              //               )),
              //         ),
              //         const SizedBox(height: 40,),
              //         Text("Book your order with us and get home\npickup & delivery service facility.",
              //           style: GoogleFonts.quicksand(
              //               textStyle: TextStyle(
              //                   fontSize: 14,
              //                   height: 1.5,
              //                   color: Colors.white,
              //                   fontWeight: FontWeight.w100
              //               )),
              //         ),
              //         const SizedBox(height: 55,),
              //         Padding(
              //           padding:  const EdgeInsets.only(right: 40.0),
              //           child: Row(
              //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //             children: [
              //               InkWell(
              //                 child:  Padding(
              //                   padding: EdgeInsets.all(8.0),
              //                   child: Text("Skip",
              //                     style: GoogleFonts.quicksand(
              //                         textStyle: TextStyle(
              //                             fontSize: 20,
              //                             letterSpacing: 1,
              //                             color: Colors.white
              //                         )),
              //                   ),
              //                 ),
              //                 onTap: () {
              //                   Helper.moveToScreenwithPushreplaceemt(context, LoginScreen());
              //                 },
              //               ),
              //               MaterialButton(
              //                 onPressed: () {
              //                   // thirdPage(context);
              //                   Helper.moveToScreenwithPushreplaceemt(context, LoginScreen());
              //                   // Navigator.of(context).pushReplacement(_createRoute());
              //                 },
              //                 height: 48,
              //                 minWidth: 125,
              //                 color: Colors.white,
              //                 child: Row(
              //                   children:  [
              //                     Text(
              //                       "Next",
              //                       style: GoogleFonts.quicksand(
              //                           textStyle: TextStyle(
              //                             fontWeight: FontWeight.w400,
              //                             fontSize: 18,
              //                             color: Color(0xFF1b5761),
              //                           )),
              //                     ),
              //                     SizedBox(width: 8,),
              //                     Icon(Icons.arrow_forward_ios,color: Color(0xFF1b5761),size: 16,)
              //                   ],
              //                 ),
              //                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
              //               ),
              //             ],
              //           ),
              //         ),
              //
              //       ],
              //     ),
              //   ),
              // ),
              // Container(
              //   height: MediaQuery.of(context).size.height,
              //   width: MediaQuery.of(context).size.width,
              //   decoration:  BoxDecoration(
              //       image: DecorationImage(
              //           image: AssetImage(ProjectImage.welcome3),
              //           fit: BoxFit.fill
              //       )
              //   ),
              //   child: Padding(
              //     padding:   EdgeInsets.only(left: 40.0,bottom: 60),
              //     child: Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         const SizedBox(height: 55,),
              //         Image.asset(ProjectImage.logo),
              //         const Expanded(child: SizedBox()),
              //
              //         Row(
              //           children: [
              //             Icon(Icons.circle,size: 20,color: Colors.white.withOpacity(.4)),
              //             const SizedBox(width: 15,),
              //             Icon(Icons.circle,size: 20,color: Colors.white.withOpacity(.4)),
              //             const SizedBox(width: 15,),
              //             const Icon(Icons.circle,color: Colors.white,size: 20,),
              //           ],
              //         ),
              //         const SizedBox(height: 50,),
              //
              //         Text("Uncompromised Quality\n& Service",
              //           style: GoogleFonts.quicksand(
              //               textStyle: TextStyle(
              //                   fontSize: 20,
              //                   height: 2,
              //                   color: Colors.white,
              //                   fontWeight: FontWeight.w300
              //               )),
              //         ),
              //         const SizedBox(height: 40,),
              //         const Text("Hellowash provides the best laundry\nservice in the city.",
              //           style: TextStyle(
              //               fontSize: 14,
              //               height: 1.5,
              //               color: Colors.white,
              //               fontWeight: FontWeight.w200
              //           ),
              //         ),
              //         const SizedBox(height: 55,),
              //         Padding(
              //           padding:  const EdgeInsets.only(right: 40.0),
              //           child: Row(
              //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //             children: [
              //               InkWell(
              //                 child:  Padding(
              //                   padding: EdgeInsets.all(8.0),
              //                   child: Text("Skip",
              //                     style: GoogleFonts.quicksand(
              //                         textStyle: TextStyle(
              //                             fontSize: 20,
              //                             letterSpacing: 1,
              //                             color: Colors.white
              //                         )),
              //                   ),
              //                 ),
              //                 onTap: () {
              //                   Helper.moveToScreenwithPushreplaceemt(context, LoginScreen());
              //                   // Navigator.of(context).pushReplacement(_createRoute());
              //                 },
              //               ),
              //               MaterialButton(
              //                 onPressed: () {
              //                   Helper.moveToScreenwithPushreplaceemt(context, LoginScreen());
              //                   // Navigator.of(context).pushReplacement(_createRoute());
              //                 },
              //                 height: 48,
              //                 minWidth: 125,
              //                 color: Colors.white,
              //                 child: Row(
              //                   children:  [
              //                     Text(
              //                       "Next",
              //                       style: GoogleFonts.quicksand(
              //                           textStyle: TextStyle(
              //                             fontWeight: FontWeight.w400,
              //                             fontSize: 18,
              //                             color: Color(0xFF1b5761),
              //                           )),
              //                     ),
              //                     SizedBox(width: 8,),
              //                     Icon(Icons.arrow_forward_ios,color: Color(0xFF1b5761),size: 16,)
              //                   ],
              //                 ),
              //                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
              //               ),
              //             ],
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              // firstPage(context),
              // secondPage(context),
              // thirdPage(context)
            ],
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: Helper.getProgressBarWhite(context, _isVisible),
            ),
          ),
        ],
      ),
    );
  }
  @override
  initState() {
    // TODO: implement initState
    super.initState();
    image1 = ProjectImage.welcome1;
    image2 = ProjectImage.welcome2;
    image3 = ProjectImage.welcome3;
  }

  firstPage(context){
   return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(ProjectImage.welcome1),
              fit: BoxFit.fill
          )
      ),
      child: Padding(
        padding:  const EdgeInsets.only(left: 40.0,bottom: 60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 55,),
            Image.asset(ProjectImage.logo),
            const Expanded(child: SizedBox()),

            Row(
              children: [
                const Icon(Icons.circle,color: Colors.white,size: 20,),
                const SizedBox(width: 15,),
                Icon(Icons.circle,size: 20,color: Colors.white.withOpacity(.4)),
                const SizedBox(width: 15,),
                Icon(Icons.circle,size: 20,color: Colors.white.withOpacity(.4))
              ],
            ),
            const SizedBox(height: 50,),

            Text("One stop shop for your",
              style: GoogleFonts.quicksand(
                  textStyle: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w200
                  )),
            ),
            const SizedBox(height: 20,),
            Text("Laundry requirement",
                style: GoogleFonts.quicksand(
                  textStyle: TextStyle(
                      fontSize: 22,
                      letterSpacing: 1,
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                  ),)
            ),
            const SizedBox(height: 55,),
            Text("Book your order now to get on\ninstant pickup within 2hrs!",
                style: GoogleFonts.quicksand(
                  textStyle: TextStyle(
                      fontSize: 16,
                      height: 1.5,
                      color: Colors.white,
                      fontWeight: FontWeight.w100
                  ),)
            ),

            const SizedBox(height: 55,),
            Padding(
              padding:  const EdgeInsets.only(right: 40.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    child:  Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Skip",
                        style: GoogleFonts.quicksand(
                            textStyle: TextStyle(
                                fontSize: 20,
                                letterSpacing: 1,
                                color: Colors.white
                            )),
                      ),
                    ),
                    onTap: () {
                      Helper.moveToScreenwithPushreplaceemt(context, LoginScreen());
                    },
                  ),
                  // InkWell(
                  //   child: Container(
                  //     decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(25),
                  //       color: Colors.white
                  //     ),
                  //    child: Row(
                  //       children:  [
                  //         Text(
                  //           "Next",
                  //           style: GoogleFonts.quicksand(
                  //               textStyle: TextStyle(
                  //                 fontWeight: FontWeight.w400,
                  //                 fontSize: 18,
                  //                 color: Color(0xFF1b5761),
                  //               )),
                  //         ),
                  //         SizedBox(width: 8,),
                  //         Icon(Icons.arrow_forward_ios,color: Color(0xFF1b5761),size: 16,)
                  //       ],
                  //     ),
                  //   ),
                  //   onTap: () {
                  //     Helper.moveToScreenwithPushreplaceemt(context, OnBoardSecond());
                  //   },
                  // )
                  MaterialButton(
                    onPressed: () {
                      secondPage(context);
                      // Helper.moveToScreenwithPushreplaceemt(context, OnBoardFirst());
                      // Navigator.of(context).pushReplacement(_createRoute());
                    },

                    height: 48,
                    minWidth: 125,
                    color: Colors.white,
                    child: Row(
                      children:  [
                        Text(
                          "Next",
                          style: GoogleFonts.quicksand(
                              textStyle: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 18,
                                color: Color(0xFF1b5761),
                              )),
                        ),
                        SizedBox(width: 8,),
                        Icon(Icons.arrow_forward_ios,color: Color(0xFF1b5761),size: 16,)
                      ],
                    ),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
  secondPage(context){
   return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration:  BoxDecoration(
          image: DecorationImage(
              image: AssetImage(ProjectImage.welcome2),
              fit: BoxFit.fill
          )
      ),
      child: Padding(
        padding:  const EdgeInsets.only(left: 40.0,bottom: 60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 55,),
            Image.asset(ProjectImage.logo),
            const Expanded(child: SizedBox()),

            Row(
              children: [
                Icon(Icons.circle,size: 20,color: Colors.white.withOpacity(.4)),
                const SizedBox(width: 15,),
                const Icon(Icons.circle,color: Colors.white,size: 20,),
                const SizedBox(width: 15,),
                Icon(Icons.circle,size: 20,color: Colors.white.withOpacity(.4))
              ],
            ),
            const SizedBox(height: 50,),

            Text("Home Pickup & Delivery\nService",
              style: GoogleFonts.quicksand(
                  textStyle: TextStyle(
                      fontSize: 20,
                      height: 2,
                      color: Colors.white,
                      fontWeight: FontWeight.w300
                  )),
            ),
            const SizedBox(height: 40,),
            Text("Book your order with us and get home\npickup & delivery service facility.",
              style: GoogleFonts.quicksand(
                  textStyle: TextStyle(
                      fontSize: 16,
                      height: 1.5,
                      color: Colors.white,
                      fontWeight: FontWeight.w100
                  )),
            ),
            const SizedBox(height: 55,),
            Padding(
              padding:  const EdgeInsets.only(right: 40.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    child:  Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Skip",
                        style: GoogleFonts.quicksand(
                            textStyle: TextStyle(
                                fontSize: 20,
                                letterSpacing: 1,
                                color: Colors.white
                            )),
                      ),
                    ),
                    onTap: () {
                      Helper.moveToScreenwithPushreplaceemt(context, LoginScreen());
                    },
                  ),
                  MaterialButton(
                    onPressed: () {
                      thirdPage(context);
                      // Helper.moveToScreenwithPushreplaceemt(context, OnBoardThird());
                      // Navigator.of(context).pushReplacement(_createRoute());
                    },
                    height: 48,
                    minWidth: 125,
                    color: Colors.white,
                    child: Row(
                      children:  [
                        Text(
                          "Next",
                          style: GoogleFonts.quicksand(
                              textStyle: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 18,
                                color: Color(0xFF1b5761),
                              )),
                        ),
                        SizedBox(width: 8,),
                        Icon(Icons.arrow_forward_ios,color: Color(0xFF1b5761),size: 16,)
                      ],
                    ),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
  thirdPage(context){
  return  Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration:  BoxDecoration(
          image: DecorationImage(
              image: AssetImage(ProjectImage.welcome3),
              fit: BoxFit.fill
          )
      ),
      child: Padding(
        padding:   EdgeInsets.only(left: 40.0,bottom: 60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 55,),
            Image.asset(ProjectImage.logo),
            const Expanded(child: SizedBox()),

            Row(
              children: [
                Icon(Icons.circle,size: 20,color: Colors.white.withOpacity(.4)),
                const SizedBox(width: 15,),
                Icon(Icons.circle,size: 20,color: Colors.white.withOpacity(.4)),
                const SizedBox(width: 15,),
                const Icon(Icons.circle,color: Colors.white,size: 20,),
              ],
            ),
            const SizedBox(height: 50,),

            Text("Uncompromised Quality\n& Service",
              style: GoogleFonts.quicksand(
                  textStyle: TextStyle(
                      fontSize: 20,
                      height: 2,
                      color: Colors.white,
                      fontWeight: FontWeight.w300
                  )),
            ),
            const SizedBox(height: 40,),
            const Text("Hellowash provides the best laundry\nservice in the city.",
              style: TextStyle(
                  fontSize: 18,
                  height: 1.5,
                  color: Colors.white,
                  fontWeight: FontWeight.w200
              ),
            ),
            const SizedBox(height: 55,),
            Padding(
              padding:  const EdgeInsets.only(right: 40.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    child:  Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Skip",
                        style: GoogleFonts.quicksand(
                            textStyle: TextStyle(
                                fontSize: 20,
                                letterSpacing: 1,
                                color: Colors.white
                            )),
                      ),
                    ),
                    onTap: () {
                      Helper.moveToScreenwithPushreplaceemt(context, LoginScreen());
                      // Navigator.of(context).pushReplacement(_createRoute());
                    },
                  ),
                  MaterialButton(
                    onPressed: () {
                      Helper.moveToScreenwithPushreplaceemt(context, LoginScreen());
                      // Navigator.of(context).pushReplacement(_createRoute());
                    },
                    height: 48,
                    minWidth: 125,
                    color: Colors.white,
                    child: Row(
                      children:  [
                        Text(
                          "Next",
                          style: GoogleFonts.quicksand(
                              textStyle: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 18,
                                color: Color(0xFF1b5761),
                              )),
                        ),
                        SizedBox(width: 8,),
                        Icon(Icons.arrow_forward_ios,color: Color(0xFF1b5761),size: 16,)
                      ],
                    ),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


  bool _isVisible = false;

  setProgress(bool show) {
    if (mounted)
      setState(() {
        _isVisible = show;
      });
  }
}


