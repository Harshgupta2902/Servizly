import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../bottom_screens/bottom.dart';
import '../bottom_screens/home_screen.dart';
import '../helper/constant.dart';
import '../helper/image.dart';
import '../page_view.dart';
import 'Welcome_Screen.dart';
import 'login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(ProjectImage.ServizlyBlack,height: 200,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<Timer> loadData() async {
    return Timer(const Duration(seconds: 5), onDoneLoading);
  }

  onDoneLoading() async {

    SessionHelper sessionHelper=await SessionHelper.getInstance(context);
    var userId = sessionHelper.get(SessionHelper.USER_ID);
    if(userId == null){
      Helper.moveToScreenwithPush(context,  PageViewScreen());
    }
    else{
      Helper.moveToScreenwithPush(context, Bottom());
    }

  }
}
