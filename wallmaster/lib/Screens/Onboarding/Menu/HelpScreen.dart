import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Constants/AppColors.dart';


class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        title:  Text('Helped'.tr!),
        centerTitle: true,
        backgroundColor: AppColors.black,
      ),

      body: SingleChildScrollView(
          child: Column(
            children: [

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(width: 10,height: 10,decoration: BoxDecoration(color: Colors.white,shape: BoxShape.circle),).marginOnly(top: 3),
                  SizedBox(width: 5,),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        text: 'HowToDownloadWallpaper'.tr,
                        style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.bold),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'HowToDownloadWallpaperDescription'.tr,
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.white,
                              fontWeight: FontWeight.normal,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // Get.to(()=>TermsAndCondtions());
                                // launch('https://example.com/terms'); // Replace with your terms and conditions URL
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5,),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(width: 10,height: 10,decoration: BoxDecoration(color: Colors.white,shape: BoxShape.circle),).marginOnly(top: 3),
                  SizedBox(width: 5,),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        text: 'HowToSetWallpaper'.tr,
                        style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.bold),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'HowToSetWallpaperDescription'.tr,
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.white,
                              fontWeight: FontWeight.normal,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // Get.to(()=>TermsAndCondtions());
                                // launch('https://example.com/terms'); // Replace with your terms and conditions URL
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5,),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(width: 10,height: 10,decoration: BoxDecoration(color: Colors.white,shape: BoxShape.circle),).marginOnly(top: 3),
                  SizedBox(width: 5,),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        text: 'HowToBecomePremium'.tr,
                        style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.bold),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'HowToBecomePremiumDescription'.tr,
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.white,
                              fontWeight: FontWeight.normal,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // Get.to(()=>TermsAndCondtions());
                                // launch('https://example.com/terms'); // Replace with your terms and conditions URL
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5,),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(width: 10,height: 10,decoration: BoxDecoration(color: Colors.white,shape: BoxShape.circle),).marginOnly(top: 3),
                  SizedBox(width: 5,),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        text: 'HowToUseAppWithoutSubscription'.tr,
                        style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.bold),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'HowToUseAppWithoutSubscriptionDescription'.tr,
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.white,
                              fontWeight: FontWeight.normal,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // Get.to(()=>TermsAndCondtions());
                                // launch('https://example.com/terms'); // Replace with your terms and conditions URL
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5,),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(width: 10,height: 10,decoration: BoxDecoration(color: Colors.white,shape: BoxShape.circle),).marginOnly(top: 3),
                  SizedBox(width: 5,),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        text: 'HowToContactSupport'.tr,
                        style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.bold),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'HowToContactSupportDescription'.tr,
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.white,
                              fontWeight: FontWeight.normal,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // Get.to(()=>TermsAndCondtions());
                                // launch('https://example.com/terms'); // Replace with your terms and conditions URL
                              },
                          ),

                          TextSpan(
                            text: 'email'.tr,
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.red,
                              fontWeight: FontWeight.normal,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // Get.to(()=>TermsAndCondtions());
                                // launch('https://example.com/terms'); // Replace with your terms and conditions URL
                              },
                          ),

                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5,),


            ],) .marginSymmetric(horizontal: 10)
      ),
    );
  }
}
