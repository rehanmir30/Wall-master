import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        CommonController commonController = Get.find<CommonController>();
        Get.to(()=>SetWallpaperScreen(widget._productData,true));
        List<ProductData> data =[];
        data!.add(widget._productData);
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
                    placeholder: AssetImage("assets/images/logo.png"),
                    image: NetworkImage(widget._productData!.image.toString()),
                  fit: BoxFit.contain,
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
