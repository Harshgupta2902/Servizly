

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:serviceapplatest/bottom_screens/bottom.dart';
import '../generated/l10n.dart';
import '../helper/constant.dart';
import '../helper/image.dart';
import '/Repository/settings_repository.dart' as settingRepo;


class LaunguageScreen extends StatefulWidget {
  const LaunguageScreen({Key? key}) : super(key: key);

  @override
  State<LaunguageScreen> createState() => _LaunguageScreenState();
}

class _LaunguageScreenState extends State<LaunguageScreen> {

  int selectIndex = 0;
  final List<TopSalonModel> _topsalonlist = [
    TopSalonModel(image: ProjectImage.uk,lang: "English",type:"English"),
    TopSalonModel(image: ProjectImage.india,lang: "હિન્દી",type:"Hindi"),
    // TopSalonModel(image: ProjectImage.Gujrati,lang: "ગુજરાતી",type:"Gujrati"),
    // TopSalonModel(image: ProjectImage.Marathi,lang: "મરાઠી",type:"Marathi"),
    // TopSalonModel(image: ProjectImage.Tamil,lang: "તમિલ",type:"Tamil"),
    // TopSalonModel(image: ProjectImage.Telugu,lang: "તેલુગુ",type:"Telugu"),
    // TopSalonModel(image: ProjectImage.Bangla,lang: "બાંગ્લા",type:"Bangla"),
    // TopSalonModel(image: ProjectImage.Malyalam,lang: "મલયાલમ",type:"Malyalam"),
  ];

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
          S.of(context).Language,
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
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount:_topsalonlist.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                      childAspectRatio: 2/2
                  ),
                  itemBuilder: (BuildContext context, int index){
                    return
                      InkWell(
                        onTap: (){
                          setState(() {
                            selectIndex = index;
                            print("**********selectIndex**************${selectIndex}");
                            // pastSelectIndex();
                            // changeLang();

                          });
                        },
                        child: Container(
                          padding:const EdgeInsets.symmetric(vertical: 20,horizontal: 10),
                          decoration:const BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                            color: Color(0xFFFFFFFF),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 7,
                                offset: Offset(3, 5),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(_topsalonlist[index].image,height: 40,width: 40,),
                              SizedBox(height: 10,),
                              Text(
                                _topsalonlist[index].lang,
                                style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: AppColor.primaryColor,
                                    )),
                              ),
                              Text(
                                _topsalonlist[index].type,
                                style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color: AppColor.primaryColor,
                                    )),
                              ),
                            ],
                          ),
                        ),
                      );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> pastSelectIndex() async {
    SessionHelper sessionHelper = await SessionHelper.getInstance(context);
    String str = sessionHelper.get(SessionHelper.LANGAUGE)??"0";
    print("**********************Session Language***********************************${str}");
    debugPrint("default language = " + str);
    // if (str == 'en') return temp = 0;
    // print(temp);
    // if (str == 'hi') return temp = 1;
    // print("**************${temp}");
    // return 1;
    if (str == 'en') {
      setState(() {
        selectIndex=0;
      });
    }else{
      setState(() {
        selectIndex=1;
      });
    }
    // print(temp);
    // if (str == 'hi')


  }
  void getDefaultLanguage() async {
    String str = await settingRepo.getDefaultLanguage('en');
    debugPrint("default language = " + str);
    if (str == 'en') selectIndex == 0;
    if (str == 'hi') selectIndex == 1;
    if (mounted) {
      setState(() {});
    }
  }

  void changeLang() async {
    String lang = 'en';
    if (selectIndex == 0) lang = 'en';
    if (selectIndex == 1) lang = 'hi';
    debugPrint("selected language = " + lang);
    SessionHelper sessionHelper = await SessionHelper.getInstance(context);
    sessionHelper.put(SessionHelper.LANGAUGE, lang);
    settingRepo.setting.value.mobileLanguage.value = Locale(lang);
    print("*****************************${Locale(lang)}****************************************");
    settingRepo.setDefaultLanguage(lang);
    settingRepo.setting.notifyListeners();
    Helper.moveToScreenwithPushreplaceemt(context, Bottom());
  }

}

class TopSalonModel {
  String image = "";
  String lang = "";
  String type = "";

  TopSalonModel({required this.image,required this.lang,required this.type});
}