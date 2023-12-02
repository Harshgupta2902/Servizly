import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:serviceapplatest/model/check_shop_in_cart_model.dart';
import 'package:serviceapplatest/model/delete_cart_model.dart';
import 'package:serviceapplatest/top%20salons/portfolio.dart';
// import 'package:serviceapplatest/top%20salons/review.dart';
// import 'package:serviceapplatest/top%20salons/services.dart';
import 'package:http/http.dart'as http;
import '../Payment/review_order.dart';
// import '../Registration screen/date_time.dart';
import '../bottom_screens/bottom.dart';
import '../bottom_screens/home_screen.dart';
import '../generated/l10n.dart';
import '../helper/apis.dart';
import '../helper/constant.dart';
import '../model/edit_booked_service_model.dart';
import '../model/get_Book_Totalmodal.dart';
import '../helper/image.dart';
import '../model/add_service_model.dart';
// import '../model/get_shop_data_modal.dart';
import '../model/get_cart_details_model.dart';
import '../model/get_shop_detail_model.dart';
// import '../model/home_model.dart';
import '../model/review_modal.dart';
import 'Details.dart';

class TopSalon extends StatefulWidget {
  String shop_id="";
  String totalAmount = "";
  TopSalon({required this.shop_id, required this.totalAmount});

  @override
  State<TopSalon> createState() => _TopSalonState();
}

