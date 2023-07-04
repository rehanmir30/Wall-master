import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:wall_master_admin/Controllers/AuthenticationController.dart';
import 'package:wall_master_admin/Controllers/CommonController.dart';

import '../../../../../Constants/AppColors.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  bool isEditing = false;
  bool readOnly = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController.text = "Admin";
    emailController.text = "admin@gmail.com";
    phoneController.text = "+1 123-456-4890";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.black,
        title: Text('AdminProfile'.tr),
        centerTitle: true,
        actions: [
          InkWell(
            onTap: (){
              AuthenticationController authController = Get.find<AuthenticationController>();
              authController.signOut(authController.adminModel!);
            },
            child: Row(children: [
              Text("Logout".tr).marginOnly(right: 10),
              // Icon(Icons.exit_to_app_outlined,color: AppColors.white,)
            ],),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: AppColors.black,
        child: SingleChildScrollView(
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
              Container(
                height: 50,
                child: TextFormField(
                  controller: nameController,
                  readOnly: readOnly,
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
              Container(
                height: 50,
                child: TextFormField(
                  controller: emailController,
                  readOnly: readOnly,
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
              (isEditing==false)
                  ?Align(
                alignment: Alignment.center,
                    child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                ),
                onPressed: () {
                    // Perform action when edit button is pressed
                    setState(() {
                      isEditing = true;
                      readOnly = false;
                    });
                },
                child: Text('EditProfile'.tr),
              ),
                  )
                  :Align(
                alignment: Alignment.center,
                    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
      backgroundColor: Colors.red,
      ),
      onPressed: () {
          // Perform action when edit button is pressed
          setState(() {
            isEditing = false;
            readOnly = true;
          });
      },
      child: Text('SaveProfile'.tr),
    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
