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
      UserModel? savedUser = await SharedPref.getUser();
      var selectedLanguage = await SharedPref.getSelectedLanguage();
      if (savedUser != null) {
        // await SharedPref.removeUser();
        CommonController commonController = Get.find<CommonController>();
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
            color: AppColors.white
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedContainer(
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
              ),
              Text("Wall Master",style: TextStyle(color: Color(0xffA61892),fontSize: 54,fontFamily: 'impact',letterSpacing: 3),),
              Text("Your world, your Screen...",style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),),
              SizedBox(height: 20,),
              Container(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  color: Color(0xffA61892),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
