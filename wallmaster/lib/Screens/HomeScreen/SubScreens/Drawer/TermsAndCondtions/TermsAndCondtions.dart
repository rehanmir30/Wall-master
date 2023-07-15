import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../Constants/AppColors.dart';

class TermsAndCondtions extends StatefulWidget {
  const TermsAndCondtions({super.key});

  @override
  State<TermsAndCondtions> createState() => _TermsAndCondtionsState();
}

class _TermsAndCondtionsState extends State<TermsAndCondtions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        title:  Text('termsandconditions'.tr.capitalizeFirst!),
        centerTitle: true,
        backgroundColor: AppColors.black,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(5.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16),
              Text('WallMasterTermsandConditions'.tr, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.white),),
              SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width: 4,),
                  Container(
                    alignment: Alignment.center,
                    width: 7,
                    height: 7,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.white,
                    ),
                  ),
                  SizedBox(width: 6,),
                  Text('AcceptanceofTerms'.tr, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.white),),
                ],
              ),
              SizedBox(height: 8),
              Text('ByAccessing'.tr, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.white),).marginOnly(left: 5),

              SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width: 4,),
                  Container(
                    alignment: Alignment.center,
                    width: 7,
                    height: 7,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.white,
                    ),
                  ),
                  SizedBox(width: 6,),
                  Text('Services'.tr, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.white),),
                ],
              ),
              SizedBox(height: 8),
              Text('WeProvide'.tr, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.white),).marginOnly(left: 5),

              SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width: 4,),
                  Container(
                    alignment: Alignment.center,
                    width: 7,
                    height: 7,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.white,
                    ),
                  ),
                  SizedBox(width: 6,),
                  Text('Privacy'.tr, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.white),),
                ],
              ),
              SizedBox(height: 8),
              Text('PleaseRefer'.tr, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.white),).marginOnly(left: 5),

              SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width: 4,),
                  Container(
                    alignment: Alignment.center,
                    width: 7,
                    height: 7,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.white,
                    ),
                  ),
                  SizedBox(width: 6,),
                  Text('UseLimitations'.tr, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.white),),
                ],
              ),
              SizedBox(height: 8),
              Text('YouAgree'.tr, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.white),).marginOnly(left: 5),


              SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width: 4,),
                  Container(
                    alignment: Alignment.center,
                    width: 7,
                    height: 7,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.white,
                    ),
                  ),
                  SizedBox(width: 6,),
                  Text('IntellectualProperty'.tr, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.white),),
                ],
              ),
              SizedBox(height: 8),
              Text('Allintellectual'.tr, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.white),).marginOnly(left: 5),


              SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width: 4,),
                  Container(
                    alignment: Alignment.center,
                    width: 7,
                    height: 7,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.white,
                    ),
                  ),
                  SizedBox(width: 6,),
                  Text('Changes'.tr, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.white),),
                ],
              ),
              SizedBox(height: 8),
              Text('WeReserve'.tr, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.white),).marginOnly(left: 5),


              SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width: 4,),
                  Container(
                    alignment: Alignment.center,
                    width: 7,
                    height: 7,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.white,
                    ),
                  ),
                  SizedBox(width: 6,),
                  Text('Termination'.tr, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.white),),
                ],
              ),
              SizedBox(height: 8),
              Text('Wemayterminate'.tr, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.white),).marginOnly(left: 5),


              SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width: 4,),
                  Container(
                    alignment: Alignment.center,
                    width: 7,
                    height: 7,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.white,
                    ),
                  ),
                  SizedBox(width: 6,),
                  Text('ApplicableLaw'.tr, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.white),),
                ],
              ),
              SizedBox(height: 8),
              Text('Thesetermsandconditions'.tr, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.white),).marginOnly(left: 5),


              SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width: 4,),
                  Container(
                    alignment: Alignment.center,
                    width: 7,
                    height: 7,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.white,
                    ),
                  ),
                  SizedBox(width: 6,),
                  Text('Contact'.tr, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.white),),
                ],
              ),
              SizedBox(height: 8),

              RichText(
                text: TextSpan(
                  text: 'Ifyouhave'.tr,
                  style: TextStyle(color: Colors.white,fontSize: 14),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'email'.tr,
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.red,
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

              // Wrap(
              //   direction: Axis.horizontal,
              //   children: [
              //     Text('Ifyouhave'.tr, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.white),).marginOnly(left: 5),
              //     InkWell(
              //       overlayColor: MaterialStatePropertyAll(Colors.red),
              //         onTap: (){
              //
              //         },
              //         child: Text('email'.tr, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.red),).marginOnly(left: 5)),
              //
              //   ],
              // ),




            ]),
      ),
    );
  }
}
