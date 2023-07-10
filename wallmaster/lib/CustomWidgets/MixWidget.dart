import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:wallmaster/Controllers/CommonController.dart';
import 'package:wallmaster/Screens/Download/SetWallpaper/SetWallpaperScreen.dart';
import '../Constants/AppColors.dart';
import '../Model/GetProductModel.dart';


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
        await commonController.setLoading(true);
        List<ProductData> data =[];
        data!.add(widget._productData);
        await commonController.getReliventData(data);
        await commonController.addColor();
        await commonController.setCount();
        await commonController.setLoading(false);
        Get.to(()=>SetWallpaperScreen(widget._productData,true));

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
                borderRadius: BorderRadius.circular(10),
                // image: DecorationImage(
                //     image: NetworkImage(widget._productData!.image.toString()),
                //     fit: BoxFit.fill
                // ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: FadeInImage(
                  height: 280,
                    width: MediaQuery.of(context).size.width,
                    placeholder: const AssetImage("assets/images/modified_logo.png"),
                    image: NetworkImage(widget._productData!.image.toString()),
                  fit: BoxFit.fill,
                ),
              ),
            ).marginSymmetric(horizontal: 5,vertical: 5),

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