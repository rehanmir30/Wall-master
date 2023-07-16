import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallmaster/Controllers/CommonController.dart';

import '../../../Constants/AppColors.dart';
import '../../../Controllers/AuthenticationController.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {

  final _formKey = GlobalKey<FormState>();
  Color colos2 = Colors.brown;
  Color colos = Colors.white24;
  bool emailClicked = false;

  TextEditingController emailController = TextEditingController();

  CommonController commonController = Get.find<CommonController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        title: Text('Forget Password'),
        centerTitle: true,
        backgroundColor: AppColors.black,
        elevation: 0,
      ),

      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30,),
              Text("To reset your password please enter you email here",style: TextStyle(color: AppColors.white,fontSize: 14),),
              SizedBox(height: 20,),
              Text("Email",style: TextStyle(color: AppColors.white,fontSize: 18),),
              SizedBox(height: 5,),
              Container(
                padding: EdgeInsets.all(15),
                width: MediaQuery.of(context).size.width,
                height: 60,
                decoration: BoxDecoration(
                  color: (emailClicked)?colos2:colos,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextFormField(
                  controller: emailController,
                  onTap: (){
                    setState(() {
                      emailClicked = true;
                    });
                  },
                  cursorColor: AppColors.red,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(

                      contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      labelText: "Email".tr,
                      labelStyle: TextStyle(color: Colors.white)
                  ),
                ),
              ),
              SizedBox(height: 35,),

              InkWell(
                onTap: () async {

                  commonController.setLoading(true);
                  await commonController.forgetPassword(emailController.text);

                  commonController.setLoading(false);

                },
                child: Container(
                  height: 50,
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: AppColors.black,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.white,width: 1,)
                  ),
                  child: Text("Send".tr,style: TextStyle(color: Colors.white),),
                ),
              ),


            ],).marginSymmetric(horizontal: 10),
        ),
      ),
    );
  }
}
