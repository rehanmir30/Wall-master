import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:wall_master_admin/Constants/AppColors.dart';
import 'package:wall_master_admin/Controllers/CommonController.dart';
import 'package:wall_master_admin/CustomWidgets/CategoryWidget.dart';
import 'package:wall_master_admin/Views/Screens/HomeScreen/SubScreens/AddScreens/AddNewScreen.dart';

import '../CRUDCategory/NewCategoryScreen.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {

  CommonController commonController = Get.find<CommonController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.black,
        elevation: 0,
        title: Text("Categories".tr,style: TextStyle(color: AppColors.white),),
        centerTitle: true,
      ),

      body: Container(
        color: AppColors.black,
        child: Column(
          children: [
            (commonController.categoryModelList?.data!.length==0 ||commonController.categoryModelList?.data!.length==null)
                ?Center(child: Text("NoCategoryAvailable".tr,style: TextStyle(color: AppColors.white)),)
                :Expanded(
              child: GridView.builder(
                itemCount: commonController.categoryModelList?.data!.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    // childAspectRatio: 200,
                    crossAxisSpacing: 0,
                    mainAxisSpacing: 0,
                    mainAxisExtent: 180),
                itemBuilder: (context, index) {
                  return CategoryWidget(commonController.categoryModelList,index);

              },),
            ),
          ],
        ).marginSymmetric(horizontal: 3),
      ),

      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.red,
          onPressed: () {
          Get.to(()=>NewCategoryScreen());
      }, label: Row(
        children: [
          Icon(Icons.add,color: Colors.white,),
          Text("AddCategory".tr)
        ],
      )),

    );
  }
}