class _TopSalonState extends State<TopSalon>  with SingleTickerProviderStateMixin{



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = new TabController(length: 4, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _currentIndex = _tabController.index;
      });
    });
    Helper.checkInternet(getShopDetailsApi());
    Helper.checkInternet(getCartDetailsApi());
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }


  late TabController _tabController;
  int _currentIndex = 0;

  bool checkboxValueCity = false;
  List allCities = ['Something about the person',
    'Poor Service',
    'Taking unnecessary time',
    'Lack of time management',
    'Rude to '];
  List selectedCities = [];
  bool value = false;

  bool check = false;
  bool checktwo = false;
  bool checkthree = false;

  bool _showDocument = true;
  bool _isVisible = false;
  bool _hashData = false;
  Getshopdetailmodel?_getshopdetailmodel;
  GetCartDetailsModel? _getCartDetailsModel;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () =>  loadData(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          toolbarHeight:100,
          titleSpacing: 0,
          backgroundColor: Color(0xFFFFFFFF),
          centerTitle: true,
          title: _getshopdetailmodel == null
            ? Text(" ")
          :Text(
            _getshopdetailmodel!.shopDetails!.saloonName.toString()==""?"Salon": _getshopdetailmodel!.shopDetails!.saloonName.toString(),
            style: GoogleFonts.poppins(textStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: AppColor.primaryColor,
            )),
          ),
          leading: InkWell(
            onTap: () {
              Helper.moveToScreenwithPush(context, Bottom());

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
          actions: <Widget>[
            IconButton(
              icon: Image.asset(ProjectImage.report,height:50),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return _MyDialog(
                        cities: allCities,
                        selectedCities: selectedCities,
                        onSelectedCitiesListChanged: (cities) {
                          selectedCities = cities;
                          print(selectedCities);
                        });
                  },
                );
                setState(() {
                  value = false;
                });
                // showAlertDialog(context, "5");

              },
            )
          ],
        ),
        body: _getshopdetailmodel==null
          ?Container()
            :Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Image.asset(ProjectImage.girlservices,
                //   width: MediaQuery.of(context).size.width,),
                if(_currentIndex == 0)
                Container(
                  height: 220,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(1),
                          blurRadius: 3,
                          offset: Offset(0, 3))
                    ],
                    color: Colors.white,
                  ),
                  child: CachedNetworkImage(
                    imageUrl:
                    _getshopdetailmodel!.shopDetails!.image.toString().isEmpty ? "":_getshopdetailmodel!.shopDetails!.image.toString(),
                    fit: BoxFit.fill,
                    height: 160,
                    width: MediaQuery.of(context).size.width,
                    placeholder: (context, url) =>
                        LinearProgressIndicator(
                          color: Colors.white.withOpacity(0.2),
                          backgroundColor:
                          Colors.white.withOpacity(.5),
                        ),
                    errorWidget: (context, url, error) =>
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            height: 160,
                            width: 300,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.withOpacity(1),
                                      blurRadius: 3,
                                      offset: Offset(0, 3))
                                ],
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)
                            ),
                            child:Icon(Icons.error_outline_sharp),
                          ),
                        ),
                  ),
                ),
                DefaultTabController(
                  length: 4,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding:  EdgeInsets.only(top: 20),
                        child: Material(
                          color: Colors.transparent,
                          child: TabBar(
                            indicatorColor:  Colors.transparent,
                            isScrollable: false,
                            labelStyle:
                            GoogleFonts.poppins(textStyle: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            )),
                            unselectedLabelColor:  Colors.black,
                            labelColor:  AppColor.primaryColor,
                            tabs: [
                              Tab(
                                child: InkWell(
                                  onTap: (){
                                    setState(() {
                                      _tabController.index =0;
                                    });
                                  },
                                  child: Center(
                                    child: _tabController.index == 0 ?Column(
                                      children: [
                                        Text(
                                            S.of(context).Services,
                                            style:
                                            TextStyle(
                                                color: Color(0xFF1D1D1D),
                                                fontWeight: FontWeight.w500,
                                                fontSize: 13
                                            )
                                        ),
                                        Divider(
                                          color: AppColor.primaryColor,
                                          thickness: 3,
                                        )
                                      ],
                                    ):Column(
                                      children: [
                                        Text(
                                            S.of(context).Services,
                                            style: _tabController.index == 0 ?
                                            TextStyle(
                                                color: Color(0xFF1D1D1D),
                                                fontWeight: FontWeight.w500,
                                                fontSize: 13
                                            )
                                                :
                                            TextStyle(
                                                color: Color(0xFF1D1D1D),
                                                fontWeight: FontWeight.w500,
                                                fontSize: 13
                                            )
                                        ),
                                        Divider(
                                          color: Colors.transparent,
                                          thickness: 2,
                                        )
                                      ],
                                    ),
                                  ),
                                ),),
                              Tab(
                                child: InkWell(
                                  onTap: (){
                                    setState(() {
                                      _tabController.index =1;
                                    });
                                  },
                                  child: Center(
                                    child: _tabController.index == 1 ?Column(
                                      children: [
                                        Text(
                                            S.of(context).Reviews,
                                          style:TextStyle(
                                            color: Color(0xFF1D1D1D),
                                            fontWeight: FontWeight.w500,
                                            fontSize: 13
                                          )
                                        ),
                                        Divider(
                                          color: AppColor.primaryColor,
                                          thickness: 3,
                                        )
                                      ],
                                    ):Column(
                                      children: [
                                        Text(
                                            S.of(context).Reviews,
                                            style: _tabController.index == 1 ?
                                            TextStyle(
                                                color: Color(0xFF1D1D1D),
                                                fontWeight: FontWeight.w500,
                                                fontSize: 13
                                            )
                                                :
                                            TextStyle(
                                                color: Color(0xFF1D1D1D),
                                                fontWeight: FontWeight.w500,
                                                fontSize: 13
                                            )
                                        ),
                                        Divider(
                                          color: Colors.transparent,
                                          thickness: 2,
                                        )
                                      ],
                                    ),
                                  ),
                                ),),
                              Tab(
                                child: InkWell(
                                  onTap: (){
                                    setState(() {
                                      _tabController.index =2;
                                    });
                                  },
                                  child: Center(
                                    child: _tabController.index == 2 ?Column(
                                      children: [
                                        Text(
                                            S.of(context).Portfolio,
                                            style:
                                            TextStyle(
                                                color: Color(0xFF1D1D1D),
                                                fontWeight: FontWeight.w500,
                                                fontSize: 13
                                            )
                                        ),
                                        Divider(
                                          color: AppColor.primaryColor,
                                          thickness: 3,
                                        )
                                      ],
                                    ):Column(
                                      children: [
                                        Text(
                                            S.of(context).Portfolio,
                                            style: _tabController.index == 2 ?
                                            TextStyle(
                                                color: Color(0xFF1D1D1D),
                                                fontWeight: FontWeight.w500,
                                                fontSize: 13
                                            )
                                                :
                                            TextStyle(
                                                color: Color(0xFF1D1D1D),
                                                fontWeight: FontWeight.w500,
                                                fontSize: 13
                                            )
                                        ),
                                        Divider(
                                          color: Colors.transparent,
                                          thickness: 2,
                                        )
                                      ],
                                    ),
                                  ),
                                ),),
                              Tab(
                                child: InkWell(
                                  onTap: (){
                                    setState(() {
                                      _tabController.index =3;
                                    });
                                  },
                                  child: Center(
                                    child: _tabController.index == 3 ?Column(
                                      children: [
                                        Text(
                                            S.of(context).details,
                                            style:
                                            TextStyle(
                                                color: Color(0xFF1D1D1D),
                                                fontWeight: FontWeight.w500,
                                                fontSize: 13
                                            )
                                        ),
                                        Divider(
                                          color:AppColor.primaryColor,
                                          thickness: 3,
                                        )
                                      ],
                                    ):Column(
                                      children: [
                                        Text(
                                            S.of(context).details,
                                            style: _tabController.index == 3 ?
                                            TextStyle(
                                                color: Color(0xFF1D1D1D),
                                                fontWeight: FontWeight.w500,
                                                fontSize: 13
                                            )
                                                :
                                            TextStyle(
                                                color: Color(0xFF1D1D1D),
                                                fontWeight: FontWeight.w500,
                                                fontSize: 13
                                            )
                                        ),
                                        Divider(
                                          color: Colors.transparent,
                                          thickness: 2,
                                        )
                                      ],
                                    ),
                                  ),
                                ),),
                            ],
                            controller: _tabController,
                            indicatorSize: TabBarIndicatorSize.tab,
                            indicatorWeight: 1,
                          ),
                        ),
                      ),
                      Container(
                       height:(_currentIndex == 0)? MediaQuery.of(context).size.height/1.8 : MediaQuery.of(context).size.height,
                        child: TabBarView(
                          controller: _tabController,
                          physics: NeverScrollableScrollPhysics(),
                          children: [
                            Servicesscreen(shop_id: widget.shop_id, ),
                            Review(),
                            PortfolioScreen(shop_id: widget.shop_id,),
                            Details(shop_id: widget.shop_id,),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> getShopDetailsApi() async {

    print("<==============getShopDetailsApi==================>");

    _hashData = true;
    setProgress(true);

    SessionHelper session = await SessionHelper.getInstance(context);
    String userId = session.get(SessionHelper.USER_ID) ?? "0";


    Map data = {
      'user_id': userId,
      'shop_id':widget.shop_id
    };

    print("Request =============>" + data.toString());
    try {
      var res = await http.post(Uri.parse(Apis.getShopDetails), body: data);
      print("Response ============>" + res.body);

      if (res.statusCode == 200) {
        try {
          final jsonResponse = jsonDecode(res.body);
          Getshopdetailmodel model = Getshopdetailmodel.fromJson(jsonResponse);

          if (model.status == "true") {
            _hashData = false;

            setState(() {
              _getshopdetailmodel = model;
            });

            print("Model status true");
            setProgress(false);
            _hashData = false;
            ToastMessage.msg(model.message.toString());
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
  Future<void> getCartDetailsApi() async {
    print("<==============getCartDetails==================>");

    _hashData = true;
    setProgress(true);

    SessionHelper session = await SessionHelper.getInstance(context);
    String userId = session.get(SessionHelper.USER_ID) ?? "0";

    Map data = {'user_id': userId};
    print("Request =============>" + data.toString());
    try {
      var res = await http.post(Uri.parse(Apis.getCartDetails), body: data);
      print("Response get ===getCartDetails=======>" + res.body);

      if (res.statusCode == 200) {
        try {
          final jsonResponse = jsonDecode(res.body);
          GetCartDetailsModel model = GetCartDetailsModel.fromJson(jsonResponse);

          print("amit=========1");

          if (model.status == "true") {
            setState(() {
              _getCartDetailsModel = model;

              if(_getCartDetailsModel!.cartData.toString() == null){
                _showDocument = false;
              }
              else{
                _showDocument = true;
              }
            });

            setProgress(false);
            _hashData = false;
            ToastMessage.msg(model.message.toString());
          }
          else {
            setProgress(false);
            _hashData = false;
            print("false ### =====GetCartDetailsModel=1======>");
            ToastMessage.msg(model.message.toString());
          }
        } catch (e) {
          _hashData = false;
          print("false =======GetCartDetailsModel=2====>");
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
      print('Exception ==getreviewappointment====> ' + e.toString());
    }
  }
  setProgress(bool show) {
    if (mounted)
      setState(() {
        _isVisible = show;
      });
  }
  loadData() async {
    // leave();
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
        Bottom()), (Route<dynamic> route) => false);  }

}



class Servicesscreen extends StatefulWidget {
  String shop_id="";
  Servicesscreen({required this.shop_id,});

  @override
  State<Servicesscreen> createState() => _ServicesscreenState();
}

class _ServicesscreenState extends State<Servicesscreen> {
  var date="";
  var time="";
  String _isselect = "0";
  bool check = false;
  bool checktwo = false;
  bool checkthree = false;
  bool _showDocument = false;
  bool _isVisible = false;
  bool _hashData = false;
  String amount="";
  int count=0;
  var addserviceparameter = "";
  int sum=0;
  int totalAmount = 0;
  int newSum = 0;
  List isItemInList = [];
  List book=[];
  List priceee=[];
  List amt=[];

  AddServiceModel?_addServicesmodel;
  Getshopdetailmodel?_getshopdetailmodel;
  GetBookTotal? _getBookTotalmodal;
  EditBookedServiceModel?_editBookedServiceModel;
  GetCartDetailsModel? _getCartDetailsModel;
  CheckShopInCartModel? _checkShopInCartModel;
  DeleteCartModel? _deleteCartModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Helper.checkInternet(getShopDetailsApi());
    Helper.checkInternet(getCartDetailsApi());
    _showDocument = false;
    Servicesscreen(shop_id: widget.shop_id,);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: _getshopdetailmodel==null
                ?Container()
                :Stack(
              children: [
                ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    itemCount: _getshopdetailmodel!.shopServiceList!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return   Container(
                        margin:EdgeInsets.symmetric(vertical: 10) ,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                height: 60,
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(_getshopdetailmodel!.shopServiceList![index].serviceName.toString(),
                                            style: GoogleFonts.poppins(
                                              textStyle: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                  color:AppColor.primaryColor ),
                                            )),
                                        Text("₹ ${_getshopdetailmodel!.shopServiceList![index].price.toString()}",
                                            style: GoogleFonts.poppins(
                                              textStyle: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                  color:AppColor.primaryColor),
                                            )),
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              addserviceparameter = "0";
                                              Helper.checkInternet(CheckShopInCartApi(_getshopdetailmodel!.shopServiceList![index].id.toString()));
                                            });
                                          },
                                          child: Container(
                                            width: 60,
                                            height: 35,
                                            decoration: BoxDecoration(
                                                color: Color(0xFF07A9B1) ,
                                                borderRadius: BorderRadius.circular(10)
                                            ),
                                            // padding: EdgeInsets.symmetric(horizontal: 20),
                                            child:  Center(
                                              child: Text("Book",
                                                  style: GoogleFonts.poppins(
                                                      textStyle: TextStyle(
                                                          fontSize: 16, fontWeight: FontWeight.w700,
                                                          color: Colors.white)
                                                  )),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 8,),
                                    Divider(color: Colors.grey, thickness: 0.5,)
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    }),
                _getCartDetailsModel == null
                ?Positioned(
                    top: 350,
                    left: 15,
                    right: 15,
                    child: Container())
                :Positioned(
                    top: 350,
                    left: 15,
                    right: 15,
                    child:  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 0),
                      child: Visibility(
                        maintainAnimation: true,
                        // maintainSize: true,
                        maintainState: true,
                        visible: _showDocument,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(horizontal: 30,vertical: 15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Color(0xFF07A9B1),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(_getCartDetailsModel!.totalServices!.toString() == ""?"":_getCartDetailsModel!.totalServices!.toString() ,
                                          style: GoogleFonts.poppins(
                                            textStyle: TextStyle(
                                                fontSize: 14, fontWeight: FontWeight.w400,color:Colors.white ),
                                          )),
                                      Text(" | ",
                                          style: GoogleFonts.poppins(
                                            textStyle: TextStyle(
                                                fontSize: 14, fontWeight: FontWeight.w400,color:Colors.white ),
                                          )),
                                      Text(_getCartDetailsModel!.sum!.toString() == ""? "": _getCartDetailsModel!.sum!.toString(),
                                          style: GoogleFonts.poppins(
                                            textStyle: TextStyle(
                                                fontSize: 14, fontWeight: FontWeight.w400,color:Colors.white ),
                                          )),
                                    ],
                                  ),
                                  Text(_getshopdetailmodel!.shopDetails!.saloonName.toString() == "" ? "" :_getshopdetailmodel!.shopDetails!.saloonName.toString(),
                                      style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            fontSize: 10, fontWeight: FontWeight.w300,color:Colors.white ),
                                      )
                                  ),
                                ],
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    Helper.moveToScreenwithPushreplaceemt(context, ReviewPayment(shop_id: widget.shop_id, coupon: "", discount: ""));
                                  });
                                },
                                child: Container(
                                  width: 80,
                                  child: Text("View Cart",
                                      style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            fontSize: 16, fontWeight: FontWeight.w400,
                                            color:Colors.white),
                                      )),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )),
                Helper.getProgressBarWhite(context, _isVisible)
              ],
            )
        )
      )
    );
  }

  _bottomSheetFilter(context) {
    showModalBottomSheet<void>(
      shape:  RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      context: context,
      elevation: 0,
      isScrollControlled:true,
      // backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return
          StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return SizedBox(
                  height: 400,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(Icons.close,color: Colors.transparent,),
                            InkWell(
                                onTap: () {
                                  Helper.popScreen(context);
                                },
                                child: Icon(Icons.close)),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Text("Choose your facial",
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w600,color:AppColor.primaryColor ),
                              )),
                        ),
                        Divider(
                          color: Colors.grey,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                padding: EdgeInsets.symmetric(vertical: 15),
                                child:

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Brightening Facial",
                                        style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w400,
                                              color:AppColor.primaryColor ),
                                        )),
                                    Container(
                                      padding: EdgeInsets.symmetric(vertical: 0),
                                      margin: EdgeInsets.symmetric(vertical: 0),
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            if (check == true) {
                                              check = false;

                                            } else {
                                              check = true;
                                            }
                                          });
                                        },
                                        child: Container(
                                          height: 30,
                                          width: 30,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(2),
                                              color: Colors.transparent),
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                bottom: 0,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius.circular(2),
                                                    color: Color(0xFFd9d9d9),
                                                  ),
                                                  height: 25,
                                                  width: 25,
                                                ),
                                              ),
                                              check == true
                                                  ? Positioned(
                                                  bottom: 0,
                                                  right: 8,
                                                  left: 5,
                                                  child: Image.asset(
                                                    ProjectImage.check,
                                                    height: 20,
                                                    width: 20,
                                                  ))
                                                  : SizedBox()
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )



                            ),
                            Container(
                                padding: EdgeInsets.symmetric(vertical: 15),
                                child:

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Classic Facial",
                                        style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                              fontSize: 18, fontWeight: FontWeight.w400
                                              ,color:AppColor.primaryColor ),
                                        )),
                                    Container(
                                      padding: EdgeInsets.symmetric(vertical: 0),
                                      margin: EdgeInsets.symmetric(vertical: 0),
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            if (checktwo == true) {
                                              checktwo = false;

                                            } else {
                                              checktwo = true;
                                            }
                                          });
                                        },
                                        child: Container(
                                          height: 30,
                                          width: 30,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(2),
                                              color: Colors.transparent),
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                bottom: 0,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius.circular(2),
                                                    color: Color(0xFFd9d9d9),
                                                  ),
                                                  height: 25,
                                                  width: 25,
                                                ),
                                              ),
                                              checktwo == true
                                                  ? Positioned(
                                                  bottom: 0,
                                                  right: 8,
                                                  left: 5,
                                                  child: Image.asset(
                                                    ProjectImage.check,
                                                    height: 20,
                                                    width: 20,
                                                  ))
                                                  : SizedBox()
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )




                            ),
                            Container(
                                padding: EdgeInsets.symmetric(vertical: 15),
                                child:
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Hydrated Facial",
                                        style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                              fontSize: 18, fontWeight: FontWeight.w400,color:AppColor.primaryColor ),
                                        )),
                                    Container(
                                      padding: EdgeInsets.symmetric(vertical: 0),
                                      margin: EdgeInsets.symmetric(vertical: 0),
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            if (checkthree == true) {
                                              checkthree = false;

                                            } else {
                                              checkthree = true;
                                            }
                                          });
                                        },
                                        child: Container(
                                          height: 30,
                                          width: 30,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(2),
                                              color: Colors.transparent),
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                bottom: 0,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius.circular(2),
                                                    color: Color(0xFFd9d9d9),
                                                  ),
                                                  height: 25,
                                                  width: 25,
                                                ),
                                              ),
                                              checkthree == true
                                                  ? Positioned(
                                                  bottom: 0,
                                                  right: 8,
                                                  left: 5,
                                                  child: Image.asset(
                                                    ProjectImage.check,
                                                    height: 20,
                                                    width: 20,
                                                  ))
                                                  : SizedBox()
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                            ),
                            Center(
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 20),
                                child: MaterialButton(
                                  color: Color(0xFF09BDFC),
                                  textColor: Colors.white,
                                  minWidth: 320,
                                  padding: EdgeInsets.symmetric(horizontal: 20,vertical: 15),
                                  child: Text("Confirm",
                                      style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            fontSize: 18, fontWeight: FontWeight.w500,
                                            color:Colors.white),
                                      )),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30)),
                                  onPressed: () {
                                    // Helper.moveToScreenwithPush(context, DateTimeScreen(shopId: '',));
                                    // Helper.moveToScreenwithPush(context, ReviewPayment());
                                    // Helper.popScreen(context);
                                  },
                                ),
                              ),
                            ),
                          ],
                        )

                      ],
                    ),
                  ),
                );
              }
          );

      },
    );
  }

  setProgress(bool show) {
    if (mounted)
      setState(() {
        _isVisible = show;
      });
  }
  Future<void> AddservicesApi(String id) async {

    print("<==============AddservicesApi==================>");

    _hashData = true;
    setProgress(true);

    SessionHelper session = await SessionHelper.getInstance(context);
    String userId = session.get(SessionHelper.USER_ID) ?? "0";


    Map data = {
      'user_id': userId,
      'service_id':id,
      'isupdate': addserviceparameter,
      'shop_id': widget.shop_id,
    };

    print("Request =============>" + data.toString());
    try {
      var res = await http.post(Uri.parse(Apis.addService), body: data);
      print("Response ============>" + res.body);

      if (res.statusCode == 200) {
        try {
          final jsonResponse = jsonDecode(res.body);
          AddServiceModel model = AddServiceModel.fromJson(jsonResponse);

          if (model.status == "true") {
            _hashData = false;

            setState((){
              _addServicesmodel = model;
              Helper.moveToScreenwithPush(context,ReviewPayment(shop_id: widget.shop_id, coupon: "", discount: ""));
            });

            print("Model status true");
            setProgress(false);
            _hashData = false;
            ToastMessage.msg(model.message.toString());
          } else {
            setProgress(false);
            _hashData = false;
            print("false ### ====add1========>");
            ToastMessage.msg(model.message.toString());
          }
        } catch (e) {
          _hashData = false;
          print("false =========add2===>");
          ToastMessage.msg(StaticMessages.API_ERROR);
          print('exception ==> ' + e.toString());
        }
      } else {
        _hashData = false;
        print("status code ==> add3" + res.statusCode.toString());
        ToastMessage.msg(StaticMessages.API_ERROR);
      }
    } catch (e) {
      _hashData = false;
      ToastMessage.msg(StaticMessages.API_ERROR);
      print('Exception ====add4==> ' + e.toString());
    }
  }
  Future<void> DeleteCartApi(String id) async {

    print("<==============AddservicesApi==================>");

    _hashData = true;
    setProgress(true);

    SessionHelper session = await SessionHelper.getInstance(context);
    String userId = session.get(SessionHelper.USER_ID) ?? "0";


    Map data = {
      'user_id': userId,
    };

    print("Request =============>" + data.toString());
    try {
      var res = await http.post(Uri.parse(Apis.deleteCart), body: data);
      print("Response ============>" + res.body);

      if (res.statusCode == 200) {
        try {
          final jsonResponse = jsonDecode(res.body);
          DeleteCartModel model = DeleteCartModel.fromJson(jsonResponse);

          if (model.status == "true") {
            _hashData = false;

            setState((){
              _deleteCartModel = model;
              Helper.checkInternet(AddservicesApi(id));
            });

            // Helper.moveToScreenwithPush(context,  DateTimeScreen(
            //     shopId: _getshopdetailmodel!.shopDetails!.shopId.toString(),
            //     bookingId: _addServicesmodel!.bookingId!.toString(),
            //     time: '', date: '', sum: "" ));

            // Helper.moveToScreenwithPush(context, ReviewPayment(shop_id: widget.shop_id, coupon: "", discount: ""));

            print("Model status true");
            setProgress(false);
            _hashData = false;
            ToastMessage.msg(model.message.toString());
          } else {
            setProgress(false);
            _hashData = false;
            print("false ### ====add1========>");
            ToastMessage.msg(model.message.toString());
          }
        } catch (e) {
          _hashData = false;
          print("false =========add2===>");
          ToastMessage.msg(StaticMessages.API_ERROR);
          print('exception ==> ' + e.toString());
        }
      } else {
        _hashData = false;
        print("status code ==> add3" + res.statusCode.toString());
        ToastMessage.msg(StaticMessages.API_ERROR);
      }
    } catch (e) {
      _hashData = false;
      ToastMessage.msg(StaticMessages.API_ERROR);
      print('Exception ====add4==> ' + e.toString());
    }
  }
  Future<void> getShopDetailsApi() async {

    print("<==============getShopDetailsApi==================>");

    _hashData = true;
    setProgress(true);

    SessionHelper session = await SessionHelper.getInstance(context);
    String userId = session.get(SessionHelper.USER_ID) ?? "0";


    Map data = {
      'user_id': userId,
      'shop_id':widget.shop_id
    };

    print("Request =============>" + data.toString());
    try {
      var res = await http.post(Uri.parse(Apis.getShopDetails), body: data);
      print("Response ============>" + res.body);

      if (res.statusCode == 200) {
        try {
          final jsonResponse = jsonDecode(res.body);
          Getshopdetailmodel model = Getshopdetailmodel.fromJson(jsonResponse);

          if (model.status == "true") {
            _hashData = false;

            setState(() {
              _getshopdetailmodel = model;
              // nameController.text =_getprofileModel!.data!.name.toString() ;
              // phoneController.text =_getprofileModel!.data!.phone.toString() ;
              // emailController.text =_getprofileModel!.data!.email.toString() ;

              // showDate =dob ;
              // img =_profileModel!.userData![0].image![0].toString();
              // Helper.checkInternet(getBookTotal2());
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
  Future<void> getCartDetailsApi() async {
    print("<==============getCartDetails==================>");

    _hashData = true;
    setProgress(true);

    SessionHelper session = await SessionHelper.getInstance(context);
    String userId = session.get(SessionHelper.USER_ID) ?? "0";

    Map data = {'user_id': userId};
    print("Request =============>" + data.toString());
    try {
      var res = await http.post(Uri.parse(Apis.getCartDetails), body: data);
      print("Response get ===getCartDetails=======>" + res.body);

      if (res.statusCode == 200) {
        try {
          final jsonResponse = jsonDecode(res.body);
          GetCartDetailsModel model = GetCartDetailsModel.fromJson(jsonResponse);

          if (model.status == "true") {
            setState(() {
              _getCartDetailsModel = model;
              if(_getCartDetailsModel!.totalServices.toString() == "0")
              {
                _showDocument = false;
              }
              else{
                _showDocument = true;
              }
            });

            setProgress(false);
            _hashData = false;
            ToastMessage.msg(model.message.toString());
          }
          else {
            setProgress(false);
            _hashData = false;
            print("false ### =====GetCartDetailsModel=1======>");
            ToastMessage.msg(model.message.toString());
          }
        } catch (e) {
          _hashData = false;
          print("false =======GetCartDetailsModel=2====>");
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
      print('Exception ==getreviewappointment====> ' + e.toString());
    }
  }
  Future<void> CheckShopInCartApi(String id) async {
    print("<==============checkshopincart==================>");

    _hashData = true;
    setProgress(true);

    SessionHelper session = await SessionHelper.getInstance(context);
    String userId = session.get(SessionHelper.USER_ID) ?? "0";

    Map data = {
      'user_id': userId,
      'shop_id' : widget.shop_id
    };
    print("Request =============>" + data.toString());
    try {
      var res = await http.post(Uri.parse(Apis.checkShopInCart), body: data);
      print("Response get ===getCartDetails=======>" + res.body);

      if (res.statusCode == 200) {
        try {
          final jsonResponse = jsonDecode(res.body);
          CheckShopInCartModel model = CheckShopInCartModel.fromJson(jsonResponse);

          if (model.status == "true") {
            setState(() {
              _checkShopInCartModel = model;
              // Helper.checkInternet(AddservicesApi(id));
            });
            if(_checkShopInCartModel!.data.toString() == "0")
              showAlertDialog(context, id);
            else {
              Helper.checkInternet(AddservicesApi(id));
            }


              setProgress(false);
            _hashData = false;
            ToastMessage.msg(model.message.toString());
          }
          else {
            setProgress(false);
            _hashData = false;
            print("false ### =====Delete Cart API RUN=1======>");
            print("false ### =====Delete Cart API RUNned======>");
            ToastMessage.msg(model.message.toString());
          }
        } catch (e) {
          _hashData = false;
          print("false =======GetCartDetailsModel=2====>");
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
      print('Exception ==getreviewappointment====> ' + e.toString());
    }
  }
  showAlertDialog(BuildContext context, String id) {
    // set up the AlertDialog

    AlertDialog alert = AlertDialog(
      scrollable: false,
      backgroundColor: Colors.transparent,
      // elevation: 0,
      content: Container(
          // padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          // margin: EdgeInsets.only(top: 50),
          height: 150,
          width: 380,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30), color: Colors.white),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Text("****${id}******"),
              Text(
                "Do You want to delete Previous Booking",textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    )),
              ),
              SizedBox(height: 15,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      Helper.popScreen(context);
                    },
                    child: Container(
                      height: 30,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.cyan
                      ),
                      child: Center(
                        child: Text(
                          "Cancel",
                          style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 17),
                        ),
                      ),
                    ),
                  ),

                  InkWell(
                    onTap: () {
                      Helper.checkInternet(DeleteCartApi(id));
                    },
                    child: Container(
                      height: 30,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                          color: Colors.cyan
                      ),
                      child: Center(
                        child: Text(
                          "Ok",
                          style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 17),
                        ),
                      ),
                    ),
                  )
                  // MaterialButton(
                  //   color: Colors.white,
                  //   minWidth: 50,
                  //   height: 45,
                  //   textColor: Colors.white,
                  //   elevation: 20,
                  //   child: Text(
                  //     "Cancel",
                  //     style: GoogleFonts.poppins(
                  //         color: Colors.black,
                  //         fontWeight: FontWeight.w600,
                  //         fontSize: 17),
                  //   ),
                  //   shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(12)),
                  //   onPressed: () {
                  //     Helper.popScreen(context);
                  //   },
                  // ),
                  // MaterialButton(
                  //   color: Colors.white,
                  //   minWidth: 50,
                  //   height: 45,
                  //   textColor: Colors.white,
                  //   elevation: 20,
                  //   child: Text(
                  //     "Ok",
                  //     style: GoogleFonts.poppins(
                  //         color: Colors.black,
                  //         fontWeight: FontWeight.w600,
                  //         fontSize: 17),
                  //   ),
                  //   shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(12)),
                  //   onPressed: () {
                  //     Helper.checkInternet(DeleteCartApi(id));
                  //   },
                  // ),
                ],
              )
            ],
          )),
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
}


