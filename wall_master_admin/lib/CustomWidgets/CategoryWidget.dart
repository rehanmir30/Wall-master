import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wall_master_admin/Controllers/CommonController.dart';
import 'package:wall_master_admin/Models/CategoryModel.dart';
import 'package:wall_master_admin/Models/GetProductModel.dart';
import 'package:wall_master_admin/Views/Screens/HomeScreen/SubScreens/CategoryScreens/RelatedCategoryScreen.dart';

import '../Constants/AppColors.dart';
import '../Models/GetCategoryModel.dart';

class CategoryWidget extends StatefulWidget {
  GetCategoryModel? categoryModel;
  int index;
   CategoryWidget(this.categoryModel,this.index,{super.key});

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        CommonController commonController = Get.find<CommonController>();
        commonController.getSelectedCategoryProduct(commonController.productModelList,widget.categoryModel?.data![widget.index].id);

        Get.to(()=>RelatedCategoryScreen(CategoryModel(id:widget.categoryModel?.data![widget.index].id,name: widget.categoryModel?.data![widget.index].name,image: widget.categoryModel?.data![widget.index].image)));
      },
      child: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        height: 200,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: NetworkImage(widget.categoryModel!.data![widget.index].image.toString()),
          ),
          color: Colors.red,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(widget.categoryModel!.data![widget.index].name.toString(),style: TextStyle(color: AppColors.white,fontSize: 18),),
      ).marginSymmetric(vertical: 5),
    );
  }
}
