import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallmaster/Controllers/CommonController.dart';
import 'package:wallmaster/CustomWidgets/LikeWidget.dart';
import 'package:wallmaster/CustomWidgets/MixWidget.dart';

import '../../../../../../Constants/AppColors.dart';
import '../../../../../../CustomWidgets/CommonWidget.dart';

class LikedWallpaperScreen extends StatefulWidget {
  const LikedWallpaperScreen({super.key});

  @override
  State<LikedWallpaperScreen> createState() => _LikedWallpaperScreenState();
}

class _LikedWallpaperScreenState extends State<LikedWallpaperScreen> {
  CommonController commonController = Get.find<CommonController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        backgroundColor: AppColors.black,
        elevation: 0,
        title: Text("Liked Wallpapers"),
        centerTitle: true,
        leading: InkWell(
            onTap: (){
              Get.back();
            },
            child: Icon(Icons.arrow_back_ios_new_rounded,size: 24,color: AppColors.white,)),
      ),

      body:  GetBuilder<CommonController>(builder: (controller) {
        return (controller.likedWallpaperModel!.data?.length==0 || controller.likedWallpaperModel!.data?.length==null)
            ?Center(child: Text("No wallpaper",style: TextStyle(color: AppColors.white,fontSize: 18),),)
            :GridView.builder(
          shrinkWrap: true,
          primary: true,
          itemCount: controller.likedWallpaperModel!.data!.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 1.0,
              mainAxisSpacing: 3.0,
              mainAxisExtent: 300,
              crossAxisCount: 2),
          itemBuilder: (context, index) {
            return LikeWidget(controller.likedWallpaperModel!.data![index]);

          },).marginSymmetric(horizontal: 30);
      },)
    );
  }
}
