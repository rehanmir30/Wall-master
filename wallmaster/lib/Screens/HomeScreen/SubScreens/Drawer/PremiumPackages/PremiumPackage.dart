import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:wallmaster/Controllers/AuthenticationController.dart';
import 'package:wallmaster/Controllers/CommonController.dart';
import 'package:wallmaster/CustomWidgets/CustomSnackbar.dart';
import 'package:wallmaster/Screens/HomeScreen/SubScreens/Drawer/TermsAndCondtions/TermsAndCondtions.dart';
import 'package:wallmaster/Screens/Payment/paymentConfig.dart';
import 'package:pay/pay.dart';
import 'package:wallmaster/Constants/AppColors.dart';

import '../../../../../Controllers/LocalizationController.dart';
class PremiumPackage extends StatefulWidget {
  const PremiumPackage({super.key});

  @override
  State<PremiumPackage> createState() => _PremiumPackageState();
}

class _PremiumPackageState extends State<PremiumPackage> {
  String os = Platform.operatingSystem;
  var applePayButton = ApplePayButton(
    paymentConfiguration: PaymentConfiguration.fromJsonString(defaultApplePay),
      onPaymentResult: (result) {
      debugPrint('Payment Result $result');
      },
    loadingIndicator: const Center(child: CircularProgressIndicator(),),
      paymentItems: [
        PaymentItem(
            amount: '6.99',
            label: 'Premium Package',
          status: PaymentItemStatus.final_price,
        ),
      ],
    style: ApplePayButtonStyle.automatic,
    width: double.infinity,
    height: 50,

  );

  var googlePayButton = GooglePayButton(
    paymentConfiguration: PaymentConfiguration.fromJsonString(defaultGooglePay),

    onError: (error) {
      print("ERROR: "+error.toString());
      CustomSnackbar.show("$error", AppColors.red);
    },
    onPaymentResult: (result) async {
      print("RESULT: ${result}");
      CommonController commonController = Get.find<CommonController>();
      await commonController.buyPremium();
      CustomSnackbar.show("You have Successfully purchased Premium", AppColors.green);


  }, paymentItems: const [
    PaymentItem(
        amount: '6.99',
        status: PaymentItemStatus.final_price,
        label: 'Premium Package',
    )
  ],
    width: double.infinity,
    type: GooglePayButtonType.pay,
    loadingIndicator: const Center(child: CircularProgressIndicator(),),
  );

