import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../../../Constants/AppColors.dart';
import '../../../../../Controllers/CommonController.dart';
import '../../../../CustomWidgets/MixWidget.dart';
import '../../../../Model/CategoryModel.dart';

class RelatedCategoryScreen extends StatefulWidget {
  CategoryModel _categoryModel;
   RelatedCategoryScreen(this._categoryModel,{super.key});

  @override
  State<RelatedCategoryScreen> createState() => _RelatedCategoryScreenState();
}

class _RelatedCategoryScreenState extends State<RelatedCategoryScreen> {

  CommonController commonController = Get.find<CommonController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: InkWell(
            onTap: (){
              Get.back();
            },
            child: Icon(Icons.arrow_back_ios_new_rounded,size: 24,color: AppColors.white,)),
        backgroundColor: AppColors.black,
        elevation: 0,
        title: Text("${widget._categoryModel.name}",style: TextStyle(color: AppColors.white),),
        centerTitle: true,
      ),

      body: GetBuilder<CommonController>(builder: (controller) {
            return (controller.productData!.length==0||controller.productData!.length==null)
                ?Center(child: Text("No wallpaper found",style: TextStyle(color: AppColors.white),),)
                :GridView.builder(
              shrinkWrap: true,
              primary: true,
              itemCount: controller.productData!.length + (controller.productData!.length ~/ 5),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 1.0,
                mainAxisSpacing: 1.0,
                mainAxisExtent: 230,
                crossAxisCount: 3,
              ),
              itemBuilder: (context, index) {
                if (index % 6 == 5 && index != 0) {
                  final adIndex = (index ~/ 6) * 5;
                  return Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    height: 280,
                    decoration: BoxDecoration(
                      color: AppColors.black,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: AdWidget(ad: commonController.nativeAdList![adIndex]..load()),
                    ),
                  ).marginSymmetric(horizontal: 0, vertical: 0);

                }
                else {
                  final productIndex = index - (index ~/ 6);
                  return MixWidget(controller.productData![productIndex]);
                }
              },
            ).marginSymmetric(horizontal: 5);
          },),


    );
  }
}
