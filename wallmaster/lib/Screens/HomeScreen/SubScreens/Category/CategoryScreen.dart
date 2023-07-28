import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:wallmaster/Constants/AppColors.dart';
import 'package:wallmaster/Controllers/CommonController.dart';
import 'package:wallmaster/CustomWidgets/CategoryWidget.dart';
import 'package:wallmaster/CustomWidgets/LoadingAnimation.dart';
import 'package:wallmaster/Model/CategoryDeckWidget.dart';

import '../../../../Controllers/AuthenticationController.dart';
import '../../../../Model/CategoryModel.dart';
import '../../../../Model/GetProductModel.dart';
import '../../../Download/SetWallpaper/SetWallpaperScreen.dart';
import '../Drawer/PremiumPackages/PremiumPackage.dart';
import 'RelatedCategoryScreen.dart';
import 'package:state_persistence/state_persistence.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  CommonController commonController = Get.find<CommonController>();

  // List<String> categoryList = ['Abstract','Animals','Artistic','Astronomy','Autumn','Babies & Kids','Birds'];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return PersistedAppState(
      storage: JsonFileStorage(),
      child: Scaffold(
        backgroundColor: AppColors.black,
        body: GetBuilder<CommonController>(builder: (controller) {
          // print("LEEEEEE: "+commonController.categoryModelList!.data!.length.toString());
          if(controller.categoryDeckList==null){

            return Center(child: Text("No Wallpaper Found"),);

          }else{
            return ListView.builder(
              itemCount: controller.categoryDeckList!.length,
              itemBuilder: (context, index) {
                return Container(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${controller.categoryDeckList![index].name}',style: TextStyle(color: AppColors.white,fontSize: 18),),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(8)
                              ),
                              child: InkWell(
                                  onTap: () async {
                                    CommonController commonController = Get.find<CommonController>();
                                    AuthenticationController authenticationController = Get.find<AuthenticationController>();
                                    if(authenticationController.myUser!.data!.isPremium==0){
                                      await commonController.setCount();
                                    }
                                    commonController.getSelectedCategoryProduct(commonController.productModelList,controller.categoryModelList!.data![index].id);
                                    Get.to(()=>RelatedCategoryScreen(CategoryModel(id:controller.categoryModelList!.data![index].id,name: controller.categoryModelList!.data![index].name,image: controller.categoryModelList!.data![index].image)));
                                  },
                                  child: Text('See All ',style: TextStyle(color: AppColors.red,fontSize: 18,fontWeight: FontWeight.w500),))),

                        ],),

                      SizedBox(height: 5,),
                       (controller.categoryDeckList![index].wallpaperdata==null || controller.categoryDeckList![index].wallpaperdata!.length==0)
                           ?Container(height: 230, child: Center(child: Text('No Wallpaper',style: TextStyle(color: AppColors.white),),))
                           : Container(
                         width: MediaQuery.of(context).size.width,
                         height: 230,
                         child: ListView.builder(
                           shrinkWrap: true,
                           reverse: true,
                           primary: false,
                           clipBehavior: Clip.none,
                           itemCount: (controller.categoryDeckList![index].wallpaperdata!.length > 4)
                               ? 4
                               : controller.categoryDeckList![index].wallpaperdata!.length,
                           scrollDirection: Axis.horizontal,
                           itemBuilder: (context, indexs) {
                             final reversedIndex = controller.categoryDeckList![index].wallpaperdata!.length - 1 - indexs;

                             return CategoryDeckWidget(index,reversedIndex);
                             // return InkWell(
                             //   onTap: () async {
                             //   //  controller.categoryDeckList![index].wallpaperdata![reversedIndex]
                             //     CommonController commonController = Get.find<CommonController>();
                             //     commonController.setLoading(true);
                             //     AuthenticationController authenticationController = Get.find<AuthenticationController>();
                             //     if(controller.categoryDeckList![index].wallpaperdata![reversedIndex].forPremium ==1){
                             //       if(authenticationController.myUser!.data!.isPremium==0 || authenticationController.myUser!.data!.isPremium==null){
                             //         commonController.setLoading(false);
                             //         showDialog(context: context, builder: (context) {
                             //           return AlertDialog(
                             //             title: Text('premiummember'.tr),
                             //             backgroundColor: AppColors.white,
                             //             elevation: 3,
                             //             content: Text("viewwallpaper".tr),
                             //             actions: [
                             //               InkWell(
                             //                   onTap: () async {
                             //                     commonController.setLoading(true);
                             //                     List<ProductData> data =[];
                             //                     Navigator.pop(context);
                             //                     data.add(controller.categoryDeckList![index].wallpaperdata![reversedIndex]);
                             //                     await commonController.getReliventData(data);
                             //                     await commonController.showRewardedAd(controller.categoryDeckList![index].wallpaperdata![reversedIndex],true,);
                             //                     commonController.setLoading(false);
                             //                     // Get.to(()=>SetWallpaperScreen(widget.wallpaper,true));
                             //                   },
                             //                   child: Text("ViewAd".tr,style: TextStyle(color: Colors.blue),)),
                             //               ElevatedButton(
                             //                   style: ElevatedButton.styleFrom(backgroundColor: AppColors.red),
                             //                   onPressed: () {
                             //                     Navigator.of(context).pop();
                             //                     Get.to(()=>PremiumPackage());
                             //
                             //                   }, child: Text('BuyPremium'.tr,style: TextStyle(color: AppColors.white),))
                             //             ],
                             //           );
                             //         },);
                             //
                             //       }
                             //       else{
                             //         CommonController commonController = Get.find<CommonController>();
                             //         await commonController.setLoading(true);
                             //         List<ProductData> data =[];
                             //         data!.add(controller.categoryDeckList![index].wallpaperdata![reversedIndex]);
                             //         await commonController.getReliventData(data);
                             //         await commonController.setLoading(false);
                             //         Get.to(()=>SetWallpaperScreen(controller.categoryDeckList![index].wallpaperdata![reversedIndex],true));            // await commonController.setCount();
                             //
                             //
                             //       }
                             //
                             //     }
                             //     else{
                             //
                             //       if(authenticationController.myUser?.data!.isPremium ==0 || authenticationController.myUser?.data!.isPremium ==null){
                             //         CommonController commonController = Get.find<CommonController>();
                             //         await commonController.setLoading(true);
                             //         List<ProductData> data =[];
                             //         data!.add(controller.categoryDeckList![index].wallpaperdata![reversedIndex]);
                             //         await commonController.getReliventData(data);
                             //         await commonController.setCount();
                             //         await commonController.setLoading(false);
                             //         Get.to(()=>SetWallpaperScreen(controller.categoryDeckList![index].wallpaperdata![reversedIndex],true));
                             //       }else{
                             //         CommonController commonController = Get.find<CommonController>();
                             //         await commonController.setLoading(true);
                             //         List<ProductData> data =[];
                             //         data!.add(controller.categoryDeckList![index].wallpaperdata![reversedIndex]);
                             //         await commonController.getReliventData(data);
                             //         await commonController.setLoading(false);
                             //         Get.to(()=>SetWallpaperScreen(controller.categoryDeckList![index].wallpaperdata![reversedIndex],true));
                             //       }
                             //
                             //     }
                             //
                             //   },
                             //   child: Stack(
                             //     clipBehavior: Clip.none,
                             //     children: [
                             //       Align(
                             //         widthFactor: 0.6,
                             //         child: Card(
                             //           shape: RoundedRectangleBorder(
                             //             borderRadius: BorderRadius.circular(25),
                             //           ),
                             //           child: Container(
                             //             decoration: BoxDecoration(
                             //               shape: BoxShape.rectangle,
                             //               // color: AppColors.white,
                             //               border: Border.all(color: Colors.white, width: 2),
                             //               borderRadius: BorderRadius.circular(25),
                             //             ),
                             //             height: 200,
                             //             width: 120,
                             //             child: ClipRRect(
                             //               borderRadius: BorderRadius.circular(25),
                             //               child: FadeInImage(
                             //                 image: CachedNetworkImageProvider(
                             //                     "${controller.categoryDeckList![index].wallpaperdata![reversedIndex].image}"),
                             //                 placeholder: AssetImage('assets/images/modified_logo.png'),
                             //                 fit: BoxFit.fill,
                             //               ),
                             //             ),
                             //           ),
                             //         ),
                             //       ),
                             //       if (commonController.categoryDeckList![index]
                             //           .wallpaperdata![reversedIndex].forPremium ==
                             //           1)
                             //         Positioned(
                             //           right: -15,
                             //           bottom: 25,
                             //           child: Column(
                             //             mainAxisSize: MainAxisSize.min,
                             //             crossAxisAlignment: CrossAxisAlignment.center,
                             //             children: [
                             //               CircleAvatar(
                             //                 backgroundColor: Colors.transparent,
                             //                 radius: 10,
                             //                 child: Icon(
                             //                   Icons.workspace_premium_outlined,
                             //                   color: Colors.white,
                             //                 ),
                             //               ),
                             //               SizedBox(
                             //                 height: 10,
                             //               ),
                             //               Container(
                             //                 padding: EdgeInsets.symmetric(horizontal: 3, vertical: 2),
                             //                 decoration: BoxDecoration(
                             //                   borderRadius: BorderRadius.circular(10),
                             //                   color: Colors.white,
                             //                 ),
                             //                 child: Image.asset(
                             //                   "assets/images/play.png",
                             //                   width: 20,
                             //                   height: 20,
                             //                 ),
                             //               ).marginOnly(left: 5)
                             //             ],
                             //           ),
                             //         ),
                             //     ],
                             //   ),
                             // );
                           },
                         ).marginOnly(right: 30),
                       ),


                    ],
                  ),
                );

              },);
          }

          // if(controller.categoryModelList==null || controller.categoryModelList!.data==null|| controller.categoryModelList!.data!.length==0 || controller.categoryModelList!.data!.length==null){
          //   return Center(child: Text('No Category Found'),);
          // }else{
          //   return GridView.builder(
          //     itemCount: controller.categoryModelList!.data!.length,
          //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //       crossAxisCount: 2,
          //       crossAxisSpacing: 0,
          //       mainAxisSpacing: 0,
          //       mainAxisExtent: 180,
          //     ), itemBuilder: (context, index) {
          //     return CategoryWidget(controller.categoryModelList!, index);
          //   },);
          // }


          // return ListView.builder(
          //   shrinkWrap: true,
          //   primary: false,
          //   itemCount: controller.categoryModelList!.data!.length,
          //   itemBuilder: (context, index) {
          //     return CategoryWidget(controller.categoryModelList!,index);
          //
          //   },);
        },).marginSymmetric(horizontal:15),
      ),
    );
  }
}
