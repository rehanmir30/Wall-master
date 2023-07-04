import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:wall_master_admin/Controllers/CommonController.dart';
import 'package:wall_master_admin/Models/AdminModel.dart';


import '../../../Constants/AppColors.dart';
import '../../../Controllers/AuthenticationController.dart';
import '../../../DatabaseHelper/SharedPreferences/SharedPreferences.dart';
import '../AuthScreens/LoginScreen.dart';
import '../HomeScreen/HomeScreen.dart';


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
      AdminModel? savedUser = await SharedPref.getUser();
      if (savedUser != null) {
        AuthenticationController authenticationController = Get.find<AuthenticationController>();
        await authenticationController.setAdminData(savedUser);
        CommonController commonController = Get.find<CommonController>();
        await commonController.getCategories();
        await commonController.getAllProducts();
        await commonController.getAllUsers();
        Get.offAll(()=>const HomeScreen());
      }else{
        Get.offAll(const LoginScreen());
      }

      // Get.offAll(LoginScreen());
      // Get.offAll(Onboarding());

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
