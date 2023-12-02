import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:serviceapplatest/top%20salons/portfolio_image.dart';
import 'package:serviceapplatest/helper/constant.dart';
import '../generated/l10n.dart';
import '../helper/apis.dart';
import '../helper/image.dart';
import '../model/get_shop_Portfolio.dart';

class PortfolioScreen extends StatefulWidget {
  String shop_id = "";
  PortfolioScreen({
    required this.shop_id,
  });

  @override
  State<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {
  GetPortfolio? _getPortfolio;
  bool _hashData = false;
  bool _isVisible = false;
  bool _showDocument = true;
  File? _image;

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  void initState() {
    // TODO: implement initState
    super.initState();
    Helper.checkInternet(getShopPortfolio());
    _showDocument = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: [
          _getPortfolio == null
              ? _hashData
                  ? Container()
                  : Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                          child: Text(
                            S.of(context).NoDataFound,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 25),
                      )))
              :
          GridView.builder(
            shrinkWrap: true,
            itemCount: _getPortfolio!.portfolio!.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                childAspectRatio: 2.5 / 2.5),
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                  onTap: () {
                    Helper.moveToScreenwithPush(
                        context,
                        PortfolioImage(
                            image: _getPortfolio!.portfolio![index].image.toString()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Container(

                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: _image == null
                            ? CachedNetworkImage(
                                imageUrl: _getPortfolio!
                                        .portfolio![index].image!.isEmpty
                                    ? ""
                                    : _getPortfolio!.portfolio![index].image!.toString(),
                                fit: BoxFit.fill,
                                width: 60,
                                height: 60,
                                placeholder: (context, url) =>
                                    LinearProgressIndicator(
                                  color: Colors.white.withOpacity(0.2),
                                  backgroundColor: Colors.white.withOpacity(.5),
                                ),
                                errorWidget: (context, url, error) => ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Container(
                                    width: 240,
                                    height: 220,
                                  ),
                                ),
                              )
                            : Image.file(_image!,
                                height: 80, width: 80, fit: BoxFit.fill),
                        // Image.asset(ProjectImage.google,
                        //   height: 50,width: 50,)
                      ),
                    ),
                  ));
            },
          ),
          // ListView.builder(
          //      scrollDirection: Axis.vertical,
          //      padding: EdgeInsets.symmetric(horizontal: 20),
          //      itemCount: _getPortfolio!.portfolio!.length,
          //      itemBuilder: (BuildContext context, int index) {
          //        return Container(
          //          height: 300,
          //          margin:EdgeInsets.symmetric(vertical: 10) ,
          //          child: Container(
          //            child:  Container(
          //              height: 160,
          //              width: 300,
          //              decoration: BoxDecoration(
          //                  boxShadow: [
          //                    BoxShadow(
          //                        color: Colors.grey.withOpacity(1),
          //                        blurRadius: 3,
          //                        offset: Offset(0, 3))
          //                  ],
          //                  color: Colors.white,
          //                  borderRadius: BorderRadius.circular(10)
          //              ),
          //              child: ClipRRect(
          //                  borderRadius: BorderRadius.circular(10),
          //                  child: _image == null
          //                      ? CachedNetworkImage(
          //                    imageUrl:
          //                    _getPortfolio!.portfolio![index].image!.isEmpty
          //                        ? ""
          //                        :  _getPortfolio!.portfolio![index].image!
          //                        .toString(),
          //                    fit: BoxFit.fill,
          //                    width: 60,
          //                    height: 60,
          //                    placeholder: (context, url) =>
          //                        LinearProgressIndicator(
          //                          color: Colors.white.withOpacity(0.2),
          //                          backgroundColor:
          //                          Colors.white.withOpacity(.5),
          //                        ),
          //                    errorWidget: (context, url, error) =>
          //                        ClipRRect(
          //                          borderRadius: BorderRadius.circular(20),
          //                          child: Container(
          //                            width: 240,
          //                            height: 220,
          //                          ),
          //                        ),
          //                  )
          //                      : Image.file(_image!,
          //                      height: 80, width: 80, fit: BoxFit.fill),
          //
          //              ),
          //            ),
          //          ),
          //        );
          //      }),
          Positioned(child: Helper.getProgressBarWhite(context, _isVisible))
        ],
      ),
    );
  }



  Widget _showBottomSheet(context,){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.all(10),
      child: Builder(
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height,
            child:
            // Container(
            //   height: MediaQuery.of(context).size.height,
            //   width: MediaQuery.of(context).size.width,
            //   decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(20),
            //       color: Colors.black
            //   ),
            // ),
            Column(
              children: [
                Padding(
                  padding:  EdgeInsets.only(left: 20.0),
                  child: InkWell(
                    onTap: () {
                      Helper.popScreen(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.close,color: Colors.black,size: 30,),
                        Icon(Icons.close,color: Colors.transparent,size: 30,),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.only(top: 20.0),
                  child: Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width/1.16,
                      height: MediaQuery.of(context).size.height*0.60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Color(0xFF5A5A5A),
                      ),
                      child: Center(
                        child: Container(
                          width: MediaQuery.of(context).size.width/1.5,
                          height: MediaQuery.of(context).size.height/1.5,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
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
                            child: CachedNetworkImage(
                                imageUrl: _getPortfolio!.portfolio![0].image.toString(),//widget.img,
                                fit: BoxFit.cover,
                                placeholder: (context, url) =>
                                    LinearProgressIndicator(
                                      color: AppColor.primaryColor.withOpacity(0.2),
                                      backgroundColor: AppColor.primaryColor.withOpacity(.5),
                                    ),
                                errorWidget: (context, url, error) =>
                                    Container(
                                        width: MediaQuery.of(context).size.width/1.5,
                                        height: MediaQuery.of(context).size.height/2,
                                        child:  Image.asset(ProjectImage.google,
                                          height: 80,width: 80,fit: BoxFit.fill,)
                                    )
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }


  Future<void> getShopPortfolio() async {
    print("getShopPortfolio api");

    _hashData = true;
    setProgress(true);

    SessionHelper sessionHelper = await SessionHelper.getInstance(context);
    String userId = sessionHelper.get(SessionHelper.USER_ID) ?? "0";

    _hashData = true;
    Map data = {
      "user_id": userId,
      "shop_id": widget.shop_id,
    };
    print("data===>${data}");
    try {
      var req = await http.post(Uri.parse(Apis.getShopPortfolio), body: data);

      if (req.statusCode == 200) {
        try {
          final jsonResponse = jsonDecode(req.body);
          GetPortfolio model = GetPortfolio.fromJson(jsonResponse);

          if (model.status == "true") {
            _hashData = false;

            setState(() {
              _getPortfolio = model;
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
