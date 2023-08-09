import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:modal_bottom_sheet/modal_bottom_sheet.dart' as sheet;
import 'package:light_modal_bottom_sheet/light_modal_bottom_sheet.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:wallmaster/Screens/HomeScreen/SubScreens/Drawer/PrivacyPolicy/PrivacyPolicyScreen.dart';
import 'package:wallmaster/Screens/Onboarding/Menu/FAQSCREEN.dart';
import 'package:wallmaster/Screens/Onboarding/Menu/HelpScreen.dart';
import 'package:wallmaster/Screens/auth/SignUpScreen.dart';
import '../../Constants/AppColors.dart';
import '../../Controllers/LocalizationController.dart';
import '../../CustomWidgets/MyAlertDialog.dart';
import '../HomeScreen/HomeScreen.dart';
import '../auth/LoginScreen.dart';
import 'Menu/ForgetPassword.dart';
import 'OnboardingController.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({Key? key}) : super(key: key);

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final _controller = OnBoardingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  static bool showPass =false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            extendBodyBehindAppBar: true,
            backgroundColor: Colors.black,
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: Colors.transparent,
              leading: Container(
                  padding: EdgeInsets.all(5),
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    backgroundImage: AssetImage('assets/images/circle_logo.png'),
                    // radius: 20,
                  )),
              actions: [
                InkWell(
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                    highlightColor: Colors.transparent,
                    radius: 10,
                    onTap: () {
                      print("Clicked");
                      Get.to(()=>PrivacyPolicyScreen());
                    },
                    child: Center(
                      child: Container(
                          padding: EdgeInsets.only(right: 10),
                          margin: EdgeInsets.only(right: 10),
                          child: Text(
                            "Privacy".tr,
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          )),
                    )),
                InkWell(
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                    borderRadius: BorderRadius.circular(20),
                    highlightColor: Colors.transparent,
                    onTap: () {
                      print("Clicked");
                      Get.to(const LoginScreen());
                    },
                    child: Center(
                      child: Container(
                          padding: EdgeInsets.only(right: 10),
                          margin: EdgeInsets.only(right: 10),
                          child: Text(
                            "Signin".tr,
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          )),
                    )),
                // InkWell(
                //     highlightColor: Colors.transparent,
                //     overlayColor: MaterialStateProperty.all(Colors.transparent),
                //     onTap: () {
                //       print("Clicked");
                //     },
                //     child: Center(
                //       child: Container(
                //           padding: EdgeInsets.only(right: 20),
                //           child: Icon(
                //             Icons.more_vert_outlined,
                //             color: Colors.grey[400],
                //           )),
                //     )),
                PopupMenuButton<int>(
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 1,
                      // row with 2 children
                      child: Text("FAQ's".tr),
                    ),
                    PopupMenuItem(
                      value: 2,
                      // row with two children
                      child: Text("Help".tr),
                    ),
                    PopupMenuItem(
                      value: 3,
                      // row with two children
                      onTap: (){
                        // Get.to(ForgetScreen());
                      },
                      child: Text("ForgetPassword".tr),
                    ),
                  ],
                  offset: Offset(0, 0),
                  color: Colors.white,
                  elevation: 2,
                  onSelected: (value) {
                    if (value == 1) {
                      Get.to(()=>FAQSCREEN());
                    } else if (value == 2) {
                      Get.to(()=>HelpScreen());
                    }else if(value == 3){
                      Get.to(()=>ForgetPassword());
                    }
                  },
                ),
              ],
            ),
            body: Stack(
              children: [
                Positioned(
                  child: Container(
                    child: PageView.builder(
                        controller: _controller.pageController,
                        onPageChanged: _controller.onPageIndex,
                        itemCount: _controller.onBoardingPages.length,
                        itemBuilder: (context, index) {
                          return Stack(
                            children: [
                              Positioned.fill(
                                top:0,
                                bottom: 60,
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                    image: AssetImage(_controller
                                        .onBoardingPages[index].imageAsset),
                                    fit: BoxFit.contain,
                                  )),
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  // color: Colors.black.withOpacity(0.6),
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 150,
                                  ),
                                  Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.7,
                                      child: Text(
                                        _controller.onBoardingPages[index].name,
                                        style: TextStyle(
                                            fontSize: 43,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.center,
                                      )),
                                  Center(
                                      child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.7,
                                          child: Text(
                                            _controller
                                                .onBoardingPages[index].slogon,
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.white60),
                                            textAlign: TextAlign.center,
                                          ))),
                                ],
                              ),
                            ],
                          );
                        }),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  right: 10,
                  left: 10,
                  // left: MediaQuery.of(context).size.width*0.4,
                  child: Column(
                    children: [

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          SizedBox(width: 70,),
                          Expanded(
                            child: GetBuilder<Localization>(builder: (controller) {
                              return InkWell(
                                  onTap: (){
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return MyAlertDialog();
                                      },
                                    );
                                  },
                                  child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Text(controller.dropdownValue['name'].toString(),style: TextStyle(color: Colors.white,fontSize: 26,fontWeight: FontWeight.bold),),Icon(Icons.arrow_drop_down_sharp,color: AppColors.white,size: 50,)],));
                            },),
                          ),
                          // SizedBox(
                          //   height: 30,
                          // ),
                          SmoothPageIndicator(
                              controller: _controller.pageController,
                              // PageController
                              count: _controller.onBoardingPages.length,
                              effect: SlideEffect(
                                  spacing: 8.0,
                                  radius: 50.0,
                                  dotWidth: 20.0,
                                  dotHeight: 20.0,
                                  paintStyle: PaintingStyle.stroke,
                                  strokeWidth: 1.5,
                                  dotColor: Colors.grey,
                                  activeDotColor: Colors.red),
                              // your preferred effect
                              onDotClicked: (index) {}),




                        ],),

                      SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () {
                          // bottomSheets();
                          Get.to(()=>SignUpScreen());
                        },
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 50,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Color(0xffFF0100),
                            ),
                            child: Text(
                              'GETSTARTED'.tr,
                              style:
                                  TextStyle(fontSize: 25, color: Colors.white),
                            )),
                      ),
                    ],
                  ),
                )
              ],
            )));
  }

  Widget circleBar(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8),
      height: isActive ? 12 : 8,
      width: isActive ? 12 : 8,
      decoration: BoxDecoration(
          color: isActive ? Colors.red : Colors.grey[400],
          borderRadius: BorderRadius.all(Radius.circular(12))),
    );
  }

  void choiceAction(String choice) {
    if (choice == "FAQs".tr) {
      print('FAQs'.tr);
    } else if (choice == "Help".tr) {
      print('Help'.tr);
    }
  }

  bottomSheets() {
    showMaterialModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      context: context,
      builder: (context) => SingleChildScrollView(
        child: BottomSheetClass(),
      ),
    );
  }
}

