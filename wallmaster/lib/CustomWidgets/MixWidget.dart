import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:wallmaster/Controllers/AuthenticationController.dart';
import 'package:wallmaster/Controllers/CommonController.dart';
import 'package:wallmaster/Screens/Download/SetWallpaper/SetWallpaperScreen.dart';
import '../Constants/AppColors.dart';
import '../Model/GetProductModel.dart';
import '../Screens/HomeScreen/SubScreens/Drawer/PremiumPackages/PremiumPackage.dart';


class MixWidget extends StatefulWidget {
  ProductData _productData;
   MixWidget(this._productData,{super.key});

  @override
  State<MixWidget> createState() => _MixWidgetState();
}

class _MixWidgetState extends State<MixWidget> {
  CommonController myController = Get.find<CommonController>();
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        CommonController commonController = Get.find<CommonController>();
        commonController.setLoading(true);
        AuthenticationController authenticationController = Get.find<AuthenticationController>();
        if(widget._productData.forPremium ==1){
          if(authenticationController.myUser!.data!.isPremimum==0 || authenticationController.myUser!.data!.isPremimum==null){
            commonController.setLoading(false);
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
                        data.add(widget._productData);
                        await commonController.getReliventData(data);
                        await commonController.showRewardedAd(widget._productData,true,);
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

          }
          else{
            CommonController commonController = Get.find<CommonController>();
            // await commonController.setLoading(true);
            List<ProductData> data =[];
            data!.add(widget._productData);
            await commonController.getReliventData(data);
            await commonController.addColor();
            await commonController.setCount();
            await commonController.setLoading(false);
            Get.to(()=>SetWallpaperScreen(widget._productData,true));
          }

        }else{
          CommonController commonController = Get.find<CommonController>();
          await commonController.setLoading(true);
          List<ProductData> data =[];
          data!.add(widget._productData);
          await commonController.getReliventData(data);
          await commonController.addColor();
          await commonController.setCount();
          await commonController.setLoading(false);
          Get.to(()=>SetWallpaperScreen(widget._productData,true));
        }

      },
      child: Container(
        height: 280,
        decoration: BoxDecoration(
          // border: Border.all(color: Colors.white,width: 1,),
          ),

        child: Stack(
          children: [
            Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              height: 280,
              decoration: BoxDecoration(
                color: AppColors.black,
                borderRadius: BorderRadius.circular(6),
                // image: DecorationImage(
                //     image: NetworkImage(widget._productData!.image.toString()),
                //     fit: BoxFit.fill
                // ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: FadeInImage(
                  height: 280,
                    width: MediaQuery.of(context).size.width,
                    placeholder: const AssetImage("assets/images/modified_logo.png"),
                    image: NetworkImage(widget._productData!.image.toString()),
                  fit: BoxFit.fill,
                ),
              ),
            ).marginSymmetric(horizontal: 2,vertical: 2),

            if(widget._productData!.forPremium!=0)Positioned(
              right: 15,
              top: 10,
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 10,
                child: Icon(Icons.workspace_premium_outlined,color: Colors.white,),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
