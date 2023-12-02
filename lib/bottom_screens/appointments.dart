
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:serviceapplatest/bookings/history.dart';


import '../generated/l10n.dart';
import '../helper/constant.dart';
import '../bookings/ongoing.dart';

class Appointments extends StatefulWidget {
  const Appointments({Key? key}) : super(key: key);

  @override
  State<Appointments> createState() => _AppointmentsState();
}

class _AppointmentsState extends State<Appointments> {
  TabController? _tabController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight:100,
        titleSpacing: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          S.of(context).Appointments,
          style: GoogleFonts.poppins(textStyle: TextStyle(
            fontSize: 20,
            //fontWeight: FontWeight.bol,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          )),
        ),
      ),
        body:Container(
          height: MediaQuery.of(context).size.height,
          child: DefaultTabController(
            length: 2,
            child: TabBarView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 20),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
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
                        child: TabBar(
                          controller: _tabController,
                          indicator: BoxDecoration(borderRadius: BorderRadius.circular(15),
                          color:Color(0XFF07A9B1)),
                          // give the indicator a decoration (color and border radius)
                           //indicatorColor: Colors.blue,
                          labelColor: AppColor.textbelow, // Tab bar selected Label Color..
                          labelStyle: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),),
                          unselectedLabelColor: Color(0XFF07A9B1),
                          // indicatorWeight: 2,
                          tabs:  [
                            // first tab [you can add an icon using the icon property]
                            Tab(
                              text: S.of(context).Ongoing,
                            ),
                            Tab(
                              text: S.of(context).History,
                            ),
                          ],
                        ),
                      ),
                    ),

                    // tab bar view here
                    Expanded(
                      child: TabBarView(
                        physics: NeverScrollableScrollPhysics(),
                        controller: _tabController,
                        children: [
                          Ongoing(),
                          History(),
                        ],
                      ),
                    ),
                  ],
                ),

              ],
            ),
          ),
        ),
    );
  }
}
