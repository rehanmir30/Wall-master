import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallmaster/Model/GetProductModel.dart';

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
    return InkWell(
      onTap: () async {
        CommonController commonController = Get.find<CommonController>();
        Get.to(()=>SetWallpaperScreen(widget.wallpaper,true));
        List<ProductData> data =[];
        data!.add(widget.wallpaper);
        await commonController.getReliventData(data);
      },
      child: Container(
        height: 300,
        child: Stack(
          children: [
            Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              height: 300,
              decoration: BoxDecoration(
                color: AppColors.red,
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    image: NetworkImage(widget.wallpaper.image.toString()),
                    fit: BoxFit.fill
                ),
              ),
              // child: Text(widget.wallpaper.toString()),
            ).marginSymmetric(horizontal: 5,vertical: 5),
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
      ),
    );
  }
}
