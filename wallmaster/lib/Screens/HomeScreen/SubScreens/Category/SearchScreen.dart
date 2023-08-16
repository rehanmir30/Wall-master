import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallmaster/Constants/AppColors.dart';

import '../../../../Controllers/CommonController.dart';
import '../../../../CustomWidgets/MixWidget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        title: Text("Search"),
        centerTitle: true,
        backgroundColor: AppColors.black,
      ),

      body: Column(
        children: [
          Container(
              height: 50,
              child: TextFormField(
                controller: searchController,
                autofocus: false,
                style: TextStyle(color: Colors.white,letterSpacing: 1),
                onChanged: (val) async {
                  CommonController commonController = Get.find<CommonController>();
                  await  commonController.getSearchedData(val);


                },

                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 15),
                  hintText: "Search",
                  hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
                  suffixIcon: Icon(Icons.search,color: Colors.white,),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Colors.white,width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: AppColors.red,width: 1),
                  ),

                ),
              )
          ).marginOnly(bottom: 10,top: 10,right: 10,left: 10),

          Expanded(
            child: GetBuilder<CommonController>(builder: (commonController) {
              return (commonController.producSearchedData?.length==0 ||commonController.producSearchedData?.length==null)
                  ?Center(child: Text("NoWallpaperAvailable".tr,style: TextStyle(color: AppColors.white),),)
                  :GridView.builder(
                shrinkWrap: true,
                primary: true,
                itemCount: commonController.producSearchedData!.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 0.0,
                  mainAxisSpacing: 0.0,
                  mainAxisExtent: 230,
                  crossAxisCount: 3,
                ),
                itemBuilder: (context, index) {
                  // return CommonWidget(commonController.productModelList!.data![index]);
                  return MixWidget(commonController.producSearchedData![index]);

                },).marginSymmetric(horizontal: 3);
            },),
          ),
        ],
      )
    );
  }
}
