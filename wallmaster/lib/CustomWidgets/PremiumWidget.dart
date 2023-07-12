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
      height: 300,
      child: Stack(
        children: [

         Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            height: 300,
            decoration: BoxDecoration(
              color: AppColors.black,
              borderRadius: BorderRadius.circular(10),
              // image: DecorationImage(
              //     image: NetworkImage(widget._productData!.image.toString()),
              //     fit: BoxFit.fill
              // ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: FadeInImage(
                height: 300,
                  width: MediaQuery.of(context).size.width,
                  placeholder: AssetImage("assets/images/modified_logo.png"),
                  image: NetworkImage(widget.wallpaper.image.toString()),
                fit: BoxFit.contain,
              ),
            ),
          ).marginSymmetric(horizontal: 0,vertical: 0),

          // Container(
          //   alignment: Alignment.center,
          //   width: MediaQuery.of(context).size.width,
          //   height: 300,
          //   decoration: BoxDecoration(
          //     color: AppColors.black,
          //     borderRadius: BorderRadius.circular(10),
          //     image: DecorationImage(
          //         image: NetworkImage(widget.wallpaper.image.toString()),
          //         fit: BoxFit.fill
          //     ),
          //   ),
          //   // child: Text(widget.wallpaper.toString()),
          // ).marginSymmetric(horizontal: 5,vertical: 5),
          Positioned(
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
    );
  }
}
