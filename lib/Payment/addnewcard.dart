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


class AddNewCard extends StatefulWidget {
  const AddNewCard({Key? key}) : super(key: key);

  @override
  State<AddNewCard> createState() => _AddNewCardState();
}

class _AddNewCardState extends State<AddNewCard> {

  bool? _isChecked = false;

  bool _isVisible = false;
  bool _hashData = false;

  AddCardModel?_addCardModel;

  final _formKey = GlobalKey<FormState>();

  TextEditingController cardNumber = TextEditingController();
  TextEditingController holderName = TextEditingController();
  TextEditingController expiryDate = TextEditingController();

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
          "Add New Card",
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
                              hintText: '14/26',
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
                    if (_formKey.currentState!.validate() && _isChecked==true) {
                      _formKey.currentState!.save();
                      Helper.checkInternet(addCardApi());
                      // showAlertDialog(context, "5");
                    }
                    else{
                      ToastMessage.msg("please select save card details");
                    }
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

  showAlertDialog(BuildContext context, String whichImage) {

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      scrollable: false,
      insetPadding: EdgeInsets.symmetric(horizontal: 0),
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Container(
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
                    Text("\$ 250",style: GoogleFonts.poppins(
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
                   Helper.moveToScreenwithPushreplaceemt(context, Bottom());

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


  Future<void> addCardApi() async {

    print("<==============addCardApi==================>");

    _hashData = true;
    setProgress(true);

    SessionHelper session = await SessionHelper.getInstance(context);
    String userId = session.get(SessionHelper.USER_ID) ?? "0";


    Map data = {
      'user_id': userId,
      "cardnumber":cardNumber.text.trim(),
      "holderName":holderName.text.trim(),
      "expiryDate":expiryDate.text.trim()
    };

    print("Request =============>" + data.toString());
    try {
      var res = await http.post(Uri.parse(Apis.addCard), body: data);
      print("Response ============>" + res.body);

      if (res.statusCode == 200) {
        try {
          final jsonResponse = jsonDecode(res.body);
          AddCardModel model = AddCardModel.fromJson(jsonResponse);

          if (model.status == "true") {
            _hashData = false;
            // _bottomSheetFilter(context);
            // book.remove(book);


            setState((){
              _addCardModel = model;




              // Helper.moveToScreenwithPush(context, DateTimeScreen(shopId: _getshopdetailmodel!.shopDetails!.shopId.toString(), bookingId: _addServicesmodel!.bookingId!.toString(), time: '', date: '', sum: sum ,));
              // nameController.text =_getprofileModel!.data!.name.toString() ;
              // phoneController.text =_getprofileModel!.data!.phone.toString() ;
              // emailController.text =_getprofileModel!.data!.email.toString() ;

              // showDate =dob ;
              // img =_profileModel!.userData![0].image![0].toString();
              showAlertDialog(context, "5");
            });


            print("Model status true");
            setProgress(false);
            _hashData = false;
            ToastMessage.msg(model.message.toString());
            // _nameController.text=model.data!.name!;
            // _emailController.text=model.data!.email!;
            // _phoneController.text.data!.phone!;

            // //Helper.moveToScreenwithPush(context, EditProfile());
            // SessionHelper sessionHelper =await SessionHelper.getInstance(context);
            // print("userId blah==========>${model.data!.userId.toString()}");
            // sessionHelper.put(SessionHelper.USER_ID,model.data!.userId.toString());
            // sessionHelper.put(SessionHelper.FULLNAME,model.data!.fullName.toString());
            // sessionHelper.put(SessionHelper.EMAIL,model.data!.email.toString());
            // sessionHelper.put(SessionHelper.PASSWORD,passwordController.text.trim());
            // sessionHelper.put(SessionHelper.GENDER,model.data!.gender.toString());
            // sessionHelper.put(SessionHelper.DOB,model.data!.dob.toString());
            // sessionHelper.put(SessionHelper.IMAGE,model.data!.image.toString());
            // sessionHelper.put(SessionHelper.FIREBASEID,model.data!.firebaseId.toString());
            // sessionHelper.put(SessionHelper.IS_ACTIVE,model.data!.isActive.toString());
            // sessionHelper.put(SessionHelper.LOCATION_STATUS,model.data!.locationStatus.toString());
          } else {
            setProgress(false);
            _hashData = false;
            print("false ### ============>");
            ToastMessage.msg(model.message.toString());
          }
        } catch (e) {
          _hashData = false;
          print("false ============>");
          ToastMessage.msg(StaticMessages.API_ERROR);
          print('exception ==> ' + e.toString());
        }
      } else {
        _hashData = false;
        print("status code ==> " + res.statusCode.toString());
        ToastMessage.msg(StaticMessages.API_ERROR);
      }
    } catch (e) {
      _hashData = false;
      ToastMessage.msg(StaticMessages.API_ERROR);
      print('Exception ======> ' + e.toString());
    }
  }



}
