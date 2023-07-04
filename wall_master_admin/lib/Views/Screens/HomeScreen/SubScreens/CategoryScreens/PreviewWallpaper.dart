import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:wall_master_admin/Models/GetProductModel.dart';
import 'package:wall_master_admin/Views/Screens/HomeScreen/SubScreens/AddScreens/EditWallpaperScreen.dart';

import '../../../../../Constants/AppColors.dart';
import '../../../../../Controllers/CommonController.dart';

class PreviewWallpaper extends StatefulWidget {
  ProductData _productData;
  PreviewWallpaper(this._productData,{super.key});

  @override
  State<PreviewWallpaper> createState() => _PreviewWallpaperState();
}

class _PreviewWallpaperState extends State<PreviewWallpaper> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: AppColors.black.withOpacity(0.2),
        title: Text("WallpaperPreview".tr),
        centerTitle: true,
        leading: InkWell(
            onTap: (){
              Get.back();
            },
            child: Icon(Icons.arrow_back_ios_new_rounded,color: AppColors.white,size: 24,)),
        actions: [

          // InkWell(
          //   onTap: (){
          //     Get.to(()=>EditWallpaperScreen(widget._productData));
          //   },
          //   child: Row(
          //     children: [
          //       Text("Edit"),
          //     ],
          //   ).marginOnly(right: 15),
          // ),

          PopupMenuButton<String>(
            color: AppColors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem<String>(
                  value: 'Edit',
                  child: Text('Edit'.tr),
                ),
                PopupMenuItem<String>(
                  value: 'Delete',
                  child: Text('Delete'.tr),
                ),
              ];
            },
            onSelected: (String value) {
              // Handle selected option
              if (value == 'Edit') {
                Get.to(()=>EditWallpaperScreen(widget._productData));
              } else if (value == 'Delete') {
                showDialog(
                  context: context,
                  barrierDismissible: false, // Prevents dialog box from closing when tapped outside
                  builder: (BuildContext context) {
                    return AlertDialog(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      backgroundColor: AppColors.black,
                      title: Text('Confirmation'.tr,style: TextStyle(color: Colors.white),),
                      content: Text('AreYouSureYouWantToDeleteTheProduct'.tr,style: TextStyle(color: Colors.white),),
                      actions: <Widget>[
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.white
                          ),
                          child: Text('Cancel'.tr,style: TextStyle(color: Colors.black),),
                          onPressed: () {
                            Navigator.of(context).pop(); // Return false when cancel button is pressed
                          },
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.red
                          ),
                          child: Text('Delete'.tr,style: TextStyle(color: Colors.white),),
                          onPressed: () async {
                            // Navigator.of(context).pop(); // Return true when delete button is pressed
                            CommonController commonController = Get.find<CommonController>();
                            await commonController.deleteProduct(widget._productData.id,widget._productData.categoryId,context);

                          },
                        ),
                      ],
                    );
                  },
                );
              }
            },
          )


        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage("${widget._productData.image}"),
            fit: BoxFit.fill,
          )
        ),
      ),
    );
  }
}

