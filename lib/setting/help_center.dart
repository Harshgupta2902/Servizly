import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../generated/l10n.dart';
import '../helper/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class HelpCenter extends StatefulWidget {
  const HelpCenter({Key? key}) : super(key: key);

  @override
  State<HelpCenter> createState() => _HelpCenterState();
}

class _HelpCenterState extends State<HelpCenter> {
  TextEditingController _sendercontroller = TextEditingController();
  String msg = "";
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 100,
        titleSpacing: 0,
        backgroundColor: Color(0xFFFFFFFF),
        centerTitle: true,
        title: Text(
          S.of(context).HelpCenter,
          style: GoogleFonts.poppins(
              textStyle: TextStyle(
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
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  StreamBuilder<QuerySnapshot>  (
                      stream: FirebaseFirestore.instance
                          .collection('chat')
                          .doc(SessionHelper().get(SessionHelper.USER_ID))
                      // .collection('project')
                      // .doc("1")
                          .collection('opponent')
                          .doc("1")
                          .collection('chatting')
                          .orderBy("time", descending: true)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData && snapshot.data != null) {
                          print("here");
                          print("snapshot==>${snapshot.data!.docs.toString()}");
                          print("snapshotlength==>${snapshot.data!.docs.length.toString()}");
                          print("userid==> ${SessionHelper().get(SessionHelper.USER_ID)}" );

                          return Container(
                            height: MediaQuery.of(context).size.height*0.78,
                            width: MediaQuery.of(context).size.width,
                            // color: Colors.green,
                            child: ListView.builder(
                                reverse: true,
                                itemCount: snapshot.data!.docs.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  // print("here==>");
                                  print("snapshot===>${snapshot.data!.docs[index].data().toString()}");
                                  Map<String, dynamic> messageData = snapshot.data!.docs[index].data() as Map<String, dynamic>;
                                  print("see here ${messageData.toString()}");
                                  var msg = messageData['msg'];
                                  var url = messageData['url'].toString();
                                  // var time = messageData['time'];

                                  //for timezone
                                  Timestamp time = messageData['time'];
                                  print("timestamp===>${time.toString()}");
                                  String formattedTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(time.toDate().toLocal());
                                  print("timestamp===>${formattedTime}");


                                  var sender = messageData['sender'];
                                  String base = "";
                                  if (url != "") {
                                    base = url.split(".").last.split("?").first;
                                  }
                                  return Container(
                                      padding:EdgeInsets.symmetric(horizontal: 10),
                                      //  color: Colors.red,
                                      child: sender != SessionHelper().get(SessionHelper.USER_ID)
                                          ?Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,

                                        children: [
                                          //bubble 1
                                          ChatBubble(
                                            padding: EdgeInsets.symmetric(vertical: 17, horizontal: 17),
                                            alignment: Alignment.topLeft,
                                            backGroundColor: Colors.blue,
                                            clipper: ChatBubbleClipper9(
                                                type: BubbleType.receiverBubble),
                                            child: Text(msg,
                                                style: GoogleFonts.openSans(
                                                  textStyle: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w500,
                                                      color: Colors.black),
                                                )
                                            ),
                                          ),
                                          // Container(
                                          //   child: Text(msg,
                                          //       style: GoogleFonts.openSans(
                                          //         textStyle: TextStyle(
                                          //             fontSize: 14,
                                          //             fontWeight: FontWeight.w500,
                                          //             color: Colors.black),
                                          //       )
                                          //   ),
                                          // ),
                                          SizedBox(height: 20,),
                                        ],
                                      )
                                          :Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          ChatBubble(
                                            padding: EdgeInsets.symmetric(vertical: 17, horizontal: 17),
                                            alignment: Alignment.topRight,
                                            backGroundColor: Colors.grey,
                                            clipper: ChatBubbleClipper9(type: BubbleType.sendBubble),
                                            child: Text(msg,
                                                style: GoogleFonts.openSans(
                                                  textStyle: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w500,
                                                      color: Colors.white),
                                                )
                                            ),
                                          ),
                                          SizedBox(height: 20,),
                                        ],
                                      )
                                  );
                                }),
                          );
                          //return Text("hello");
                        }
                        else {
                          return Center(
                            child: Text(S.of(context).writesomemessages),
                          );

                        }
                      }),

                  TextFormField(
              controller: _sendercontroller,
              keyboardType: TextInputType.text,
              cursorColor: Colors.grey,
              maxLength: 200,
              decoration: InputDecoration(
                hintText: S.of(context).WriteSomething,
                hintStyle:
                GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF7A7A7A),
                  ),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 40,vertical: 10),
                filled: true,
                fillColor: Color(0xFFF0F0F0),
                suffixIcon: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
                  child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 2,
                            offset: Offset(0, 1), // changes position of shadow
                          ),
                        ],
                        // color: AppColor.textfeildclr,
                      ),
                      child: InkWell(
                          onTap: () {
                            sendmessage();
                          },
                          child: Icon(Icons.send,color: Colors.black,))),
                ),
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
              style: TextStyle(
                color: Color(0xFF7A7A7A),
              ),
              textInputAction: TextInputAction.next,
            )

      ],
              ),
            ),
          ),
          // Positioned(
          //   bottom: 10,
          //   left: 20,
          //   right: 20,
          //   child:   TextFormField(
          //     controller: _sendercontroller,
          //       keyboardType: TextInputType.text,
          //       cursorColor: Colors.grey,
          //       decoration: InputDecoration(
          //         hintText: "Write Something...",
          //         hintStyle:
          //         GoogleFonts.poppins(
          //           textStyle: TextStyle(
          //             fontSize: 15,
          //             fontWeight: FontWeight.w500,
          //             color: Color(0xFF7A7A7A),
          //           ),
          //         ),
          //         contentPadding: EdgeInsets.symmetric(horizontal: 40,vertical: 10),
          //         filled: true,
          //         fillColor: Color(0xFFF0F0F0),
          //         suffixIcon: Padding(
          //           padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
          //           child: Container(
          //               height: 40,
          //               width: 40,
          //               decoration: BoxDecoration(
          //                 color: Colors.white,
          //                 shape: BoxShape.circle,
          //                 boxShadow: [
          //                   BoxShadow(
          //                     color: Colors.grey.withOpacity(0.2),
          //                     spreadRadius: 2,
          //                     blurRadius: 2,
          //                     offset: Offset(0, 1), // changes position of shadow
          //                   ),
          //                 ],
          //                 // color: AppColor.textfeildclr,
          //               ),
          //               child: InkWell(
          //                 onTap: () {
          //                   sendmessage();
          //                 },
          //                 child: Icon(Icons.send,color: Colors.black,))),
          //         ),
          //         border: OutlineInputBorder(
          //           borderRadius: BorderRadius.circular(30),
          //         ),
          //         focusedBorder: OutlineInputBorder(
          //             borderRadius: BorderRadius.circular(30),
          //             borderSide: BorderSide.none),
          //         disabledBorder: OutlineInputBorder(
          //             borderSide: BorderSide.none,
          //             borderRadius: BorderRadius.circular(30)),
          //         enabledBorder: OutlineInputBorder(
          //             borderSide: BorderSide.none,
          //             borderRadius: BorderRadius.circular(30)),
          //         errorBorder: OutlineInputBorder(
          //             borderSide: BorderSide.none,
          //             borderRadius: BorderRadius.circular(30)),
          //       ),
          //       style: TextStyle(
          //         color: Color(0xFF7A7A7A),
          //       ),
          //       textInputAction: TextInputAction.next,
          //       ),)
        ],
      ),
    );
  }
  void sendmessage() async {

    if(_sendercontroller.text==""){
      ToastMessage.msg("Please enter a message");
    }else {
      DateTime now = DateTime.now().toUtc();


      setState(() {
        msg = _sendercontroller.text.toString();
        print("msg==============="+msg);
      });
      _sendercontroller.clear();

      final docUser = FirebaseFirestore.instance
          .collection('chat')
          .doc(SessionHelper().get(SessionHelper.USER_ID))
          .collection('opponent')
          .doc("1")
          .collection('chatting')
          .doc();
      final json = {
        'sender': SessionHelper().get(SessionHelper.USER_ID),
        'msg': msg,
        'time': now,
      };
      await docUser.set(json);

      final docUser1 = FirebaseFirestore.instance
          .collection('chat')
          .doc("1")
          .collection('opponent')
          .doc(SessionHelper().get(SessionHelper.USER_ID))
          .collection('chatting')
          .doc();
      await docUser1.set(json);

      final doc = FirebaseFirestore.instance
          .collection('chat')
          .doc(SessionHelper().get(SessionHelper.USER_ID))
      // .collection('project')
      // .doc(widget.projectId)
          .collection('opponent')
          .doc("1");
      await doc.set({

        "image": "noimage",
        "opponent_name": "Chandra",
        "opponent_id": "1",
        "last_message": msg,
        "last_message_timestamp": now,
      });

      //new code for updating partner
      final doc1 = FirebaseFirestore.instance
          .collection('chat')
          .doc("1")
          .collection('opponent')
          .doc(SessionHelper().get(SessionHelper.USER_ID));
      await doc1.set({

        "image":SessionHelper().get(SessionHelper.IMAGE),
        "opponent_name": SessionHelper().get(SessionHelper.NAME),
        "last_message": msg,
        "opponent_id": SessionHelper().get(SessionHelper.USER_ID),
        "last_message_timestamp": now,
      });
    }
  }
}
