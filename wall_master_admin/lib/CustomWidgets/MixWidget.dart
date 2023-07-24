import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wall_master_admin/Controllers/CommonController.dart';
import 'package:wall_master_admin/Views/Screens/HomeScreen/SubScreens/CategoryScreens/PreviewWallpaper.dart';

import '../Constants/AppColors.dart';
import '../Models/GetProductModel.dart';

class MixWidget extends StatefulWidget {
  ProductData _productData;
  bool multiSelectEnabled;
  int currentIndex;
   MixWidget(this._productData,this.multiSelectEnabled,this.currentIndex,{super.key});

  @override
  State<MixWidget> createState() => _MixWidgetState();
}

class _MixWidgetState extends State<MixWidget> {
  bool checkboxEnabled = false;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CommonController>(builder: (_commonController) {
      return InkWell(
        onTap: (){
          if(_commonController.multiSelectEnabled==false)
            Get.to(()=>PreviewWallpaper(widget._productData));
        },
        onLongPress: (){
            _commonController.setMultiSelectSupport(true,false);
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

              if(widget.multiSelectEnabled)Positioned(
                top: 0,
                left: 0,
                child: Checkbox(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                  side: BorderSide(color: AppColors.green,width: 2),
                  activeColor: AppColors.red,
                  value: _commonController.multicheckBox[widget.currentIndex], onChanged: (value) {
                    checkboxEnabled = !checkboxEnabled;
                    if(value==true){
                      _commonController.updateMulticheckBoxValue(true,widget.currentIndex);
                      _commonController.addProductUsingMultiSelect(widget._productData);
                    }else if(value==false){
                      _commonController.updateMulticheckBoxValue(false,widget.currentIndex);
                      _commonController.removeProductUsingMultiSelect(widget._productData);

                    }
                },),
              )
            ],
          ),
        ),
      );
    },);
  }
}
