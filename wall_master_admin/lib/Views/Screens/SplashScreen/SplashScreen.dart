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
