import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallmaster/Constants/AppColors.dart';
import 'package:wallmaster/Controllers/CommonController.dart';
import 'package:wallmaster/CustomWidgets/CategoryWidget.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  CommonController commonController = Get.find<CommonController>();

  // List<String> categoryList = ['Abstract','Animals','Artistic','Astronomy','Autumn','Babies & Kids','Birds'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: GetBuilder<CommonController>(builder: (controller) {

        return GridView.builder(
          itemCount: controller.categoryModelList!.data!.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 3,
                mainAxisExtent: 180
            ), itemBuilder: (context, index) {
              return CategoryWidget(controller.categoryModelList!, index);
            },);

        // return ListView.builder(
        //   shrinkWrap: true,
        //   primary: false,
        //   itemCount: controller.categoryModelList!.data!.length,
        //   itemBuilder: (context, index) {
        //     return CategoryWidget(controller.categoryModelList!,index);
        //
        //   },);
      },).marginSymmetric(horizontal: 10),
    );
  }
}
