import 'dart:convert';
import 'package:http/http.dart'as http;
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:serviceapplatest/bottom_screens/bottom.dart';
import 'package:serviceapplatest/helper/constant.dart';
import '../helper/cardnumberformate.dart';
import '../helper/image.dart';
import '../model/add_card_model.dart';
import '../helper/apis.dart';


class CardDetail extends StatefulWidget {

  String Number="";
  String Date="";
  String Name="";
  String total="";

  CardDetail({required this.Number,required this.Date,required this.Name,required this.total});

  @override
  State<CardDetail> createState() => _CardDetailState();
}

class _CardDetailState extends State<CardDetail> {

  bool? _isChecked = false;

  bool _isVisible = false;
  bool _hashData = false;

  AddCardModel?_addCardModel;

  final _formKey = GlobalKey<FormState>();

  TextEditingController cardNumber = TextEditingController();
  TextEditingController holderName = TextEditingController();
  TextEditingController expiryDate = TextEditingController();



@override
  void initState() {
    // TODO: implement initState
    super.initState();
  cardNumber.text = widget.Number;
    holderName.text = widget.Name;
    expiryDate.text = widget.Date;
}


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar:  AppBar(
        elevation: 0,
        toolbarHeight:100,
        titleSpacing: 0,
        backgroundColor: Color(0xFFf5f5f5),
        centerTitle: true,
        title: Text(
          "Card Detail",
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
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(ProjectImage.cardvector),
                Text("Card Number",style: TextStyle(fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF535353))),
                SizedBox(height: 10,),
                TextFormField(
                  controller: cardNumber,
                  enabled: false,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    CardNumberFormatter(),
                  ],
                  decoration: InputDecoration(
                    suffix:  Image.asset(ProjectImage.cardLogo,height: 20),
                    // border: const OutlineInputBorder(),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintText: 'XXXX XXXX XXXX XXXX',
                  ),
                  maxLength: 19,
                  onChanged: (value) {},
                  validator: (value) {
                    if (cardNumber.text.isEmpty) {
                      return "Please enter card number";
                    }
                    else if(cardNumber.text.length<12){
                      return "Card Number must be of 12 digit";
                    }else {
                      // isValidated  = true;
                    }
                  },
                ),
                Row(
                  children: [
                    Text("Exp Date",
                      style: TextStyle(color: Color(0xFF535353),
                          fontWeight: FontWeight.w500,
                          fontSize: 20),
                    ),
                    SizedBox(width: 142,),
                    Text("CVV No",
                      style: TextStyle(color: Color(0xFF535353),
                          fontWeight: FontWeight.w500,
                          fontSize: 20),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 100,
                      child: TextFormField(
                        enabled: false,
                        controller: expiryDate,
                        keyboardType: TextInputType.name,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          CardNumberFormatter(),
                        ],
                        decoration: InputDecoration(
                          suffix:  Image.asset(ProjectImage.cardLogo,height: 20),
                          // border: const OutlineInputBorder(),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          hintText: "14/26",
                        ),
                        maxLength: 8,
                        onChanged: (value) {},
                        validator: (value) {
                          if (expiryDate.text.isEmpty) {
                            return "enter expiry Date";
                          }
                          // else if(expiryDate.text.length<12){
                          //   return "Card Number must be of 12 digit";
                          // }else {
                          // isValidated  = true;
                          // }
                        },
                      ),
                    ),
                    SizedBox(
                      width: 100,
                      child: TextFormField(
                        keyboardType: TextInputType.name,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          CardNumberFormatter(),
                        ],
                        decoration: InputDecoration(
                          suffix:  Image.asset(ProjectImage.cardLogo,height: 20),
                          // border: const OutlineInputBorder(),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          hintText: 'Cvv No.',
                        ),
                        maxLength: 8,
                        onChanged: (value) {},
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                Text("Name Of Card Holder",
                    style: TextStyle(fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF535353))),
                SizedBox(height: 10,),
                TextFormField(
                  controller: holderName,
                  enabled: false,
                  keyboardType: TextInputType.name,
                  inputFormatters: [],
                  decoration: InputDecoration(
                    // border: const OutlineInputBorder(),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintText: 'Name',
                  ),
                  maxLength: 19,
                  onChanged: (value) {},
                  validator: (value) {
                    if (holderName.text.isEmpty) {
                      return "Please enter holder Name";
                    }
                    // else if(expiryDate.text.length<12){
                    //   return "Card Number must be of 12 digit";
                    // }else {
                    // isValidated  = true;
                    // }
                  },
                ),
                Row(
                  children: [
                    //Image.asset(ProjectImage.checklist,height: 30,),
                    Container(
                      height: 30,
                      width: 30,
                      child: Checkbox(
                        checkColor: Colors.white,
                        activeColor: Colors.green,
                        //fillColor: MaterialStateProperty.resolveWith((states) => , ),
                        value: _isChecked,
                        shape: CircleBorder(),
                        onChanged: (bool? value) {
                          setState(() {
                            _isChecked = value;
                          });
                        },
                      ),
                    ),
                    SizedBox(width: 10,),
                    Text("securley save card details ",
                        style: GoogleFonts.poppins(fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF535353))),
                  ],
                ),
                SizedBox(height: 20,),
                MaterialButton(
                  color: Color(0xFF0ABDFC),
                  minWidth: 310,
                  height: 50,
                  textColor: Colors.white,
                  child: Text("Confirm",
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      )),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  onPressed: () {
                    showAlertDialog(context);
                  },
                ),
                //     Center(
                //       child: SizedBox(
                //         height: 50,
                //         width: 200,
                //         child: ElevatedButton(
                //         style: ElevatedButton.styleFrom(
                //             backgroundColor: Colors.blue, //background color of button
                //             elevation: 3, //elevation of button
                //             shape: RoundedRectangleBorder( //to set border radius to button
                //                 borderRadius: BorderRadius.circular(30)
                //             ),
                //             padding: EdgeInsets.all(5) //content padding inside button
                //         ),
                //         onPressed: (){
                //
                //         },
                //         child: Text("Proceed to pay")
                // ),
                //       ),
                //     )


              ],
            ),
          ),
        ),
      ),
    );
  }

  // showAlertDialog(BuildContext context, String whichImage) {
  //
  //   // set up the AlertDialog
  //   AlertDialog alert = AlertDialog(
  //     scrollable: false,
  //     insetPadding: EdgeInsets.symmetric(horizontal: 0),
  //     backgroundColor: Colors.transparent,
  //     elevation: 0,
  //     content: Container(
  //         padding: EdgeInsets.symmetric(horizontal:  30,vertical: 30),
  //         margin: EdgeInsets.only(top: 50),
  //         height: 400,
  //         width: 380,
  //         decoration: BoxDecoration(
  //             borderRadius: BorderRadius.circular(30),
  //             color: Colors.white),
  //         child:
  //         Column(
  //           crossAxisAlignment: CrossAxisAlignment.center,
  //           mainAxisAlignment: MainAxisAlignment.start,
  //           children: [
  //             SizedBox(height: 10),
  //             Image.asset(ProjectImage.checklist,height: 100,color: Color(0xFF1ba571)),
  //             Text("Payment Successful",style: GoogleFonts.poppins(
  //                 textStyle: TextStyle(
  //                   fontSize: 20,
  //                   fontWeight: FontWeight.w500,
  //                   color: Color(0xFF1ba571),
  //                 )),),
  //             Text("Transaction number : 149538292331",
  //               style: GoogleFonts.poppins(
  //                   color: Color(0xFF8C8C8C),
  //                   fontWeight: FontWeight.w400,
  //                   fontSize: 12
  //               ),
  //             ),
  //             SizedBox(height: 10,),
  //             DottedLine(
  //               direction: Axis.horizontal,
  //               lineLength: double.infinity,
  //               lineThickness: 1.0,
  //               dashLength: 4.0,
  //               dashColor: Color(0xFFdedede),
  //               dashGapLength: 2.0,
  //               dashGapColor: Colors.transparent,
  //               dashGapRadius: 4.0,
  //             ),
  //             SizedBox(height: 10,),
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 Text("Amount Paid",style: GoogleFonts.poppins(
  //                     textStyle: TextStyle(
  //                       fontSize: 15,
  //                       fontWeight: FontWeight.w500,
  //                       color: Color(0xFF8C8C8C),
  //                     )),),
  //                 Text("\$ 250",style: GoogleFonts.poppins(
  //                     textStyle: TextStyle(
  //                       fontSize: 15,
  //                       fontWeight: FontWeight.w500,
  //                       color: Color(0xFF8C8C8C),
  //                     )),),
  //               ],
  //             ),
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 Text("Bank",style: GoogleFonts.poppins(
  //                     textStyle: TextStyle(
  //                       fontSize: 15,
  //                       fontWeight: FontWeight.w500,
  //                       color: Color(0xFF8C8C8C),
  //                     )),),
  //                 Text("SBI",style: GoogleFonts.poppins(
  //                     textStyle: TextStyle(
  //                       fontSize: 15,
  //                       fontWeight: FontWeight.w500,
  //                       color: Color(0xFF8C8C8C),
  //                     )),),
  //               ],
  //             ),
  //             SizedBox(height: 25,),
  //             MaterialButton(
  //               color: Colors.white,
  //               minWidth: 200,
  //               height: 45,
  //               textColor: Colors.white,
  //               elevation: 20,
  //               child: Text("Ok",
  //                 style: GoogleFonts.poppins(
  //                     color:Colors.black,
  //                     fontWeight: FontWeight.w600,
  //                     fontSize: 17
  //                 ),
  //               ),
  //               shape: RoundedRectangleBorder(
  //                   borderRadius: BorderRadius.circular(30)),
  //               onPressed: () {
  //                 Helper.moveToScreenwithPushreplaceemt(context, Bottom());
  //
  //               },
  //             )
  //           ],
  //         )
  //     ),
  //   );
  //
  //   // show the dialog
  //   showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (BuildContext context) {
  //       return alert;
  //     },
  //   );
  // }




  showAlertDialog(BuildContext context) {

    // set up the AlertDialog


    AlertDialog alert = AlertDialog(
      scrollable: false,
      insetPadding: EdgeInsets.symmetric(horizontal: 0),
      backgroundColor: Colors.transparent,
      elevation: 0,
      content:  Container(
          padding: EdgeInsets.symmetric(horizontal:  30,vertical: 30),
          margin: EdgeInsets.only(top: 50),
          height: 400,
          width: 380,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.white),
          child:
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Image.asset(ProjectImage.checklist,height: 100,color: Color(0xFF1ba571)),
              Text("Payment Successful",style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF1ba571),
                  )),),
              Text("Transaction number : 149538292331",
                style: GoogleFonts.poppins(
                    color: Color(0xFF8C8C8C),
                    fontWeight: FontWeight.w400,
                    fontSize: 12
                ),
              ),
              SizedBox(height: 10,),
              DottedLine(
                direction: Axis.horizontal,
                lineLength: double.infinity,
                lineThickness: 1.0,
                dashLength: 4.0,
                dashColor: Color(0xFFdedede),
                dashGapLength: 2.0,
                dashGapColor: Colors.transparent,
                dashGapRadius: 4.0,
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Amount Paid",style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF8C8C8C),
                      )),),
                  Text(widget.total.toString(),
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF8C8C8C),
                        )),),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Bank",style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF8C8C8C),
                      )),),
                  Text("SBI",style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF8C8C8C),
                      )),),
                ],
              ),
              SizedBox(height: 25,),
              MaterialButton(
                color: Colors.white,
                minWidth: 200,
                height: 45,
                textColor: Colors.white,
                elevation: 20,
                child: Text("Ok",
                  style: GoogleFonts.poppins(
                      color:Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 17
                  ),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                onPressed: () {
                  print("tap--------------------->");
                  Helper.moveToScreenwithPushreplaceemt(
                      context, Bottom());

                },
              )
            ],
          )
      ),
    );

    // show the dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  setProgress(bool show) {
    if (mounted)
      setState(() {
        _isVisible = show;
      });
  }





}