class _MyDialog extends StatefulWidget {
  const _MyDialog({
    required this.cities,
    required this.selectedCities,
    required this.onSelectedCitiesListChanged,
  });
  final List cities;
  final List selectedCities;
  final ValueChanged<List> onSelectedCitiesListChanged;
  @override
  _MyDialogState createState() => _MyDialogState();
}

class _MyDialogState extends State<_MyDialog> {
  List _tempSelectedCities = [];
  @override
  void initState() {
    _tempSelectedCities = List.of(widget.selectedCities);
    super.initState();


  }
  @override
  Widget build(BuildContext context) {
    return  Dialog(
      alignment: Alignment.topRight,
      insetPadding: EdgeInsets.only(left: 50, top: 0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal:  20,vertical: 20),
        height: 450,
        width: 400,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.white),
        child: Column(
          children: [
            Text(
              "Why do you want to Report?",
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  )),
            ),
            SizedBox(height: 20,),
            Expanded(
              child: ListView.builder(
                itemCount: widget.cities.length,
                itemBuilder: (BuildContext context, int index) {
                  final cityName = widget.cities[index];
                  return SizedBox(
                    width: 160,
                    height: 50,
                    child: CheckboxListTile(
                      contentPadding: EdgeInsets.all(0),
                      activeColor: Color(0xFFf14656),
                      controlAffinity: ListTileControlAffinity.leading,
                      title: Text(cityName,style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          )),),
                      value: _tempSelectedCities.contains(cityName),
                      onChanged: (bool? value) {
                        if (value != null && value) {
                          if (!_tempSelectedCities.contains(cityName)) {
                            setState(() {
                              _tempSelectedCities.add(cityName);
                            });
                          }
                        } else {
                          if (_tempSelectedCities.contains(cityName)) {
                            setState(
                                  () {
                                _tempSelectedCities
                                    .removeWhere((city) => city == cityName);
                              },
                            );
                          }
                        }
                      },
                      checkboxShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                    ),
                  );
                },
              ),
            ),
            Row (
              children: [
                InkWell(
                  onTap: (){print("tapped");},


                  child: Container(
                    height: 45,
                    width: 100,
                    decoration: BoxDecoration(
                      border: Border.all(width: 2, color: Color(0xFF09baf8)),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Cancel",
                          style: GoogleFonts.poppins(
                              color:Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 17
                          ),
                        ),
                      ],
                    ),
                    // child: MaterialButton(
                    //   color: Colors.white,
                    //   minWidth: 100,
                    //   height: 45,
                    //   textColor: Colors.black ,
                    //
                    //   child: Text("No",
                    //     style: GoogleFonts.poppins(
                    //         color:Colors.black,
                    //         fontWeight: FontWeight.w600,
                    //         fontSize: 17
                    //     ),
                    //   ),
                    //   shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(30)),
                    //   onPressed: () {
                    //    // deleteImage(whichImage);
                    //     Helper.popScreen(context);
                    //     print("which image---->${whichImage}");
                    //   },
                    // ),
                  ),
                ),
                SizedBox(width: 70,),
                MaterialButton(
                  color: Color(0xFF09BDFC),
                  minWidth: 100,
                  height: 45,
                  textColor: Colors.white,
                  child: Text("Submit",
                    style: GoogleFonts.poppins(
                        color:Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 17
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  onPressed: () {
                    Helper.popScreen(context);

                  },
                ),

              ],
            ),

          ],
        ),
      ),
    );
  }
}

