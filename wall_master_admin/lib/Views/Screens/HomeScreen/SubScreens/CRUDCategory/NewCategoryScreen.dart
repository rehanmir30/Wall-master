import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wall_master_admin/Constants/AppColors.dart';
import 'package:wall_master_admin/Controllers/CommonController.dart';
import 'package:wall_master_admin/CustomWidgets/CustomSnackbar.dart';
import 'package:wall_master_admin/Models/CreateCategoryModel.dart';

class NewCategoryScreen extends StatefulWidget {
  const NewCategoryScreen({super.key});

  @override
  State<NewCategoryScreen> createState() => _NewCategoryScreenState();
}

class _NewCategoryScreenState extends State<NewCategoryScreen> {
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
        title: Text("AddNewCategory".tr,style: TextStyle(color: AppColors.white),),
        centerTitle: true,
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
                if((categoryNameController.text==null||categoryNameController.text=="")||(image?.path==null||image=="")){
                  CustomSnackbar.show("PleasePickImageAndFillAllFields".tr, AppColors.red);
                }else{
                  CreateCategoryModel model = CreateCategoryModel(name: categoryNameController.text,image: image);
                  await commonController.createCategory(model);
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
                child: Text("Create".tr,style: TextStyle(color: Colors.white,fontSize: 20),),
              ).marginSymmetric(horizontal: 15),
            ),

          ],),
      ),
    );
  }
}
