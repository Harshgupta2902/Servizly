import 'package:flutter/material.dart';
import 'package:serviceapplatest/bottom_screens/appointments.dart';
import 'package:serviceapplatest/bottom_screens/explore.dart';
import 'package:serviceapplatest/bottom_screens/home_screen.dart';
import 'package:serviceapplatest/bottom_screens/setting.dart';

import '../generated/l10n.dart';

class Bottom extends StatefulWidget {
  const Bottom({Key? key}) : super(key: key);

  @override
  State<Bottom> createState() => _BottomState();
}

class _BottomState extends State<Bottom> {
  int currentIndex = 0;
  final screens = [
    HomeScreen(shop_id: "", totalAmount: ""),
    ExplorePage(),
    Appointments(),
    Setting(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: SizedBox(
        height: 60,
        child: Container(
          decoration: BoxDecoration(
              border: Border(top: BorderSide(color: Colors.grey, width: 2.0))
          ),
          child: BottomNavigationBar(
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.grey,
            backgroundColor: Colors.black,
            type: BottomNavigationBarType.fixed,
            currentIndex: currentIndex,
            onTap: (index) => setState(() {
              currentIndex = index;
            }),
            items: <BottomNavigationBarItem> [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                label: S.of(context).Home,
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.search,
                ),
                label: S.of(context).Explore,
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.calendar_month,
                ),
                label: S.of(context).Appointments,
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.settings_suggest_rounded,
                ),
                label: S.of(context).Settings,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
