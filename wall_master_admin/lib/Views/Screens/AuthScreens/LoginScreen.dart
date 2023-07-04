import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wall_master_admin/Controllers/AuthenticationController.dart';
import 'package:wall_master_admin/Controllers/CommonController.dart';
import 'package:wall_master_admin/CustomWidgets/CustomSnackbar.dart';
import 'package:wall_master_admin/CustomWidgets/LoadingAnimation.dart';

import '../../../Constants/AppColors.dart';
import '../../../Controllers/LocalizationController.dart';
import '../../../CustomWidgets/MyAlertDialog.dart';
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
  
  final _formKey  = GlobalKey<FormState>();
  
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  CommonController _commonController = Get.find<CommonController>();
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.black,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors.black,
          title: Text("AppName".tr,style: TextStyle(color: AppColors.red,letterSpacing: 2),),
          // leading: InkWell(
          //     onTap: (){
          //       Get.back();
          //     },
          //     child: Icon(Icons.arrow_back,color: Colors.white,size: 24,)),

          actions: [
            Image.asset("assets/images/logo.png",width: 35,height:35,).marginOnly(right: 10),
          ],

        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 70,),
                    Text("AdminAccount".tr,style: TextStyle(letterSpacing: 2,color: Colors.white,fontSize: 25),),
                    SizedBox(height: 50,),

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
                        controller: passwordController,
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
                        
                        if(_formKey.currentState!.validate()){
                          
                          if((emailController.text==null||emailController.text=="")||(passwordController.text==null||passwordController.text=="")){
                            CustomSnackbar.show("PleaseFillAllFields".tr, AppColors.red);
                          }else{
                            _commonController.setLoading(true);
                            AuthenticationController authController = Get.find<AuthenticationController>();
                            await authController.signIn(emailController.text, passwordController.text);
                            _commonController.setLoading(false);
                          }
                          
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
                        child: Text("Sigin".tr,style: TextStyle(color: Colors.white),),
                      ),
                    ),

                    SizedBox(height: 35,),
                    GetBuilder<Localization>(builder: (controller) {
                      return InkWell(
                          onTap: (){
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return MyAlertDialog();
                              },
                            );
                          },
                          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Text(controller.dropdownValue['name'].toString(),style: TextStyle(color: Colors.white,fontSize: 16),),Icon(Icons.arrow_drop_down_sharp,color: AppColors.white,size: 30,)],));
                    },),

                    // SizedBox(height: 30,),
                    // Text("Need help?",style: TextStyle(color: Colors.white54),),
                    //
                    // SizedBox(height: 30,),
                    // Text("New to Wall Master? Sign up now",style: TextStyle(color: Colors.white70),),
                    //
                    // SizedBox(height: 30,),
                    // Text("Sign in is protected by Google reCAPTCHA to ensure you're not a bot.",style: TextStyle(color: Colors.white12),textAlign: TextAlign.center,),


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
