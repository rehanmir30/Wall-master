import 'package:cached_network_image/cached_network_image.dart';
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
          // image: DecorationImage(
          //   fit: BoxFit.fill,
          //   // image: NetworkImage(widget.categoryModel!.data![widget.index].image.toString()),
          //   // image: FadeInImage(image: CachedNetworkImageProvider(), placeholder: ,),
          // ),
          color: Colors.black,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: FadeInImage(
                height: 280,
                width: MediaQuery.of(context).size.width,
                placeholder:  const AssetImage("assets/images/circle_logo.png"),
                image: CachedNetworkImageProvider(widget.categoryModel!.data![widget.index].image.toString()),
                fit: BoxFit.fill,
                placeholderFit: BoxFit.contain,
              ),
            ),

            Text(widget.categoryModel!.data![widget.index].name.toString(),style: TextStyle(color: AppColors.white,fontSize: 20,fontFamily: 'agency',letterSpacing: 2.0,),),

          ],
        ),
        // child: Text(widget.categoryModel!.data![widget.index].name.toString(),style: TextStyle(color: AppColors.white,fontSize: 20,fontFamily: 'agency',letterSpacing: 2.0,),),
      ).marginSymmetric(vertical: 2,horizontal: 2),
    );
  }
}