class BottomSheetClass extends StatefulWidget {
  const BottomSheetClass({Key? key}) : super(key: key);

  @override
  State<BottomSheetClass> createState() => _BottomSheetClassState();
}

class _BottomSheetClassState extends State<BottomSheetClass> {
  TextEditingController _controllerEmail =TextEditingController();
  var email;
  bool errorEmail =false;
  bool errorEmailFormat =false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Form(
        key: _formKey,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
            color: Colors.white,
          ),
          height: MediaQuery.of(context).size.height * 0.9,
          child: Column(
            children: [
              Container(
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.only(right: 20),
                  child: InkWell(
                    onTap: (){
                     Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.close,
                      color: Colors.black,
                    ),
                  )),
              SizedBox(
                height: 40,
              ),
              Text(
                "Sign Up",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10,),
              Text(
                "Enter your email to create or sign in to your\naccount.",
                style: TextStyle(color: Colors.black, fontSize: 12),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40,),
              Container(
                padding: EdgeInsets.only(left: 10,right: 10,top: 10),
                margin: EdgeInsets.only(left: 18,right: 18,top: 10,bottom: 10),
                width: MediaQuery.of(context).size.width,
                height: 60,
                decoration: BoxDecoration(
                  border: Border.all(width: 1,color: Colors.red),
                ),
                child: TextFormField(
                  controller: _controllerEmail,
                  onChanged: (value){
                    email = value;
                    print(email.toString());
                    setState(() {
                      errorEmail=false;
                      errorEmailFormat = false;
                    });
                  },
                  validator: (email){
                    if(email==null||email==""||email.isEmpty)
                    { setState(() {
                      errorEmail =true;}); }
                    else if(!email.isEmail)
                      {
                        setState(() {
                          errorEmailFormat = true;
                        });
                      }
                    else if(!email.contains("@gmail.com")){
                      setState(() {
                        errorEmailFormat = true;
                      });
                    }

                  },
                  maxLines: 1,
                  autofocus: true,
                  cursorColor: Colors.black,
                  enableSuggestions: true,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    labelText: "Email",
                    labelStyle: TextStyle(color: Colors.grey,fontSize: 18),
                    hintStyle: TextStyle(color: Colors.grey),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                     borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: errorEmail,
                child: Container(
                  margin: EdgeInsets.only(left: 20),
                  child: Align(
                      alignment:Alignment.centerLeft,
                      child: Text("Email or phone number required",style: TextStyle(color: Colors.red,fontSize: 12),)),
                ),
              ),
              Visibility(
                visible: errorEmailFormat,
                child: Container(
                  margin: EdgeInsets.only(left: 20),
                  child: Align(
                      alignment:Alignment.centerLeft,
                      child: Text("Wrong email format",style: TextStyle(color: Colors.red,fontSize: 12),)),
                ),
              ),
              SizedBox(height: 20,),
              InkWell(
                onTap: (){
                  if(_formKey.currentState != null &&_formKey.currentState!.validate())
                    {
                      if(!_controllerEmail.text.isEmpty &&_controllerEmail.text.isEmail&&_controllerEmail.text.contains("@gmail.com"))
                        {
                          print("WORKING::::::");
                          // Get.to(SignUpScreen(_controllerEmail.text.trim()));
                        }
                    }
                  else return;
                },
                child: Container(
                    margin: EdgeInsets.only(left: 18,right: 18,top: 10,bottom: 10),
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Color(0xffFF0100),
                    ),
                    child: Text(
                      'GET STARTED',
                      style:
                      TextStyle(fontSize: 25, color: Colors.white),
                    )),
              ),



            ],
          ),
        ),
      ),
    );
  }
}
