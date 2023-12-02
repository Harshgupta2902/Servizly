import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:serviceapplatest/helper/constant.dart';
import '../Payment/refund.dart';
import '../bottom_screens/setting.dart';
import '../helper/image.dart';
import 'login.dart';

class Welcome_Screen extends StatefulWidget {
  const Welcome_Screen({Key? key}) : super(key: key);

  @override
  State<Welcome_Screen> createState() => _Welcome_ScreenState();
}

class _Welcome_ScreenState extends State<Welcome_Screen> {

  List onBordingData = [
    {
         // "image":"assets/Images/image-removebg-preview (52) 1 (3).png",
         "image":ProjectImage.welcome1,
         "title":"How to Install The App",
          "description":"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text."

    },
    {
      // "image":"assets/Images/image-removebg-preview (52) 1 (4).png",
      "image":ProjectImage.welcome2,
      "title": "How to Book Service",
      "description": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text."
    },
    {
       // "image": 'assets/Images/image-removebg-preview (52) 1 (5).png',
      "image":ProjectImage.welcome3,
      "title": "How to Install The App",
      "description": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text."
    }
  ];
  int currentPage = 0;
  onChanged(int index){
    setState(() {
      currentPage = index;
    });
  }
   continueMode(){
     Helper.moveToScreenwithPushreplaceemt(context,  RefundScreen());
   }

   PageController pageController = PageController();
  Color whiteColor = Colors.white;
  Color otherColor = Colors.black;

   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("Images..................................................................${onBordingData}");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 100,
        titleSpacing: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          "Welcome Screen",
          style: GoogleFonts.poppins(
              textStyle: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: AppColor.primaryColor,
              ),color: Colors.white),
        ),
      ),
      body:  Stack(
        children: [
           PageView.builder(
             scrollDirection: Axis.horizontal,
             controller: pageController,
             itemCount: onBordingData.length,
               onPageChanged:  onChanged,
               itemBuilder: (context, index) {
                print("Images...................................${onBordingData[index]['image']}");
                   return  Padding(
                     padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.center,
                         children: [
                              // Image.asset(onBordingData[index]['image']==null?"":onBordingData[index]['image']),
                               Image.asset(onBordingData[index]['image'],height: 250),
                               Text( onBordingData[index]['title'],style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 20),),
                               SizedBox(height: 20,),
                               Text( onBordingData[index]['description'],
                                 style: TextStyle
                                   (color: Color(0xFF7e7e7e),fontWeight: FontWeight.w500,fontSize: 15,),),
                         ],
                     ),
                   );

               },



           ),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children:  List<Widget>.generate(onBordingData.length, (index) {
                        return AnimatedContainer(duration: const Duration( milliseconds: 200,
                        ),
                          height: 10,
                          width: (index == currentPage) ? 10 : 10,
                          margin: const  EdgeInsets.symmetric(
                            horizontal: 5,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color:(index == currentPage)?
                            Colors.black
                                : Colors.grey,

                          ),
                        );
                      }),
                    ),
                   // (currentPage == (onBordingData.length -1))?
                           InkWell(
                             onTap: () {
                               Helper.moveToScreenwithPushreplaceemt(context, Setting());
                             },
                             child: ElevatedButton(onPressed: continueMode,
                                 child: Icon(Icons.arrow_forward_ios), style: ElevatedButton.styleFrom(
                                 primary: Colors.black,
                                 shape: CircleBorder(),
                                 padding: EdgeInsets.all(15),
                               ),
                             ),
                           ),

                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
