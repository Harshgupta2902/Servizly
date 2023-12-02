import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'helper/image.dart';

class BlogPage extends StatefulWidget {
  String name = "";
  BlogPage({required this.name});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.grey.withOpacity(0.2),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(ProjectImage.bloglogo, width: 150,height: 70,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Icon(Icons.search,size: 30,),
                            Icon(Icons.filter_list_outlined,size: 30,)
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Divider(
                  color: Colors.grey,
                  thickness: 1,
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    child: Text("${widget.name}",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          )),),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 15),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.455,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white,
                    child: Column(
                      children: [
                        Image.asset(ProjectImage.blogImage),
                        SizedBox(height: 20,),
                        Text("Lorem Ipsum is simply\ndummy text ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20
                        ),),
                        SizedBox(height: 20,),

                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release .",
                            style: TextStyle(
                                fontSize: 15
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 15),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.45,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white,
                    child: Column(
                      children: [
                        Image.asset(ProjectImage.blogImage),
                        SizedBox(height: 20,),
                        Text("Lorem Ipsum is simply\ndummy text ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20
                          ),),
                        SizedBox(height: 20,),

                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release .",
                              style: TextStyle(
                                  fontSize: 15
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 15),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.45,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white,
                    child: Column(
                      children: [
                        Image.asset(ProjectImage.blogImage),
                        SizedBox(height: 20,),
                        Text("Lorem Ipsum is simply\ndummy text ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20
                          ),),
                        SizedBox(height: 20,),

                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release .",
                              style: TextStyle(
                                  fontSize: 15
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 15),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.45,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white,
                    child: Column(
                      children: [
                        Image.asset(ProjectImage.blogImage),
                        SizedBox(height: 20,),
                        Text("Lorem Ipsum is simply\ndummy text ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20
                          ),),
                        SizedBox(height: 20,),

                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release .",
                              style: TextStyle(
                                  fontSize: 15
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 15),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.45,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white,
                    child: Column(
                      children: [
                        Image.asset(ProjectImage.blogImage),
                        SizedBox(height: 20,),
                        Text("Lorem Ipsum is simply\ndummy text ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20
                          ),),
                        SizedBox(height: 20,),

                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release .",
                              style: TextStyle(
                                  fontSize: 15
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20,),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
