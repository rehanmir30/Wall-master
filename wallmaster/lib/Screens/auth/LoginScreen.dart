import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallmaster/Constants/AppColors.dart';
import 'package:wallmaster/Controllers/AuthenticationController.dart';
import 'package:wallmaster/Controllers/CommonController.dart';
import 'package:wallmaster/CustomWidgets/CustomSnackbar.dart';
import 'package:wallmaster/CustomWidgets/LoadingAnimation.dart';

import '../HomeScreen/HomeScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  Color colos2 = Colors.brown;
  Color colos = Colors.white24;
  bool emailClicked = false;
  bool passClicked = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  final _formkey  = GlobalKey<FormState>();

  CommonController _commonController = Get.find<CommonController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.black,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors.black,
          title: Text("WallMaster".tr,style: TextStyle(color: AppColors.white,letterSpacing: 2),),
          leading: InkWell(
              onTap: (){
                Get.back();
              },
              child: Icon(Icons.arrow_back_ios_new_rounded,color: Colors.white,size: 24,)),

          actions: [
            Image.asset("assets/images/circle_logo.png",width: 45,height:45,).marginOnly(right: 10),
          ],

        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 100,),

                    Container(
                      padding: EdgeInsets.all(15),
                      width: MediaQuery.of(context).size.width,
                      height: 60,
                      decoration: BoxDecoration(
                        color: (emailClicked)?colos2:colos,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextFormField(
                        controller: emailController,
                        onTap: (){
                          setState(() {
                            emailClicked = true;
                            passClicked= false;
                          });
                        },
                        cursorColor: AppColors.red,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(

                          contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          labelText: "Email".tr,
                          labelStyle: TextStyle(color: Colors.white)
                        ),
                      ),
                    ),
                    SizedBox(height: 15,),
                    Container(
                      padding: EdgeInsets.all(15),
                      width: MediaQuery.of(context).size.width,
                      height: 60,
                      decoration: BoxDecoration(
                        color: (passClicked)?colos2:colos,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextFormField(
                        controller: passController,
                        onTap: (){
                          setState(() {
                            passClicked = true;
                            emailClicked=false;
                          });
                        },
                        cursorColor: AppColors.red,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(

                            contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            labelText: "Password".tr,
                            labelStyle: TextStyle(color: Colors.white)
                        ),
                      ),
                    ),

                    SizedBox(height: 35,),
                    InkWell(
                      onTap: () async {
                       if((emailController.text==null ||emailController.text=="")||(passController.text==null ||passController.text=="")){
                         CustomSnackbar.show( "PleaseFillAllTheFiled".tr, AppColors.red);
                       }else{
                         _commonController.setLoading(true);
                         AuthenticationController authController = Get.find<AuthenticationController>();
                         await authController.SignInUser(emailController.text, passController.text);
                         _commonController.setLoading(false);
                       }
                      },
                      child: Container(
                        height: 50,
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: AppColors.black,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.white,width: 1,)
                        ),
                        child: Text("signin".tr,style: TextStyle(color: Colors.white),),
                      ),
                    ),

                    //signin with google
                    SizedBox(height: 35,),
                    InkWell(
                      onTap: () async {

                          _commonController.setLoading(true);
                          AuthenticationController authController = Get.find<AuthenticationController>();
                          await authController.SignInWithGoogle();
                          _commonController.setLoading(false);

                      },
                      child: Container(
                        height: 55,
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.yellowAccent,width: 2,)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("ContinueWithGoogle".tr,style: TextStyle(color: Colors.black,fontSize: 22),),
                            SizedBox(width: 10,),
                            Image.asset('assets/images/google.png',width: 40,height: 40,),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 30,),
                    Text("NeedHelp".tr,style: TextStyle(color: Colors.white54),),

                    SizedBox(height: 30,),
                    Text("NewSignUpNow".tr,style: TextStyle(color: Colors.white70),),

                    SizedBox(height: 30,),
                    Text("Recaptchas".tr,style: TextStyle(color: Colors.white12),textAlign: TextAlign.center,),


                   ],
                ).marginSymmetric(horizontal: 15),
                GetBuilder<CommonController>(builder: (controller) {
                  return Visibility(
                    visible: controller.isLoading,
                      child: LoadingAnimation());
                },)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
