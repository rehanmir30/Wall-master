import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:wall_master_admin/CustomWidgets/LoadingAnimation.dart';
import 'package:wall_master_admin/Views/Screens/HomeScreen/SubScreens/AddScreens/AddNewScreen.dart';
import 'package:wall_master_admin/Views/Screens/HomeScreen/SubScreens/CRUDCategory/EditCategoryScreen.dart';

import '../../../../../Constants/AppColors.dart';
import '../../../../../Controllers/CommonController.dart';
import '../../../../../CustomWidgets/MixWidget.dart';
import '../../../../../Models/CategoryModel.dart';

class RelatedCategoryScreen extends StatefulWidget {
  CategoryModel _categoryModel;
   RelatedCategoryScreen(this._categoryModel,{super.key});

  @override
  State<RelatedCategoryScreen> createState() => _RelatedCategoryScreenState();
}

class _RelatedCategoryScreenState extends State<RelatedCategoryScreen> {

  CommonController commonController = Get.find<CommonController>();
  // bool multiSelectEnabled = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    commonController.clearProductUsingMultiSelect();
    commonController.setMultiSelectSupport(false,false);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CommonController>(builder: (controller) {
      return Stack(children: [
          Scaffold(
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

            actions: [
              if(controller.multiSelectEnabled)
                InkWell(
                    onTap: (){
                      commonController.setMultiSelectSupport(false,false);
                      commonController.clearProductUsingMultiSelect();
                    },
                    child: Container(alignment: Alignment.center, child: Text('Cancel'))),
              (controller.multiSelectEnabled)
                  ? PopupMenuButton<String>(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                onSelected: (value) async {
                  if (value == 'delete') {

                    CommonController commonController = Get.find<CommonController>();
                    await commonController.DeleteMultipleProduct(commonController.multiSelectionProduct,context);

                    print('Delete option selected');
                  } else if (value == 'upgrade') {
                    CommonController commonController = Get.find<CommonController>();
                    await commonController.setLoading(true);
                    await commonController.UpdateMultipleProducts(commonController.multiSelectionProduct,context);
                    await commonController.getSelectedCategoryProduct(commonController.productModelList,widget._categoryModel.id);
                    await commonController.setLoading(false);

                  }else if(value == 'selectAll'){

                    CommonController commonController = Get.find<CommonController>();
                    await commonController.selectAll();
                    print('Select All option selected');
                  }
                },
                itemBuilder: (BuildContext context) {
                  return [
                    PopupMenuItem<String>(
                      value: 'selectAll',
                      child: Text('Select All'),
                    ),
                    PopupMenuItem<String>(
                      value: 'delete',
                      child: Text('Delete'),
                    ),
                    PopupMenuItem<String>(
                      value: 'upgrade',
                      child: Text('Upgrade to Premium'),
                    ),
                  ];
                },
              )
                  :InkWell(
                onTap: (){
                  Get.to(()=>EditCategoryScreen(widget._categoryModel));
                },
                child: Row(
                  children: [
                    Text("EditCategory".tr,style: TextStyle(color: Colors.white),),
                    // Icon(Icons.edit,color: Colors.white,),

                  ],).marginOnly(right: 10),
              )
            ],
          ),

          body: (controller.productData!.length==0||controller.productData!.length==null)
              ?Center(child: Text("NoWallpaperFound".tr,style: TextStyle(color: AppColors.white),),)
              :GridView.builder(
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            primary: true,
            itemCount: controller.productData!.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 0.0,
                mainAxisSpacing: 0.0,
                mainAxisExtent: 230,
                crossAxisCount: 3),
            itemBuilder: (context, index) {
              return MixWidget(controller.productData![index],controller.multiSelectEnabled,index);

            },).marginOnly(left: 3,right: 3,),



          floatingActionButton: FloatingActionButton.extended(
              backgroundColor: AppColors.red,
              onPressed: () {
                Get.to(()=>AddNewScreen(widget._categoryModel));

              }, label:  Row(
            children: [
              Icon(Icons.add),
              Text("AddWallpaper".tr),
            ],
          )
          )),

         Visibility(
           visible: controller.isLoading,
          child: LoadingAnimation()),
      ],);
    },);
  }
}
//