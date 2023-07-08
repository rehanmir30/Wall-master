import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallmaster/Controllers/CommonController.dart';
import 'package:wallmaster/CustomWidgets/CommonWidget.dart';
import 'package:wallmaster/CustomWidgets/MixWidget.dart';

import '../../../../../Constants/AppColors.dart';

class RecentScreen extends StatefulWidget {
  const RecentScreen({super.key});

  @override
  State<RecentScreen> createState() => _RecentScreenState();
}

class _RecentScreenState extends State<RecentScreen> {
  // CommonController commonController = Get.find<CommonController>();
  // List<String> recentList = ['Abstract','Animals','Artistic','Astronomy','Autumn','Babies & Kids','Birds','Abstract','Animals','Artistic','Astronomy','Autumn','Babies & Kids','Birds','Abstract','Animals','Artistic','Astronomy','Autumn','Babies & Kids','Birds'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: GetBuilder<CommonController>(builder: (commonController) {
        return (commonController.productModelList!.data?.length==0 ||commonController.productModelList!.data?.length==null)
            ?Center(child: Text("No wallpaper available"),)
            :GridView.builder(
          shrinkWrap: true,
          primary: true,
          itemCount: commonController.productModelList!.data!.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 1.0,
              mainAxisSpacing: 3.0,
              mainAxisExtent: 300,
              crossAxisCount: 2),
          itemBuilder: (context, index) {
            // return CommonWidget(commonController.productModelList!.data![index]);
            return MixWidget(commonController.productModelList!.data![index]);

          },).marginSymmetric(horizontal: 30);
      },)
    );
  }
}
