import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../Constants/AppColors.dart';
import '../../../../../Controllers/CommonController.dart';
import '../../../../../CustomWidgets/CustomSnackbar.dart';
import '../../../../../Models/CategoryModel.dart';
import '../../../../../Models/CreateCategoryModel.dart';

class EditCategoryScreen extends StatefulWidget {
  CategoryModel model;
   EditCategoryScreen(this.model,{super.key});

  @override
  State<EditCategoryScreen> createState() => _EditCategoryScreenState();
}

class _EditCategoryScreenState extends State<EditCategoryScreen> {
  final categoryNameController = TextEditingController();
  File? image;

  Future<void> _selectImage() async {
    final ImagePicker picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState

    categoryNameController.text = widget.model.name;
    super.initState();
  }

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
        title: Text("EditCategory".tr,style: TextStyle(color: AppColors.white),),
        centerTitle: true,
        actions: [
          InkWell(
            onTap: () async {
              showDialog(
                context: context,
                barrierDismissible: false, // Prevents dialog box from closing when tapped outside
                builder: (BuildContext context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    backgroundColor: AppColors.black,
                    title: Text('Confirmation'.tr,style: TextStyle(color: Colors.white),),
                    content: Text('AreYouSureYouWantToDeleteTheCategory'.tr,style: TextStyle(color: Colors.white),),
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
                          Navigator.of(context).pop(); // Return true when delete button is pressed
                          CommonController commonController = Get.find<CommonController>();
                          await commonController.deleteCategory(widget.model);

                        },
                      ),
                    ],
                  );
                },
              );
            },
            child: Row(
              children: [
                Text("Delete".tr,style: TextStyle(fontSize: 16),),
              ],
            ).marginOnly(right: 15),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                height: 60,
                child: TextFormField(
                  controller: categoryNameController,
                  autofocus: false,
                  onChanged: (val){
                    setState(() {
                      categoryNameController.text;
                    });
                  },
                  style: TextStyle(color: Colors.white,letterSpacing: 1),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 15),
                    labelText: "CategoryName".tr,
                    labelStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
                    // suffixIcon: Icon(Icons.search,color: Colors.white,),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.white,width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: AppColors.red,width: 1),
                    ),

                  ),
                )
            ).marginOnly(bottom: 10,top: 10,right: 10,left: 10),

            SizedBox(height: 50,),

            (image==null)
                ?InkWell(
              onTap: () async {
                await _selectImage();
              },
              child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width*0.9,
                height: 350,
                decoration: BoxDecoration(
                  color: AppColors.red.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text("${categoryNameController.text}",style: TextStyle(color: Colors.white,fontSize: 24),),
              ),
            )
                :InkWell(
              onTap: ()async{
                await _selectImage();
              },
              child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width*0.9,
                height: 350,
                decoration: BoxDecoration(
                    color: AppColors.red.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(image: FileImage(image!),fit: BoxFit.fill)
                ),
                child: Text("${categoryNameController.text}",style: TextStyle(color: Colors.white,fontSize: 24),),
              ),
            ),

            SizedBox(height: 15,),
            InkWell(
              onTap: () async {
                CommonController commonController = Get.find<CommonController>();
                if((categoryNameController.text==null||categoryNameController.text=="")){
                  CustomSnackbar.show("PleaseFillAllFields".tr, AppColors.red);
                }else{
                  CategoryModel model = CategoryModel(id:widget.model.id ,name: categoryNameController.text,image: image);
                  await commonController.updateCategory(model);
                }

              },
              child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                height: 50,
                decoration: BoxDecoration(
                  color: AppColors.red,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text("Update".tr,style: TextStyle(color: Colors.white,fontSize: 20),),
              ).marginSymmetric(horizontal: 15),
            ),

          ],),
      ),
    );
  }
}
