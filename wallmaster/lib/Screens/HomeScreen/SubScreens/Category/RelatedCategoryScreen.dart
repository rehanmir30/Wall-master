import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

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
              itemCount: controller.productData!.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                // crossAxisSpacing: 10.0,
                  mainAxisSpacing: 1.0,
                  mainAxisExtent: 300,
                  crossAxisCount: 2),
              itemBuilder: (context, index) {
                return MixWidget(controller.productData![index]);

              },).marginSymmetric(horizontal: 10);
          },),


    );
  }
}
