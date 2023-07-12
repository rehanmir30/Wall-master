import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Constants/AppColors.dart';
import '../Controllers/CommonController.dart';
import '../Model/CategoryModel.dart';
import '../Model/GetCategoryModel.dart';
import '../Screens/HomeScreen/SubScreens/Category/RelatedCategoryScreen.dart';

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
      onTap: () async {
        CommonController commonController = Get.find<CommonController>();
        commonController.setCount();
        commonController.getSelectedCategoryProduct(commonController.productModelList,widget.categoryModel!.data![widget.index].id);
        Get.to(()=>RelatedCategoryScreen(CategoryModel(id:widget.categoryModel!.data![widget.index].id,name: widget.categoryModel!.data![widget.index].name,image: widget.categoryModel!.data![widget.index].image)));
      },
      child: Container(
        alignment: Alignment.center,
        // width: MediaQuery.of(context).size.width,
        width: double.infinity,
        height: 200,
        decoration: BoxDecoration(
          color: AppColors.black,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [

            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: FadeInImage(
                height: 200,
                  placeholder: AssetImage("assets/images/modified_logo.png"),
                  image: NetworkImage(widget.categoryModel!.data![widget.index].image.toString()),
                fit: BoxFit.cover,
              
              ),
            ),

            Stack(
              alignment: Alignment.center,
              children: [
                Text(widget.categoryModel!.data![widget.index].name.toString(),style: TextStyle(color: AppColors.black,fontSize: 20,fontFamily: 'impact',),),
                Text(widget.categoryModel!.data![widget.index].name.toString(),style: TextStyle(color: AppColors.white,fontSize: 18,fontFamily: 'impact',),),
              ],
            ),


          ],
        ),
      ).marginSymmetric(vertical: 5,horizontal: 0),
    );
  }
}
