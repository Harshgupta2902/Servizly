import 'dart:convert';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:email_validator/email_validator.dart';
import 'package:http/http.dart'as http;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:serviceapplatest/setting/profile.dart';
import '../bottom_screens/bottom.dart';
import '../generated/l10n.dart';
import '../helper/apis.dart';
import '../helper/constant.dart';
import '../helper/image.dart';
import '../model/edit_model.dart';
import '../model/get_profile_model.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);


  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  bool isValidated = false;
  final _formKey = GlobalKey<FormState>();
  bool _isVisible = false;
  File? _image;
  final _picker = ImagePicker();
  bool _hashData = false;
  String img = '';
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  GetProfileModel? _getprofileModel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Helper.checkInternet(GetProfileApi());

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight:80,
        titleSpacing: 0,
        backgroundColor: Color(0xFFFFFFFF),
        centerTitle: true,
        title:_getprofileModel==null?Container():  Text(
          _getprofileModel!.data!.name == "" ? "User" : _getprofileModel!.data!.name.toString(),
          style: GoogleFonts.poppins(textStyle: TextStyle(
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
        actions: [
          // Padding(
          //   padding: const EdgeInsets.only(right: 20),
          //   child: Image.asset(ProjectImage.editprofile,height: 40,width: 40,),
          // ),
        ],
      ),
      body: Stack(
            children: [
              _getprofileModel == null
                  ? _hashData
                  ? Container()
                  : Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                      child: Text(
                        S.of(context).NoDetailsFound,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 25),
                      ))):
              Container(
        child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Container(

                            decoration: BoxDecoration(boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(1),
                                  blurRadius: 10,
                                  offset: Offset(0, 1))
                            ], shape: BoxShape.circle),
                            height: 80,
                            width: 80,
                            child: Stack(
                              children: [
                                ClipOval(
                                  child: _image == null
                                      ? CachedNetworkImage(
                                    imageUrl:       _getprofileModel!.data!.image!.isEmpty
                            ? ""
                                : _getprofileModel!.data!.image!
                                .toString(),
                                    fit: BoxFit.fill,
                                    width: 80,
                                    height: 80,
                                    placeholder: (context, url) =>
                                        LinearProgressIndicator(
                                          color: Colors.white.withOpacity(0.2),
                                          backgroundColor:
                                          Colors.white.withOpacity(.5),
                                        ),
                                    errorWidget: (context, url, error) =>
                                        Container(
                                          width: 100,
                                          height: 100,
                                          // padding: EdgeInsets.symmetric(vertical: 25.0),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(20),
                                              ),
                                              color: Color(0xFFD9D9D9)),
                                          child: Center(
                                            child: Icon(
                                              Icons.person,
                                              size: 40,
                                              color: AppColor.primaryColor,
                                            ),
                                          ),
                                        ),
                                  )
                                      : Image.file(_image!,
                                      height: 80, width: 80, fit: BoxFit.fill),
                                ),
                                Positioned(
                                    right: 0,
                                    bottom: 0,
                                    child: ClipOval(child: Container(height: 30,width: 30,color: Colors.white,
                                      child: InkWell(
                                          onTap: () {
                                            _showPicker();
                                          },
                                          child: Icon(Icons.camera_alt,color: Colors.black,)),)))
                              ],
                            ),
                          ),
                        ),
                      ),
                      Text(
                        S.of(context).Name,
                        style: GoogleFonts.poppins(textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        )),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        // width: MediaQuery.of(context).size.width/1.1,
                        decoration: BoxDecoration(
                          // border: Border.all(color: AppColor.secondaryColor, width: 2),
                          borderRadius: BorderRadius.circular(30),
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
                        child: TextFormField(
                          controller: nameController,
                            keyboardType: TextInputType.text,
                            cursorColor: Colors.white,
                            // controller: phoneController,
                            decoration: InputDecoration(
                              hintText:                           S.of(context).Name,

                              hintStyle:
                              GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey,
                                ),
                              ),
                              contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                              filled: true,
                              fillColor: Colors.white,
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
                              color: Colors.black,
                            ),
                            textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (nameController.text.isEmpty) {
                             return "Please enter name";
                            }
                            else if(nameController.text.length<2  || phoneController.text.length >50 ){
                              return "Name must be greater than two letters";
                            }

                          },
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        S.of(context).MobileNumber,
                        style: GoogleFonts.poppins(textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        )),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        // width: MediaQuery.of(context).size.width/1.1,
                        decoration: BoxDecoration(
                          // border: Border.all(color: AppColor.secondaryColor, width: 2),
                          borderRadius: BorderRadius.circular(30),
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


                        child: TextFormField(
                          controller: phoneController,
                            keyboardType: TextInputType.text,
                            cursorColor: Colors.white,
                            // controller: phoneController,
                            decoration: InputDecoration(
                              hintText:                           S.of(context).MobileNumber,

                              hintStyle:
                              GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey,
                                ),
                              ),
                              contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                              filled: true,
                              fillColor: Colors.white,
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
                              color: Colors.black,
                            ),
                            textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (phoneController.text.isEmpty) {
                              "Please enter number";
                            }
                            else if(phoneController.text.length<10  || phoneController.text.length >10 ){
                            return  "Number must be of 10 digit";
                            }

                          },
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        S.of(context).EmailAddress,
                        style: GoogleFonts.poppins(textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        )),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        // width: MediaQuery.of(context).size.width/1.1,
                        decoration: BoxDecoration(
                          // border: Border.all(color: AppColor.secondaryColor, width: 2),
                          borderRadius: BorderRadius.circular(30),
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


                        child: TextFormField(
                          controller: emailController,
                            keyboardType: TextInputType.text,
                            cursorColor: Colors.white,
                            // controller: phoneController,
                            decoration: InputDecoration(
                              hintText:  S.of(context).EmailAddress,

                              hintStyle:
                              GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey,
                                ),
                              ),
                              contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                              filled: true,
                              fillColor: Colors.white,
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
                              color: Colors.black,
                            ),
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return ("Please enter your email");
                              } else if (EmailValidator.validate(value.trim())) {
                                return null;
                              } else {
                                return ("please enter valid email");
                              }
                            }



                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 44),
                        child: Center(
                          child: MaterialButton(
                            minWidth: 350,
                            color: Color(0xFF0ABDFC),
                            // padding: EdgeInsets.symmetric(horizontal: 100),
                            height: 50,
                            textColor: Colors.white,
                            child: Text(                          S.of(context).Update,
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                )),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                _buttonSubmit();

                                // if (_formkey.currentState!.validate()) {
                                //   _formkey.currentState!.save();
                                // Helper.moveToScreenwithPush(
                                //     context, const VerificationScreen());
                              }


                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
        ),
      ),
              Positioned(child: Helper.getProgressBarWhite(context, _isVisible))
            ],
          ),
    );
  }



  setProgress(bool show) {
    if (mounted)
      setState(() {
        _isVisible = show;
      });
  }

  _buttonSubmit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      if (_image == null) {
        print("Api called without Image");
        Helper.checkInternet(apieditProfileWithoutImage());
      } else {
        print("Api called with Image");
        Helper.checkInternet(apieditProfileWithImage(_image!.path));
      }
      //  print("==========>>>>>>>>>>>>Image PAth" + _image!.path);
      // Helper.checkInternet(apieditProfileWithoutImage());
    }
  }

  Future<void> apieditProfileWithoutImage() async {

    setProgress(true);


    SessionHelper sessionHelper =await SessionHelper.getInstance(context);
    var user_id  =  sessionHelper.get(SessionHelper.USER_ID) ?? "1";

    print("<=============EditTaskWithoutImageApi================>");

    Map values = {
      'user_id':user_id,
      'name': nameController.text.trim().toString(),
      'email': emailController.text.trim().toString(),
      'phone':phoneController.text.trim().toString(),
    };

    try {
      print(values);
      var res = await http.post(Uri.parse(Apis.editProfile),body: values);
      print(res.body);
      if (res.statusCode == 200) {
        try {
          final jsonResponse = jsonDecode(res.body);

          EditModel model = EditModel.fromJson(jsonResponse);

          print(model.status);

          if (model.status == 'true') {

            print("---------------------amit");



            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                Bottom()), (Route<dynamic> route) => false);

            setProgress(false);
            // ToastMessage.msg(model.message.toString());



          } else {
            setProgress(false);
            // ToastMessage.msg(model.message.toString());
          }
        } catch (e) {
          print('hello + $e');
        }
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> GetProfileApi() async {

    print("<==============GetProfileApi==================>");

    _hashData = true;
    setProgress(true);

    SessionHelper session = await SessionHelper.getInstance(context);
    String userId = session.get(SessionHelper.USER_ID) ?? "0";


    Map data = {
      'user_id': userId,
    };

    print("Request =============>" + data.toString());
    try {
      var res = await http.post(Uri.parse(Apis.getProfile), body: data);
      print("Response ============>" + res.body);

      if (res.statusCode == 200) {
        try {
          final jsonResponse = jsonDecode(res.body);
          GetProfileModel model = GetProfileModel.fromJson(jsonResponse);

          if (model.status == "true") {
            _hashData = false;

            setState(() {
              _getprofileModel = model;
              nameController.text =_getprofileModel!.data!.name.toString() ;
              phoneController.text =_getprofileModel!.data!.phone.toString() ;
              emailController.text =_getprofileModel!.data!.email.toString() ;
              img= _getprofileModel!.data!.image.toString();
              // showDate =dob ;
              // img =_profileModel!.userData![0].image![0].toString();

            });

            print("Model status true");
            setProgress(false);
            _hashData = false;
            // ToastMessage.msg(model.message.toString());
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
             // ToastMessage.msg(model.message.toString());
          }
        } catch (e) {
          _hashData = false;
          print("false ============>");
          // ToastMessage.msg(StaticMessages.API_ERROR);
          print('exception ==> ' + e.toString());
        }
      } else {
        _hashData = false;
        print("status code ==> " + res.statusCode.toString());
        // ToastMessage.msg(StaticMessages.API_ERROR);
      }
    } catch (e) {
      _hashData = false;
      // ToastMessage.msg(StaticMessages.API_ERROR);
      print('Exception ======> ' + e.toString());
    }
  }

  Future<void> apieditProfileWithImage(filename) async {


    print("<=============EditWithImage================>");

    setProgress(true);

    var request = http.MultipartRequest('POST', Uri.parse(Apis.editProfile));
    request.fields['name'] = nameController.text;
    request.fields['email'] =  emailController.text;
    request.fields['phone'] =  phoneController.text;
    request.fields['user_id'] = SessionHelper().get(SessionHelper.USER_ID) ?? "0";
    // request.fields['time'] =widget.time;
    request.files.add(await http.MultipartFile.fromPath('image', filename));
    print("Image");
    print(request.fields);
    print(request.files);
    var res = await request.send();
    if (res.statusCode == 200) {
      setProgress(false);
      try {
        res.stream.transform(utf8.decoder).listen((value) async {

          final jsonResponse = jsonDecode(value);

          EditModel model = EditModel.fromJson(jsonResponse);

          if (model.status == "true") {
            print(model.status);
            print("---------------------urvashi");
            print("---------------------   image ${_image}");

            Helper.moveToScreenwithPushreplaceemt(context, Profile());
            SessionHelper sessionHelper = await SessionHelper.getInstance(context);
            sessionHelper.put(SessionHelper.IMAGE,img.toString());
            sessionHelper.put(SessionHelper.NAME,nameController.text.trim());
            sessionHelper.put(SessionHelper.EMAIL,emailController.text.trim());
            sessionHelper.put(SessionHelper.NUMBER,phoneController.text.trim());

            print("===================image =========== ${img.toString()}");


            // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
            //     BottomNav()), (Route<dynamic> route) => false);


            setProgress(false);

            // ToastMessage.msg("Image uploaded successfully");
            // ToastMessage.msg(model.message.toString());

          } else {
            // ToastMessage.msg(model.message.toString());
          }
        });
      } catch (e) {
        print('exception ==> ' + e.toString());
        // ToastMessage.msg(StaticMessages.API_ERROR);
      }
    } else {
      print("status code ==> " + res.statusCode.toString());
      // ToastMessage.msg(StaticMessages.API_ERROR);
    }
    setProgress(false);
  }

  _imgFromGallery() async {
    PickedFile? image = await _picker.getImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );
    // _image=_cropImage(image);
    setState(() {
      _image = File(image!.path);
      print("pathhhh===============================>>" + _image!.path);
      // _assetImgList.indexOf(_image as File,0);
      // assetImgList.insert(_assetImgList.length, image as File);

      // Helper.checkInternet(uploadImagesApi(_image!.path));

      // _assetImgList.add(_image as File);
    });

    // Helper.checkInternet(uploadImage(_image!.path));
  }

  _imgFromCamera() async {
    PickedFile? image = await _picker.getImage(
      source: ImageSource.camera,
      imageQuality: 50,
    );
    // _cropImage(image);
    setState(() {
      _image = File(image!.path);
      print("pathhhh=======================>>" + _image!.path);
      // assetImgList.insert(_assetImgList.length, image as File);

      // Helper.checkInternet(uploadImagesApi(_image!.path));
      // _assetImgList.add(_image as File);
    });
    // Helper.checkInternet(uploadImage(_image!.path));
  }

  void _showPicker() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}
