import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallmaster/Model/LikedWallpaperModel.dart';
import 'package:wallmaster/Screens/Download/SetWallpaper/SetWallpaperScreen.dart';
import '../Constants/AppColors.dart';
import '../Controllers/AuthenticationController.dart';
import '../Controllers/CommonController.dart';
import '../Model/GetProductModel.dart';


class LikeWidget extends StatefulWidget {
  LikeProductData _productData;
  LikeWidget(this._productData,{super.key});

  @override
  State<LikeWidget> createState() => _LikeWidgetState();
}

class _LikeWidgetState extends State<LikeWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Get.to(()=>SetWallpaperScreen(widget._productData, false));

      },
      child: Container(
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
                  image: NetworkImage(widget._productData!.image.toString()),
                  fit: BoxFit.fill,
                  placeholderFit: BoxFit.contain,
                ),
              ),
            ).marginSymmetric(horizontal: 1,vertical: 1),

            if(widget._productData!.forPremium!=0)Positioned(
              right: 15,
              top: 10,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
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
      ),
    );
  }
}
