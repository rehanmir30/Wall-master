import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../Constants/AppColors.dart';
import '../Controllers/AuthenticationController.dart';
import '../Controllers/CommonController.dart';
import '../Screens/Download/SetWallpaper/SetWallpaperScreen.dart';
import '../Screens/HomeScreen/SubScreens/Drawer/PremiumPackages/PremiumPackage.dart';
import 'GetProductModel.dart';


class CategoryDeckWidget extends StatefulWidget {
  int categoryIndex;
  int prodcutIndex;

  CategoryDeckWidget(this.categoryIndex,this.prodcutIndex,{super.key});

  @override
  State<CategoryDeckWidget> createState() => _CategoryDeckWidgetState();
}

class _CategoryDeckWidgetState extends State<CategoryDeckWidget> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation=Tween<double>(begin: stackValue, end: 1.2).animate(_animationController);
  bool set =false;
  double stackValue =0.5;
  bool selection = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300), // Adjust the duration as needed
    );

    // _toggleAnimation();

  }



  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _toggleAnimation() async {
    if (_animationController.status == AnimationStatus.completed) {
      await _animationController.reverse();



      CommonController commonController = Get.find<CommonController>();
      commonController.setLoading(true);
      AuthenticationController authenticationController = Get.find<AuthenticationController>();
      if(controller?.categoryDeckList![widget.categoryIndex].wallpaperdata![widget.prodcutIndex].forPremium ==1){
        if(authenticationController.myUser!.data!.isPremium==0 || authenticationController.myUser!.data!.isPremium==null){
          commonController.setLoading(false);
          showDialog(context: context, builder: (context) {
            return AlertDialog(
              title: Text('premiummember'.tr),
              backgroundColor: AppColors.white,
              elevation: 3,
              content: Text("viewwallpaper".tr),
              actions: [
                InkWell(
                    onTap: () async {
                      commonController.setLoading(true);
                      List<ProductData> data =[];
                      Navigator.pop(context);
                      data.add(controller.categoryDeckList![widget.categoryIndex].wallpaperdata![widget.prodcutIndex]);
                      await commonController.getReliventData(data);
                      await commonController.showRewardedAd(controller.categoryDeckList![widget.categoryIndex].wallpaperdata![widget.prodcutIndex],true,);
                      commonController.setLoading(false);
                      // Get.to(()=>SetWallpaperScreen(widget.wallpaper,true));
                    },
                    child: Text("ViewAd".tr,style: TextStyle(color: Colors.blue),)),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: AppColors.red),
                    onPressed: () {
                      Navigator.of(context).pop();
                      Get.to(()=>PremiumPackage());

                    }, child: Text('BuyPremium'.tr,style: TextStyle(color: AppColors.white),))
              ],
            );
          },);

        }
        else{
          CommonController commonController = Get.find<CommonController>();
          await commonController.setLoading(true);
          List<ProductData> data =[];
          data!.add(controller.categoryDeckList![widget.categoryIndex].wallpaperdata![widget.prodcutIndex]);
          await commonController.getReliventData(data);
          await commonController.setLoading(false);
          Get.offAll(()=>SetWallpaperScreen(controller.categoryDeckList![widget.categoryIndex].wallpaperdata![widget.prodcutIndex],true));            // await commonController.setCount();


        }

      }
      else{

        if(authenticationController.myUser?.data!.isPremium ==0 || authenticationController.myUser?.data!.isPremium ==null){
          CommonController commonController = Get.find<CommonController>();
          await commonController.setLoading(true);
          List<ProductData> data =[];
          data!.add(controller.categoryDeckList![widget.categoryIndex].wallpaperdata![widget.prodcutIndex]);
          await commonController.getReliventData(data);
          await commonController.setCount();
          await commonController.setLoading(false);
          Get.to(()=>SetWallpaperScreen(controller.categoryDeckList![widget.categoryIndex].wallpaperdata![widget.prodcutIndex],true));
        }else{
          CommonController commonController = Get.find<CommonController>();
          await commonController.setLoading(true);
          List<ProductData> data =[];
          data!.add(controller.categoryDeckList![widget.categoryIndex].wallpaperdata![widget.prodcutIndex]);
          await commonController.getReliventData(data);
          await commonController.setLoading(false);
          Get.to(()=>SetWallpaperScreen(controller.categoryDeckList![widget.categoryIndex].wallpaperdata![widget.prodcutIndex],true));
        }

      }

    }
    else {
        await _animationController.forward();
        selection =true;
        // await controller.selectedImage(controller.categoryDeckList![widget.categoryIndex].wallpaperdata![widget.prodcutIndex].image.toString(),true);
        await controller.updateUI();

        await Future.delayed(Duration(milliseconds: 3000),() async {
          await _animationController.reverse();
          selection = false;
          await controller.updateUI();
        });


    }

  }

  CommonController controller = Get.find<CommonController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CommonController>(builder: (controller) {
      return InkWell(
        overlayColor: MaterialStateProperty.all(Colors.transparent),
        onTap: () async {
          await _toggleAnimation();
        },
        child: AnimatedAlign(
          alignment: Alignment.center,
          widthFactor: _animation.value,
          duration: Duration(milliseconds: 300), // Same as AnimationController duration
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                // color: AppColors.white,
                border: Border.all(color: Colors.white, width: 3),
                borderRadius: BorderRadius.circular(25),
              ),
              height: (selection==true)?230:200,
              width: (selection==true)?150:120,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: FadeInImage(
                  image: CachedNetworkImageProvider(
                      "${controller.categoryDeckList![widget.categoryIndex].wallpaperdata![widget.prodcutIndex].image}"),
                  placeholder: AssetImage('assets/images/modified_logo.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        ),
      );
    },);

  }
}
