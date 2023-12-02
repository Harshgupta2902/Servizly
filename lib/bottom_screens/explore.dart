import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../generated/l10n.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({Key? key}) : super(key: key);

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
              children: [
                //Search Container gradient
                Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    color: Color(0xff1B1D21),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                    child: Column(
                      children: [
                        Container(
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey, width: 1)
                          ),
                          child: TextField(
                            textAlignVertical: TextAlignVertical.bottom,
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.text,
                            cursorColor: Colors.grey,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.search, color: Colors.grey,),
                              hintText: S.of(context).WhatServicesyouarelookingfor,
                              hintStyle:
                              GoogleFonts.poppins(
                                textStyle:const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey,
                                ),
                              ),
                              filled: true,
                              fillColor: Colors.transparent,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide.none),
                              disabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(30)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(30)),
                              errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(30)),
                            ),
                            style: const TextStyle(
                              color: Colors.black,
                            )
                          ),

                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                              child: Container(
                                height: 30,
                                width: 150,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Colors.grey, width: 1)
                                ),
                                child: TextField(
                                  textAlignVertical: TextAlignVertical.bottom,
                                  textInputAction: TextInputAction.done,
                                  keyboardType: TextInputType.text,
                                  cursorColor: Colors.grey,
                                  decoration: InputDecoration(
                                    hintText: S.of(context).Where,
                                    hintStyle:
                                    GoogleFonts.poppins(
                                      textStyle:const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    filled: true,
                                    fillColor: Colors.transparent,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: BorderSide.none),
                                    disabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(30)),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(30)),
                                    errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(30)),
                                  ),
                                  style: const TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 30,
                              width: 150,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.grey, width: 1)
                              ),
                              child: TextField(
                                textAlignVertical: TextAlignVertical.bottom,
                                textInputAction: TextInputAction.done,
                                keyboardType: TextInputType.text,
                                cursorColor: Colors.grey,
                                // controller: numberController,
                                decoration: InputDecoration(
                                  hintText: S.of(context).When,
                                  hintStyle:
                                  GoogleFonts.poppins(
                                    textStyle:const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  filled: true,
                                  fillColor: Colors.transparent,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: BorderSide.none),
                                  disabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(30)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(30)),
                                  errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(30)),
                                ),
                                style: const TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),




                //Search Container white
                Container(
                  height: MediaQuery.of(context).size.height * 0.695,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                        child: Row(
                          children: [
                            Container(
                              height: 25,
                              width: 65,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.grey, width: 1)
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.filter_list_rounded,size: 15,color: Colors.black87,),
                                  Text("${S.of(context).Filters}")
                                ],
                              )
                            ),
                            const SizedBox(width: 10,),
                            Container(
                              height: 25,
                              width: 180,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.grey, width: 1)
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children:  [
                                   Text(S.of(context).SortbyRecommended),
                                   Icon(Icons.keyboard_arrow_down,size: 15,color: Colors.black87,),

                                ],
                              )

                            ),

                          ],
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children:  [
                          Icon(Icons.search,size: 40, color: Colors.grey,),
                          Text(S.of(context).NoResultFound)
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
