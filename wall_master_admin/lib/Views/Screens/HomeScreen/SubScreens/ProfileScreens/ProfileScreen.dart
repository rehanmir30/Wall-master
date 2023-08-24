import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wall_master_admin/Controllers/AuthenticationController.dart';
import 'package:wall_master_admin/Controllers/CommonController.dart';

import '../../../../../Constants/AppColors.dart';
import '../../../../../CustomWidgets/CustomSnackbar.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  CommonController commonController = Get.find<CommonController>();
  AuthenticationController _authController = Get.find<AuthenticationController>();
  File? _selectedImages ;
  var _selectedImageName;

  Future<void> _pickImage() async {
    final _picker = ImagePicker();
    final pickedFile  = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile  != null) {
      setState(() {
        _selectedImageName = pickedFile.path.split('/').last;
        _selectedImages = File(pickedFile.path);
      });
    }
  }


  bool isEditing = false;
  bool readOnly = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController.text = _authController.adminModel!.data!.name!;
    emailController.text = _authController.adminModel!.data!.email!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.black,
        title: Text('AdminProfile'.tr,style: TextStyle(color: AppColors.white,fontSize: 23,fontFamily: 'agency',letterSpacing: 1.0,),),
        centerTitle: true,
        actions: [
          InkWell(
            onTap: (){
              AuthenticationController authController = Get.find<AuthenticationController>();
              authController.signOut(authController.adminModel!);
            },
            child: Row(children: [
              Text("Logout".tr,style: TextStyle(color: AppColors.white,fontFamily: 'agency',letterSpacing: 1.0,),).marginOnly(right: 10),
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

              //Password Field
              if(readOnly==false) SizedBox(height: 16.0),
              if(readOnly==false)Text(
                'Password'.tr,
                style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                ),
              ),
              if(readOnly==false)Container(
                height: 50,
                child: TextFormField(
                  controller: passwordController,
                  readOnly: readOnly,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "Enter new password",
                      hintStyle: TextStyle(color: AppColors.white.withOpacity(0.3)),
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
        CommonController _commonController = Get.find<CommonController>();
        if(nameController.text==null || nameController.text=="" || emailController.text==null || emailController.text==""){
          CustomSnackbar.show('All Fields Required', AppColors.red);

        }else{
          _commonController.updateProfile(nameController.text,emailController.text,passwordController.text,_selectedImages);
        }
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
