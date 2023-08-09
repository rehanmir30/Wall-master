import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wallmaster/Controllers/AuthenticationController.dart';
import 'package:wallmaster/Controllers/CommonController.dart';
import 'package:wallmaster/CustomWidgets/LoadingAnimation.dart';
import 'package:wallmaster/Screens/auth/LoginScreen.dart';

import '../../Constants/AppColors.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  Color colos2 = Colors.brown;
  Color colos = Colors.white24;
  bool nameClicked = false;
  bool emailClicked = false;
  bool passClicked = false;
  bool cPassClicked = false;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  CommonController _commonController = Get.find<CommonController>();

  File? _image;
  // Pick an image.
  Future<void> _selectImage() async {
    final ImagePicker picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    //Profile Image Code
                    // Stack(
                    //   clipBehavior: Clip.none,
                    //   children: [
                    //     (_image==null)
                    //         ? CircleAvatar(
                    //       radius: 50.0,
                    //       backgroundColor: Colors.red,
                    //       backgroundImage: AssetImage('assets/images/profile-user.png'),
                    //       // Replace 'assets/profile_picture.png' with your own image path
                    //     )
                    //         :CircleAvatar(
                    //       radius: 50.0,
                    //       backgroundColor: Colors.red,
                    //       backgroundImage: FileImage(_image!),
                    //       // Replace 'assets/profile_picture.png' with your own image path
                    //     ),
                    //     Positioned(
                    //         bottom: 0,
                    //         right: -10,
                    //         child: InkWell(
                    //           onTap: () async {
                    //             await _selectImage();
                    //             setState(() {
                    //
                    //             });
                    //           },
                    //           child: Container(
                    //             padding: EdgeInsets.all(5),
                    //             // width: 20,
                    //             //   height: 20,
                    //               decoration: BoxDecoration(
                    //                 borderRadius: BorderRadius.circular(100),
                    //                 color: Colors.white.withOpacity(0.4)
                    //               ),
                    //               child: Icon(Icons.camera,color: Colors.white,size: 24,)),
                    //         )),
                    //   ],
                    // ),
                    SizedBox(height: 16.0),
                    Container(
                      padding: EdgeInsets.all(15),
                      width: MediaQuery.of(context).size.width,
                      height: 60,
                      decoration: BoxDecoration(
                        color: (nameClicked)?colos2:colos,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextFormField(
                        controller: nameController,
                        onTap: (){
                          setState(() {
                            nameClicked = true;
                            emailClicked = false;
                            passClicked= false;
                            cPassClicked= false;
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
                            labelText: "Name".tr,
                            labelStyle: TextStyle(color: Colors.white)
                        ),
                      ),
                    ),
                    SizedBox(height: 16.0),
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
                            nameClicked = false;
                            emailClicked = true;
                            passClicked= false;
                            cPassClicked= false;
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
                    SizedBox(height: 16.0),
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
                            nameClicked = false;
                            emailClicked = false;
                            passClicked= true;
                            cPassClicked= false;
                          });
                        },
                        cursorColor: AppColors.red,
                        style: TextStyle(color: Colors.white),
                        obscureText: _obscurePassword,
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword ? Icons.visibility : Icons.visibility_off,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                            ),
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
                    SizedBox(height: 16.0),
                    Container(
                      padding: EdgeInsets.all(15),
                      width: MediaQuery.of(context).size.width,
                      height: 60,
                      decoration: BoxDecoration(
                        color: (cPassClicked)?colos2:colos,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextFormField(
                        controller: confirmPasswordController,
                        // validator: (conf){
                        //   if(confirmPasswordController.text!=passwordController.text){
                        //     return "Password not matches";
                        //   }
                        // },
                        onTap: (){
                          setState(() {
                            nameClicked = false;
                            emailClicked = false;
                            passClicked= false;
                            cPassClicked= true;
                          });
                        },
                        cursorColor: AppColors.red,
                        style: TextStyle(color: Colors.white),
                        obscureText: _obscureConfirmPassword,
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscureConfirmPassword ? Icons.visibility : Icons.visibility_off,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscureConfirmPassword = !_obscureConfirmPassword;
                                });
                              },
                            ),
                            contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            labelText: "ConfirmPassword".tr,
                            labelStyle: TextStyle(color: Colors.white)
                        ),
                      ),
                    ),
                    SizedBox(height: 26.0),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: AppColors.red),
                        onPressed: () async {

                           FocusNode().unfocus();
                           setState(() {
                             nameClicked = false;
                             emailClicked = false;
                             passClicked = false;
                             cPassClicked = false;
                           });
                           if(confirmPasswordController.text!=passwordController.text){
                             Get.snackbar(
                               "PasswordDoesNotMatch".tr,
                               "",
                               snackPosition: SnackPosition.BOTTOM,
                               duration: Duration(seconds: 1),
                             );
                           }else if((nameController.text==null||nameController.text=="")||(emailController.text==null||emailController.text=="")||(passwordController.text==null||passwordController.text=="")){
                             Get.snackbar(
                               "PleaseFillAllTheFiled".tr,
                               "",
                               snackPosition: SnackPosition.BOTTOM,
                               duration: Duration(seconds: 1),
                             );
                           }
                           else{
                             _commonController.setLoading(true);
                             AuthenticationController authController = Get.find<AuthenticationController>();
                             await authController.SignUpUser(nameController.text, emailController.text, passwordController.text);
                             _commonController.setLoading(false);
                           }
                          // Handle sign up button pressed
                        },
                        child: Text('SignUp'.tr),
                      ),
                    ),

                    //signin with google
                    SizedBox(height: 25,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already have an account,",style: TextStyle(color: Colors.white),),
                        InkWell(
                            onTap: (){
                              Get.back();
                              Get.to(()=>LoginScreen());
                            },
                            child: Text(" Sign in now",style: TextStyle(color: AppColors.red),)),
                      ],
                    ),

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
                  ],
                ),

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