class Review extends StatefulWidget {
  const Review({Key? key}) : super(key: key);

  @override
  State<Review> createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
  ReviewModal?_reviewModal;
  bool _hashData = false;
  bool _isVisible = false;
  bool _showDocument = true;

  void initState() {
    // TODO: implement initState
    super.initState();
    Helper.checkInternet(getShopReview());
    _showDocument = false;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _reviewModal==null
              ?_hashData
              ? Container()
              :Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Center(
                  child: Text(S.of(context).NoDataFound,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,color: Colors.black,
                        fontSize: 25
                    ),
                  )
              )) :
          Container (
            height: MediaQuery
                .of(context)
                .size
                .height,
            width: MediaQuery
                .of(context)
                .size
                .width,
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 100,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
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
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RichText(
                              text: TextSpan(children: [
                                TextSpan(text: _reviewModal!.averageRating.toString(),
                                    style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w500,
                                          color: AppColor.primaryColor),
                                    )),
                                WidgetSpan(
                                  child: Transform.translate(
                                    offset: const Offset(-2, 4),
                                    child: Text(
                                        '/5',
                                        //superscript is usually smaller in size
                                        style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: AppColor.primaryColor),
                                        )
                                    ),
                                  ),
                                )
                              ]),
                            ),
                            RatingBar.builder(
                              ignoreGestures: true,
                              initialRating: double.parse(_reviewModal!.averageRating.toString()),
                              minRating: 1,
                              itemSize: 20,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                              itemBuilder: (context, _) =>
                                  Icon(
                                    Icons.star,
                                    color: Color(0xFFFFCC00),
                                  ),
                              onRatingUpdate: (rating) {
                                print(rating);
                              },
                            )
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          height: 40,
                          child: VerticalDivider(
                            color: Colors.grey,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 100,
                              child: Text("${S.of(context).Basedon}\n${_reviewModal!.totalReview.toString()} ${S.of(context).Reviews}",
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: AppColor.primaryColor),
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),

                          ],
                        ),
                      ],
                    ),
                  ),
                  ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      itemCount: _reviewModal!.reviewList!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          child: Column(
                            children: [
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween,
                                      children: [
                                        RatingBar.builder(
                                          initialRating: double.parse(_reviewModal!.reviewList![index].rating.toString()),
                                          ignoreGestures: true,
                                          minRating: 1,
                                          itemSize: 25,
                                          direction: Axis.horizontal,
                                          allowHalfRating: false,
                                          tapOnlyMode: false,
                                          itemCount: 5,
                                          itemPadding: EdgeInsets.symmetric(
                                              horizontal: 2.0),
                                          itemBuilder: (context, _) =>
                                              Icon(
                                                Icons.star,
                                                color: Color(0xFFFFCC00),
                                              ),
                                          onRatingUpdate: (rating) {
                                            print(rating);
                                          },
                                        ),
                                        Text(_reviewModal!.reviewList![index].timestamp.toString(),
                                          style: GoogleFonts.poppins(
                                            textStyle: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                                color: AppColor.primaryColor),),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(_reviewModal!.reviewList![index].name.toString(),
                                        style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              color: AppColor.primaryColor),),
                                        textAlign: TextAlign.center,
                                      ),
                                      Text(_reviewModal!.reviewList![index].serviceComment.toString(),
                                        style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              color: AppColor.primaryColor),),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10.0),
                                    child: Text(
                                      _reviewModal!.reviewList![index].comment.toString(),
                                      style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: AppColor.primaryColor,),
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ],
                              )

                            ],
                          ),
                        );
                      }),
                ],
              ),
            ),
          ),
          Helper.getProgressBarWhite(context, _isVisible)
        ],
      ),


    );
  }

  Future<void> getShopReview() async {
    _hashData = true;
    setProgress(true);
    SessionHelper sessionHelper = await SessionHelper.getInstance(context);
    String userId = sessionHelper.get(SessionHelper.USER_ID) ?? "0";


    Map data = {
      "user_id": userId,
      "shop_id": "1",
    };

    try {
      var req = await http.post(Uri.parse(Apis.getShopReview), body: data);

      if (req.statusCode == 200) {
        try {
          final jsonResponse = jsonDecode(req.body);
          ReviewModal model = ReviewModal.fromJson(jsonResponse);

          if (model.status == "true") {
            _hashData = false;

            setState(() {
              _reviewModal = model;
            });

            print("Model status true");
            _hashData = false;
            setProgress(false);

            ToastMessage.msg(model.message.toString());
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
        print("status code ==> " + req.statusCode.toString());
        ToastMessage.msg(StaticMessages.API_ERROR);
      }
    } catch (e) {
      _hashData = false;
      ToastMessage.msg(StaticMessages.API_ERROR);
      print('Exception ======> ' + e.toString());
    }
  }
  setProgress(bool show) {
    if (mounted)
      setState(() {
        _isVisible = show;
      });
  }
}