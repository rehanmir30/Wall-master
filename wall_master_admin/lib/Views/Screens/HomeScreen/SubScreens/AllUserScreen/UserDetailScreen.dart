import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wall_master_admin/Models/GetAllUserModel.dart';

import '../../../../../Constants/AppColors.dart';

class UserDetailScreen extends StatefulWidget {
  UserData? data;
  UserDetailScreen(this.data,{super.key});

  @override
  State<UserDetailScreen> createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {

  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final premiumController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState

    nameController.text = widget.data!.name!;
    emailController.text = widget.data!.email!;
    if(widget.data!.isPremimum==true){
      premiumController.text = "Premium".tr;
    }else{
      premiumController.text = "Standard".tr;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        title: Text("Detail".tr),
        centerTitle: true,
        leading: InkWell(
            onTap: (){
              Get.back();
        },
            child: Icon(Icons.arrow_back_ios_new_rounded,color: Colors.white,size: 20,)),
        backgroundColor: AppColors.black,
      ),

      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 60,),
            Align(
              alignment: Alignment.center,
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.transparent,
                backgroundImage: AssetImage('assets/images/logo.png'),
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Name'.tr,
              style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
              ),
            ),
            SizedBox(height: 5.0),
            Container(
              height: 50,
              child: TextFormField(
                controller: nameController,
                readOnly: true,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: AppColors.white,width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: AppColors.white,width: 1),
                    )
                ),
              ),
            ),

            SizedBox(height: 16.0),
            Text(
              'Email'.tr,
              style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
              ),
            ),
            SizedBox(height: 5.0),
            Container(
              height: 50,
              child: TextFormField(
                controller: emailController,
                readOnly: true,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: AppColors.white,width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: AppColors.white,width: 1),
                    )
                ),
              ),
            ).marginOnly(bottom: 5),
            SizedBox(height: 16.0),
            Text(
              'Package'.tr,
              style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
              ),
            ),
            SizedBox(height: 5.0),
            Container(
              height: 50,
              child: TextFormField(
                controller: premiumController,
                readOnly: true,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: AppColors.white,width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: AppColors.white,width: 1),
                    )
                ),
              ),
            ).marginOnly(bottom: 5),
          ],
        ).marginSymmetric(horizontal: 15),
      ),
    );
  }
}
