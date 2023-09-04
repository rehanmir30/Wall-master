import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:wallmaster/Constants/AppColors.dart';
import 'package:wallmaster/Controllers/AuthenticationController.dart';
import 'package:wallmaster/DB/SharedPreferences/SharedPreferences.dart';
import 'package:wallmaster/Screens/AdScreen/AdScreen.dart';
import 'package:wallmaster/Screens/HomeScreen/HomeScreen.dart';
import 'package:wallmaster/Screens/Onboarding/Onborading.dart';

import '../Controllers/CommonController.dart';
import '../Controllers/LocalizationController.dart';
import '../Model/UserModel.dart';
import 'auth/LoginScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isVisible = false;
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 1000), () {
      setState(() {
        _isVisible = true;
      });
    });
    Future.delayed(const Duration(milliseconds: 3000), () async {
      CommonController commonController = Get.find<CommonController>();
      UserModel? savedUser = await SharedPref.getUser();
      var selectedLanguage = await SharedPref.getSelectedLanguage();
      bool magazine = await SharedPref.getWorkManager();
      await commonController.setMagazine(magazine);
      if (savedUser != null) {
        // await SharedPref.removeUser();

        // AuthenticationController authenticationController = Get.find<AuthenticationController>();
        // await authenticationController.setUserData(savedUser);
        await commonController.getUserDetails(savedUser);

        Localization localization = Get.find<Localization>();
        if(selectedLanguage!=null){
          await localization.setSelectedLang(selectedLanguage);
        }else{
          await localization.setSelectedLang('spanish');
        }
        // await commonController.getCategories();
        // await commonController.getAllProducts();
        Get.offAll(()=>  HomeScreen());
      }else{
        Get.offAll(Onboarding());
      }

      // Get.offAll(LoginScreen());


    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            color: Colors.black
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [

              // Text("Visual Scape",style: TextStyle(color: Colors.white,fontSize: 54,fontFamily: 'impact',letterSpacing: 3),),

              SizedBox(height: 200,),
              Container(
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.center,
                    children: [

                      Positioned(
                        top:-110,
                        child: AnimatedContainer(
                        width: _isVisible ? 150 : 0,
                        height: _isVisible ? 150 : 0,
                        curve: Curves.bounceIn,
                        duration: Duration(seconds: 1),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          image: DecorationImage(
                            image: AssetImage("assets/images/modified_logo.png"),
                          ),
                        ),
                      ),),

                      Image.asset('assets/images/VisualScapeText.png',width: MediaQuery.of(context).size.width*0.9,),
                      Positioned(
                          bottom: 25,
                          child: Text("Your world, your Screen...",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),)),
                    ],
                  )),
              // SizedBox(height: 20,),
              Container(
                height: 60,
                width: 60,
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
