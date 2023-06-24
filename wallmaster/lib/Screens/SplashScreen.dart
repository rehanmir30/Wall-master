import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:wallmaster/Constants/AppColors.dart';
import 'package:wallmaster/Controllers/AuthenticationController.dart';
import 'package:wallmaster/DB/SharedPreferences/SharedPreferences.dart';
import 'package:wallmaster/Screens/HomeScreen/HomeScreen.dart';
import 'package:wallmaster/Screens/Onboarding/Onborading.dart';

import '../Controllers/CommonController.dart';
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
    Future.delayed(const Duration(milliseconds: 2000), () {
      setState(() {
        _isVisible = true;
      });
    });
    Future.delayed(const Duration(milliseconds: 3000), () async {
      UserModel? savedUser = await SharedPref.getUser();
      if (savedUser != null) {
        AuthenticationController authenticationController = Get.find<AuthenticationController>();
        await authenticationController.setUserData(savedUser);
        CommonController commonController = Get.find<CommonController>();
        await commonController.getCategories();
        await commonController.getAllProducts();
        Get.offAll(()=>const HomeScreen());
      }else{
        Get.offAll(const Onboarding());
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
            color: AppColors.black
        ),
        child: Center(
          child: AnimatedContainer(
            width: _isVisible ? 0 : 400,
            height: _isVisible ? 0 : 400,
            curve: Curves.bounceIn,
            duration: Duration(seconds: 1),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/logo.png"),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