  bool agreement= false;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CommonController>(builder: (commonControlller) {
      return Scaffold(
        backgroundColor: AppColors.black,
        appBar: AppBar(
          backgroundColor: AppColors.black,
          elevation: 0,
          leading: InkWell(
              onTap: (){
                Get.back();
              },
              child: Icon(Icons.arrow_back_ios_new_rounded,color: Colors.white,size: 20,)),

          title: Text("BuyPremium".tr),
          centerTitle: true,
        ),

        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 50,),
              Align(
                alignment: Alignment.center,
                child: CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.red,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.black,
                      image: DecorationImage(
                        image:  AssetImage("assets/images/modified_logo.png"),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10,),

              Align(
                  alignment: Alignment.center,
                  child: Text("WallMaster".tr,style: TextStyle(color: Colors.white,fontSize: 28),)),
              SizedBox(height: 40,),

              Text("Elevate".tr,style: TextStyle(fontSize: 14,color: Colors.white),),
              SizedBox(height: 10,),

              Text("Navigate".tr,style: TextStyle(fontSize: 14,color: Colors.white),),
              SizedBox(height: 10,),

              Text("top_tier".tr,style: TextStyle(fontSize: 14,color: Colors.white),),
              SizedBox(height: 10,),


              Text("youget".tr,style: TextStyle(color: Colors.yellowAccent,fontWeight: FontWeight.bold,fontSize: 29),),
              SizedBox(height: 10,),
              Row(
                children: [
                  // Icon(Icons.done_sharp,color: Colors.greenAccent,size: 18,),
                  Image.asset('assets/images/check_mark.png',width: 20,height: 20,fit: BoxFit.fill,),
                  SizedBox(width: 2,),
                  Text("Access".tr,style: TextStyle(color: Colors.white,fontSize: 18),),
                ],),
              Row(
                children: [
                  // Icon(Icons.done_outlined,color: Colors.greenAccent,size: 18,),
                  Image.asset('assets/images/check_mark.png',width: 20,height: 20,fit: BoxFit.fill,),
                  SizedBox(width: 2,),
                  Text("ExclusivePremium".tr,style: TextStyle(color: Colors.white,fontSize: 18),),
                ],),
              Row(
                children: [
                  // Icon(Icons.done_outlined,color: Colors.greenAccent,size: 18,),
                  Image.asset('assets/images/check_mark.png',width: 20,height: 20,fit: BoxFit.fill,),
                  SizedBox(width: 2,),
                  Text("NoAd".tr,style: TextStyle(color: Colors.white,fontSize: 18),),
                ],),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Icon(Icons.done_outlined,color: Colors.greenAccent,size: 18,),
                  Image.asset('assets/images/check_mark.png',width: 20,height: 20,fit: BoxFit.fill,),
                  SizedBox(width: 2,),
                  Expanded(child: Text("AutomticCategory".tr,style: TextStyle(color: Colors.white,fontSize: 18),)),
                ],),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Icon(Icons.done_outlined,color: Colors.greenAccent,size: 18,),
                  Image.asset('assets/images/check_mark.png',width: 20,height: 20,fit: BoxFit.fill,),
                  SizedBox(width: 2,),
                  Expanded(child: Text("AutomaticProduct".tr,style: TextStyle(color: Colors.white,fontSize: 18),)),
                ],),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Icon(Icons.done_outlined,color: Colors.greenAccent,size: 18,),
                  Image.asset('assets/images/check_mark.png',width: 20,height: 20,fit: BoxFit.fill,),
                  SizedBox(width: 2,),
                  Expanded(child: Text("TotalControl".tr,style: TextStyle(color: Colors.white,fontSize: 18,),maxLines: null,)),
                ],),

              SizedBox(height: 10,),

              Text("ForPrice".tr,style: TextStyle(fontSize: 14,color: Colors.white),),
              Text("ForPrice".tr,style: TextStyle(fontSize: 14,color: Colors.white),),
              SizedBox(height: 5,),
              GetBuilder<Localization>(builder: (controller) {
                return Align(
                    alignment: Alignment.center,
                    child: Image.asset((controller.dropdownValue['name']=='English')?"assets/images/borderlessOfferEnglish.png":"assets/images/borderlessOfferSpanish.png",width: MediaQuery.of(context).size.width*0.60,));
              },),



              // SizedBox(height: 10,),
              if(Get.find<AuthenticationController>().myUser?.data!.isPremium ==0)
                Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [

                  Checkbox(
                      activeColor: AppColors.red,
                      // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      checkColor: Colors.white,
                      // fillColor: MaterialStatePropertyAll(Colors.white),
                      overlayColor: MaterialStatePropertyAll(Colors.white),
                      side: BorderSide(
                        color: Colors.white, // Change the checkbox border color
                        width: 2.0, // Adjust the border width as desired
                      ),

                      value: agreement, onChanged: (val){
                    setState(() {
                      agreement =val!;
                    });

                  }),

                  RichText(
                    text: TextSpan(
                      text: 'Iagreeto'.tr,
                      style: TextStyle(color: Colors.white,fontSize: 14),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'termsandconditions'.tr,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Get.to(()=>TermsAndCondtions());
                              // launch('https://example.com/terms'); // Replace with your terms and conditions URL
                            },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10,),

              (Get.find<AuthenticationController>().myUser?.data!.isPremium ==1)
                  ?InkWell(
                onTap: (){
                  // CustomSnackbar.show("Please select the checkbox", AppColors.red);
                },
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width*0.9,
                  height: 55,
                  decoration: BoxDecoration(
                      color:Colors.transparent,borderRadius: BorderRadius.circular(20),
                    border: Border.all(width: 1,color: AppColors.white)
                  ),
                  child: Text("AlreadySubscribed".tr,style: TextStyle(color: Colors.white,fontSize: 18),),
                ),
              )
                  :(agreement)
                  ?InkWell(
                onTap: ()async{
                  await commonControlller.setLoading(true);
                  print("CLICKED");
                  commonControlller.startPayamentProcess();
                  // commonControlller.inApEngine.handlePurchase(commonControlller.subscriptions[0], commonControlller.storeProductIds);
                  await commonControlller.setLoading(false);
                  
                },
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width*0.9,
                  height: 50,
                  decoration: BoxDecoration(color: AppColors.red,borderRadius: BorderRadius.circular(10)),
                  child: Text("BuyNow".tr,style: TextStyle(color: Colors.white,fontSize: 18),),
                ),
              )
                  :InkWell(
                onTap: (){
                  CustomSnackbar.show("Please select the checkbox", AppColors.red);
                },
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width*0.9,
                  height: 50,
                  decoration: BoxDecoration(color: AppColors.red.withOpacity(0.7),borderRadius: BorderRadius.circular(10)),
                  child: Text("BuyNow".tr,style: TextStyle(color: Colors.white,fontSize: 18),),
                ),
              ),

              SizedBox(height: 20,),


            ],).marginSymmetric(horizontal: 15),
        ),

      );
    },);
  }
}
