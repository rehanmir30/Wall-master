import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallmaster/Controllers/AuthenticationController.dart';
import 'package:wallmaster/Model/GetProductModel.dart';
import 'package:wallmaster/Screens/HomeScreen/SubScreens/Drawer/PremiumPackages/PremiumPackage.dart';

import '../Constants/AppColors.dart';
import '../Controllers/CommonController.dart';
import '../Screens/Download/SetWallpaper/SetWallpaperScreen.dart';

class PremiumWidget extends StatefulWidget {
  ProductData wallpaper;
   PremiumWidget(this.wallpaper,{super.key});

  @override
  State<PremiumWidget> createState() => _PremiumWidgetState();
}

class _PremiumWidgetState extends State<PremiumWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280,
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
                  placeholder: AssetImage("assets/images/circle_logo.png"),
                  image: NetworkImage(widget.wallpaper.image.toString()),
                fit: BoxFit.fill,
                placeholderFit: BoxFit.contain,
              ),
            ),
          ).marginSymmetric(horizontal: 2,vertical: 2),

          Positioned(
            right: 15,
            top: 10,
            child: Column(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 10,
                  child: Icon(Icons.workspace_premium_outlined,color: Colors.white,),
                ),
                SizedBox(height: 10,),

                Container(
                  padding: EdgeInsets.symmetric(horizontal: 3,vertical: 2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Image.asset("assets/images/play.png",width: 20,height: 20,),
                ).marginOnly(left: 5)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
