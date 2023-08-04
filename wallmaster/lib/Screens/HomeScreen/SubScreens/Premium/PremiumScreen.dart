import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallmaster/Controllers/CommonController.dart';
import 'package:wallmaster/CustomWidgets/PremiumWidget.dart';

import '../../../../../Constants/AppColors.dart';
import '../../../../Controllers/AuthenticationController.dart';
import '../../../../CustomWidgets/LoadingAnimation.dart';
import '../../../../Model/GetProductModel.dart';
import '../../../Download/SetWallpaper/SetWallpaperScreen.dart';
import '../Drawer/PremiumPackages/PremiumPackage.dart';

class PremiumScreen extends StatefulWidget {
   PremiumScreen({super.key});

  @override
  State<PremiumScreen> createState() => _PremiumScreenState();
}

class _PremiumScreenState extends State<PremiumScreen> {

  // List<String> premiumList = ['Abstract','Animals','Artistic','Astronomy','Autumn','Babies & Kids','Birds','Abstract','Animals','Artistic','Astronomy','Autumn','Babies & Kids','Birds','Abstract','Animals','Artistic','Astronomy','Autumn','Babies & Kids','Birds'];
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: AppColors.black,
          body: GetBuilder<CommonController>(builder: (controller) {
            return (controller.premiumProductData?.length==0||controller.premiumProductData?.length==null)
                ?Center(child: Text("No wallpaper available",style: TextStyle(color: AppColors.white,fontSize: 18),),)
                :GridView.builder(
              shrinkWrap: true,
              primary: true,
              itemCount: controller.premiumProductData!.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 1.0,
                mainAxisSpacing: 3.0,
                mainAxisExtent: 230,
                crossAxisCount: 3,),
              itemBuilder: (context, index) {
                return InkWell(
                    onTap: () async {
                      CommonController commonController = Get.find<CommonController>();
                      commonController.setLoading(true);
                      AuthenticationController authController = Get.find<AuthenticationController>();
                      if(authController.myUser!.data!.isPremium ==0 ||authController.myUser!.data!.isPremium ==null){
                        showDialog(context: context, builder: (context) {
                          return AlertDialog(
                            title: Text('You are not a premium member'),
                            backgroundColor: AppColors.white,
                            elevation: 3,
                            content: Text("If you want to view wallpaper"),
                            actions: [
                              InkWell(
                                  onTap: () async {
                                    commonController.setLoading(true);
                                    List<ProductData> data =[];
                                    Navigator.pop(context);
                                    data.add(controller.premiumProductData![index]);
                                    await commonController.getReliventData(data);
                                    await commonController.showRewardedAd(controller.premiumProductData![index],true,);
                                    commonController.setLoading(false);

                                    // Get.to(()=>SetWallpaperScreen(widget.wallpaper,true));
                                  },
                                  child: Text("View Ad",style: TextStyle(color: Colors.blue),)),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.red),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    Get.to(()=>PremiumPackage());

                                  }, child: Text('Buy Premium',style: TextStyle(color: AppColors.white),))
                            ],
                          );
                        },);

                        commonController.setLoading(false);
                      }
                      else{
                        commonController.setLoading(false);
                        Get.to(()=>SetWallpaperScreen(controller.premiumProductData![index],true));
                        List<ProductData> data =[];
                        data!.add(controller.premiumProductData![index]);
                        await commonController.getReliventData(data);
                      }
                    },
                    child: PremiumWidget(controller.premiumProductData![index]));

              },).marginSymmetric(horizontal: 3);
          },)
        ),

        GetBuilder<CommonController>(builder: (controller) {
          return Visibility(
              visible: controller.isLoading,
              child: LoadingAnimation());
        },)
      ],
    );
  }
}
