import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wall_master_admin/Views/Screens/HomeScreen/SubScreens/CategoryScreens/PreviewWallpaper.dart';

import '../Constants/AppColors.dart';
import '../Models/GetProductModel.dart';

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
      onTap: (){
        Get.to(()=>PreviewWallpaper(widget._productData));
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
                color: AppColors.red,
                borderRadius: BorderRadius.circular(6),
                image: DecorationImage(
                    image: NetworkImage(widget._productData!.image.toString()),
                    fit: BoxFit.fill
                ),
              ),
              // child: Text(widget.wallpaper.toString()),
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
