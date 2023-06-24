import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallmaster/Controllers/CommonController.dart';
import 'package:wallmaster/CustomWidgets/PremiumWidget.dart';

import '../../../../../Constants/AppColors.dart';

class PremiumScreen extends StatefulWidget {
   PremiumScreen({super.key});

  @override
  State<PremiumScreen> createState() => _PremiumScreenState();
}

class _PremiumScreenState extends State<PremiumScreen> {

  // List<String> premiumList = ['Abstract','Animals','Artistic','Astronomy','Autumn','Babies & Kids','Birds','Abstract','Animals','Artistic','Astronomy','Autumn','Babies & Kids','Birds','Abstract','Animals','Artistic','Astronomy','Autumn','Babies & Kids','Birds'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: GetBuilder<CommonController>(builder: (controller) {
        return (controller.premiumProductData?.length==0||controller.premiumProductData?.length==null)
            ?Center(child: Text("No wallpaper available",style: TextStyle(color: AppColors.white,fontSize: 18),),)
            :GridView.builder(
          shrinkWrap: true,
          primary: true,
          itemCount: controller.premiumProductData!.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            // crossAxisSpacing: 10.0,
              mainAxisSpacing: 1.0,
              mainAxisExtent: 300,
              crossAxisCount: 2),
          itemBuilder: (context, index) {
            return PremiumWidget(controller.premiumProductData![index]);

          },).marginSymmetric(horizontal: 10);
      },)
    );
  }
}
