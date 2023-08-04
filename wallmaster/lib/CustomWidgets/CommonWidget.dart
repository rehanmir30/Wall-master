import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Constants/AppColors.dart';
import '../Screens/Download/SetWallpaper/SetWallpaperScreen.dart';

class CommonWidget extends StatefulWidget {
  var wallpaper;
   CommonWidget(this.wallpaper,{super.key});

  @override
  State<CommonWidget> createState() => _CommonWidgetState();
}

class _CommonWidgetState extends State<CommonWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:(){
        Get.to(()=>SetWallpaperScreen(widget.wallpaper,true));
      },
      child: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        height: 100,
        decoration: BoxDecoration(
          color: AppColors.black,
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: AssetImage(widget.wallpaper.toString()),
            fit: BoxFit.fill
          ),

        ),
        // child: Text(widget.wallpaper.toString()),
      ).marginSymmetric(horizontal: 5,vertical: 5),
    );
  }
}
