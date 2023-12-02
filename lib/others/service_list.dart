import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:serviceapplatest/helper/constant.dart';
import '../helper/apis.dart';
import '../helper/image.dart';
import 'package:http/http.dart'as http;

import '../model/get_service_list_model.dart';
import 'all_services_screen.dart';


class ServiceList extends StatefulWidget {
  String services="";
  List listOfSelectedService;
   ServiceList({required this.services, required  this.listOfSelectedService});

  @override
  State<ServiceList> createState() => _ServiceListState();
}

class _ServiceListState extends State<ServiceList> {


  final List<TopSalonModel> _topsalonlist = [
    TopSalonModel(image: ProjectImage.HairSalon,name: "Hair Salon",),
    TopSalonModel(image: ProjectImage.NailSalon,name: "Nail Salon",),
    TopSalonModel(image: ProjectImage.Skin,name: "Skin care",),
    TopSalonModel(image: ProjectImage.Massage,name: "Massage",),
    TopSalonModel(image: ProjectImage.DaySpa,name: "Day Spa",),
    TopSalonModel(image: ProjectImage.Eyebrows,name: "Eyebrows &Lashes",),
    TopSalonModel(image: ProjectImage.Makeup,name: "Makeup Artist",),
    TopSalonModel(image: ProjectImage.Personal,name: "Personal Trainer",),
    TopSalonModel(image: ProjectImage.Chiropractic,name: "Chiropractic",),
    TopSalonModel(image: ProjectImage.Wedding,name: "Wedding Makeup Artist",),
    TopSalonModel(image: ProjectImage.Aesthetic,name: "Aesthetic Medicine",),
    TopSalonModel(image: ProjectImage.HairRemoval,name: "Hair Removal",),
    TopSalonModel(image: ProjectImage.Braids,name: "Braids & Locs",),
    TopSalonModel(image: ProjectImage.Tattoo,name: "Tattoo Shops",),
    TopSalonModel(image: ProjectImage.Home,name: "Home improvement",),
    TopSalonModel(image: ProjectImage.Piercing,name: "Piercing",),
    TopSalonModel(image: ProjectImage.Physical,name: "Physical Therapy",),
    TopSalonModel(image: ProjectImage.Pet,name: "Pet Services",),
    TopSalonModel(image: ProjectImage.Teeth,name: "Teeth Whitening",),
    TopSalonModel(image: ProjectImage.Dietician,name: "Dietician",),
  ];

  bool _isVisible = false;
  bool _hashData = false;
  File? _image;
  GetServicelistModel?_getServicelistModel;
  void initState() {
    // TODO: implement initState
    super.initState();
    Helper.checkInternet(GetserviceApi());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 70,
        titleSpacing: 0,
        backgroundColor: Color(0xFFFFFFFF),
        centerTitle: true,
        title: Text(
          "Services",
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
          _getServicelistModel == null
              ?_hashData
              ? Container()
              :Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Center(
                  child: Text("No data found",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,color: Colors.black,
                        fontSize: 25
                    ),
                  )
              )) :
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
            child: SingleChildScrollView(
              child: Column(
                children:[
                GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount:_getServicelistModel!.servicesList!.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                      childAspectRatio: 1.9/2
                  ),
                  itemBuilder: (BuildContext context, int index){
                    return
                      InkWell(
                        onTap: () {
                          Helper.moveToScreenwithPush(
                              context,
                              AllService(
                                service: _getServicelistModel!
                                    .servicesList![index]
                                    .services
                                    .toString(),
                              ));
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 70,
                              width: 70,
                              // decoration: BoxDecoration(
                              //   color: Colors.white,
                              //     boxShadow: [
                              //   BoxShadow(
                              //       color: Colors.grey.withOpacity(1),
                              //       blurRadius: 3,
                              //       offset: Offset(0, 3))
                              // ], shape: BoxShape.circle),
                              child: ClipOval(
                                child: _image == null
                                    ? CachedNetworkImage(
                                  imageUrl:
                                  _getServicelistModel!.servicesList![index].images!.isEmpty
                                      ? ""
                                      :  _getServicelistModel!.servicesList![index].images!
                                      .toString(),
                                  fit: BoxFit.fill,
                                  width: 70,
                                  height: 70,
                                  placeholder: (context, url) =>
                                      LinearProgressIndicator(
                                        color: Colors.white.withOpacity(0.2),
                                        backgroundColor:
                                        Colors.white.withOpacity(.5),
                                      ),
                                  errorWidget: (context, url, error) =>
                                      ClipOval(child:Icon(Icons.error,
                                       )),
                                )
                                    : Image.file(_image!,
                                    height: 80, width: 80, fit: BoxFit.fill),
                              ),
                            ),
                            SizedBox(height: 5,),
                            Text(
                              _getServicelistModel!.servicesList![index].services.toString(),
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: AppColor.primaryColor,
                                  )),textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      );
                  },
                ),
              ]),
            ),


          ),
          Helper.getProgressBarWhite(context, _isVisible)
        ],
      )
    );
  }

  setProgress(bool show) {
    if (mounted)
      setState(() {
        _isVisible = show;
      });
  }

  Future<void> GetserviceApi() async {

    print("<==============GetserviceApi==================>");

    _hashData = true;
    setProgress(true);

    SessionHelper session = await SessionHelper.getInstance(context);
    String userId = session.get(SessionHelper.USER_ID) ?? "0";


    Map data = {
      'user_id': userId,
    };

    print("Request =============>" + data.toString());
    try {
      var res = await http.post(Uri.parse(Apis.getServiceList), body: data);
      print("Response ============>" + res.body);

      if (res.statusCode == 200) {
        try {
          final jsonResponse = jsonDecode(res.body);
          GetServicelistModel model = GetServicelistModel.fromJson(jsonResponse);

          if (model.status == "true") {
            _hashData = false;

            setState(() {
              _getServicelistModel = model;
              // nameController.text =_getprofileModel!.data!.name.toString() ;
              // phoneController.text =_getprofileModel!.data!.phone.toString() ;
              // emailController.text =_getprofileModel!.data!.email.toString() ;

              // showDate =dob ;
              // img =_profileModel!.userData![0].image![0].toString();

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

class TopSalonModel {
  String image = "";
  String name = "";

  TopSalonModel({required this.image,required this.name,});
}