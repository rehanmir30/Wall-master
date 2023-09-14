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
    for(var i in commonController.categoryDeckList!){
      print(" Category: ${i.id}");

      for(var j in i.wallpaperdata!){
        print('Product Premium: ${j.forPremium}');
      }

    }
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

           return CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    addRepaintBoundaries: false,
                        addAutomaticKeepAlives: true,
                        (context, index) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        height: 244,
                        child: Column(
                          children: [
                            Align(
                                alignment:Alignment.centerLeft,
                                child: Text('${controller.categoryDeckList![index].name}'.toUpperCase().tr,style: TextStyle(color: AppColors.white,fontSize: 22,fontWeight: FontWeight.bold,fontFamily: 'agency'),)).marginOnly(top: 5),

                            // SizedBox(height: 2,),
                            (controller.categoryDeckList![index].wallpaperdata==null || controller.categoryDeckList![index].wallpaperdata!.length==0)
                                ?Container(height: 230, child: Center(child: Text('No Wallpaper',style: TextStyle(color: AppColors.white),),))
                                :Container(
                              height: 210,
                              width: MediaQuery.of(context).size.width,
                              child: IndexedStack(
                                alignment: Alignment.center,
                                index: controller.stackIndex![index],
                                children: [

                                  //First Pic Selected
                                  Stack(
                                    clipBehavior: Clip.none,
                                    children: [


                                      Positioned(
                                        right: 2,
                                        top: 10,
                                        child: InkWell(
                                          onTap: ()async{
                                            await controller.updatedStackIndex(index, 3);
                                          },
                                          child: Stack(
                                            children: [
                                              Container(
                                                width: 120,
                                                height: 200,
                                                decoration: BoxDecoration(
                                                    color: AppColors.black,
                                                    border: Border.all(color: AppColors.white,width: 3),
                                                    borderRadius: BorderRadius.circular(15)
                                                ),
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(15),
                                                  child: FadeInImage(
                                                    fit: BoxFit.fill,
                                                    placeholderFit: BoxFit.contain,
                                                    placeholder: AssetImage("assets/images/circle_logo.png"),
                                                    image: CachedNetworkImageProvider('${controller.categoryDeckList![index].wallpaperdata![3].image}'),
                                                  ),

                                                ),
                                              ),

                                              Visibility(
                                                visible: (controller.categoryDeckList![index].wallpaperdata![3].forPremium==1)?true:false,
                                                child: Positioned(
                                                  right: 15,
                                                  top: 10,
                                                  child: Column(
                                                    children: [
                                                      CircleAvatar(
                                                        backgroundColor: Colors.transparent,
                                                        radius: 10,
                                                        child: Icon(Icons.workspace_premium_outlined,color: Colors.white,),
                                                      ),
                                                      SizedBox(height: 10,),

                                                      Container(
                                                        padding: EdgeInsets.symmetric(horizontal: 3,vertical: 2),
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(10),
                                                          color: Colors.white,
                                                        ),
                                                        child: Image.asset("assets/images/play.png",width: 20,height: 20,),
                                                      ).marginOnly(left: 5)
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: MediaQuery.of(context).size.width*0.4,
                                        top: 10,
                                        child: InkWell(
                                          onTap: () async {
                                            await controller.updatedStackIndex(index, 2);
                                          },
                                          child: Stack(
                                            children: [
                                              Container(
                                                width: 120,
                                                height: 200,
                                                decoration: BoxDecoration(
                                                    color: AppColors.black,
                                                    border: Border.all(color: AppColors.white,width: 3),
                                                    borderRadius: BorderRadius.circular(15)
                                                ),
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(15),
                                                  child: FadeInImage(
                                                    fit: BoxFit.fill,
                                                    placeholderFit: BoxFit.contain,
                                                    placeholder: AssetImage("assets/images/circle_logo.png"),
                                                    image: CachedNetworkImageProvider('${controller.categoryDeckList![index].wallpaperdata![2].image}'),
                                                  ),

                                                ),
                                              ),

                                              Visibility(
                                                visible: (controller.categoryDeckList![index].wallpaperdata![2].forPremium==1)?true:false,
                                                child: Positioned(
                                                  right: 15,
                                                  top: 10,
                                                  child: Column(
                                                    children: [
                                                      CircleAvatar(
                                                        backgroundColor: Colors.transparent,
                                                        radius: 10,
                                                        child: Icon(Icons.workspace_premium_outlined,color: Colors.white,),
                                                      ),
                                                      SizedBox(height: 10,),

                                                      Container(
                                                        padding: EdgeInsets.symmetric(horizontal: 3,vertical: 2),
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(10),
                                                          color: Colors.white,
                                                        ),
                                                        child: Image.asset("assets/images/play.png",width: 20,height: 20,),
                                                      ).marginOnly(left: 5)
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: MediaQuery.of(context).size.width*0.2,
                                        top: 10,
                                        child: InkWell(
                                          onTap: () async {
                                            await controller.updatedStackIndex(index, 1);
                                          },
                                          child: Stack(
                                            children: [
                                              Container(
                                                width: 120,
                                                height: 200,
                                                decoration: BoxDecoration(
                                                    color: AppColors.black,
                                                    border: Border.all(color: AppColors.white,width: 3),
                                                    borderRadius: BorderRadius.circular(15)
                                                ),
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(15),
                                                  child: FadeInImage(
                                                    fit: BoxFit.fill,
                                                    placeholderFit: BoxFit.contain,
                                                    placeholder: AssetImage("assets/images/circle_logo.png"),
                                                    image: CachedNetworkImageProvider('${controller.categoryDeckList![index].wallpaperdata![1].image}'),
                                                  ),

                                                ),
                                              ),

                                              Visibility(
                                                visible: (controller.categoryDeckList![index].wallpaperdata![1].forPremium==1)?true:false,
                                                child: Positioned(
                                                  right: 15,
                                                  top: 10,
                                                  child: Column(
                                                    children: [
                                                      CircleAvatar(
                                                        backgroundColor: Colors.transparent,
                                                        radius: 10,
                                                        child: Icon(Icons.workspace_premium_outlined,color: Colors.white,),
                                                      ),
                                                      SizedBox(height: 10,),

                                                      Container(
                                                        padding: EdgeInsets.symmetric(horizontal: 3,vertical: 2),
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(10),
                                                          color: Colors.white,
                                                        ),
                                                        child: Image.asset("assets/images/play.png",width: 20,height: 20,),
                                                      ).marginOnly(left: 5)
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 2,
                                        top: 0,
                                        child: InkWell(
                                          onTap: () async {
                                            await controller.updatedStackIndex(index, 0);
                                            CommonController commonController = Get.find<CommonController>();
                                            commonController.setLoading(true);
                                            AuthenticationController authenticationController = Get.find<AuthenticationController>();
                                            if(controller.categoryDeckList![index].wallpaperdata![0].forPremium ==1){
                                              if(authenticationController.myUser!.data!.isPremium==0 || authenticationController.myUser!.data!.isPremium==null){
                                                commonController.setLoading(false);
                                                showDialog(context: context, builder: (context) {
                                                  return AlertDialog(
                                                    title: Text('premiummember'.tr),
                                                    backgroundColor: AppColors.white,
                                                    elevation: 3,
                                                    content: Text("viewwallpaper".tr),
                                                    actions: [
                                                      InkWell(
                                                          onTap: () async {
                                                            commonController.setLoading(true);
                                                            List<ProductData> data =[];
                                                            Navigator.pop(context);
                                                            data.add(controller.categoryDeckList![index].wallpaperdata![0]);
                                                            await commonController.getReliventData(data);
                                                            await commonController.showRewardedAd(controller.categoryDeckList![index].wallpaperdata![0],true,);
                                                            commonController.setLoading(false);
                                                            // Get.to(()=>SetWallpaperScreen(widget.wallpaper,true));
                                                          },
                                                          child: Text("ViewAd".tr,style: TextStyle(color: Colors.blue),)),
                                                      ElevatedButton(
                                                          style: ElevatedButton.styleFrom(backgroundColor: AppColors.red),
                                                          onPressed: () {
                                                            Navigator.of(context).pop();
                                                            Get.to(()=>PremiumPackage());

                                                          }, child: Text('BuyPremium'.tr,style: TextStyle(color: AppColors.white),))
                                                    ],
                                                  );
                                                },);

                                              }
                                              else{
                                                CommonController commonController = Get.find<CommonController>();
                                                await commonController.setLoading(true);
                                                List<ProductData> data =[];
                                                data!.add(controller.categoryDeckList![index].wallpaperdata![0]);
                                                await commonController.getReliventData(data);
                                                await commonController.setLoading(false);
                                                Get.to(()=>SetWallpaperScreen(controller.categoryDeckList![index].wallpaperdata![0],true));            // await commonController.setCount();


                                              }

                                            }
                                            else{

                                              if(authenticationController.myUser?.data!.isPremium ==0 || authenticationController.myUser?.data!.isPremium ==null){
                                                CommonController commonController = Get.find<CommonController>();
                                                await commonController.setLoading(true);
                                                List<ProductData> data =[];
                                                data!.add(controller.categoryDeckList![index].wallpaperdata![0]);
                                                await commonController.getReliventData(data);
                                                await commonController.setCount();
                                                await commonController.setLoading(false);
                                                Get.to(()=>SetWallpaperScreen(controller.categoryDeckList![index].wallpaperdata![0],true));
                                              }else{
                                                CommonController commonController = Get.find<CommonController>();
                                                await commonController.setLoading(true);
                                                List<ProductData> data =[];
                                                data!.add(controller.categoryDeckList![index].wallpaperdata![0]);
                                                await commonController.getReliventData(data);
                                                await commonController.setLoading(false);
                                                Get.to(()=>SetWallpaperScreen(controller.categoryDeckList![index].wallpaperdata![0],true));
                                              }

                                            }

                                          },
                                          child: Stack(
                                            children: [
                                              Container(
                                                width: 130,
                                                height: 215,
                                                decoration: BoxDecoration(
                                                    color: AppColors.black,
                                                    border: Border.all(color: AppColors.white,width: 3),
                                                    borderRadius: BorderRadius.circular(15)
                                                ),
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(15),
                                                  child: FadeInImage(
                                                    fit: BoxFit.fill,
                                                    placeholderFit: BoxFit.contain,
                                                    placeholder: AssetImage("assets/images/circle_logo.png"),
                                                    image: CachedNetworkImageProvider('${controller.categoryDeckList![index].wallpaperdata![0].image}'),
                                                  ),

                                                ),
                                              ),
                                              Visibility(
                                                visible: (controller.categoryDeckList![index].wallpaperdata![0].forPremium==1)?true:false,
                                                child: Positioned(
                                                  right: 15,
                                                  top: 10,
                                                  child: Column(
                                                    children: [
                                                      CircleAvatar(
                                                        backgroundColor: Colors.transparent,
                                                        radius: 10,
                                                        child: Icon(Icons.workspace_premium_outlined,color: Colors.white,),
                                                      ),
                                                      SizedBox(height: 10,),

                                                      Container(
                                                        padding: EdgeInsets.symmetric(horizontal: 3,vertical: 2),
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(10),
                                                          color: Colors.white,
                                                        ),
                                                        child: Image.asset("assets/images/play.png",width: 20,height: 20,),
                                                      ).marginOnly(left: 5)
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),

                                      Positioned(
                                        top: -16,
                                        right: 2,
                                        child:  InkWell(
                                          onTap: () async {
                                            print("Clicked");
                                            CommonController commonController = Get.find<CommonController>();
                                            AuthenticationController authenticationController = Get.find<AuthenticationController>();
                                            if(authenticationController.myUser!.data!.isPremium==0){
                                              await commonController.setCount();
                                            }
                                            commonController.getSelectedCategoryProduct(commonController.productModelList,controller.categoryDeckList![index].id);
                                            Get.to(()=>RelatedCategoryScreen(CategoryModel(id:controller.categoryDeckList![index].id,name: controller.categoryDeckList![index].name,image: controller.categoryDeckList![index].image)));

                                          },
                                          child: Container(
                                              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                              decoration: BoxDecoration(
                                                  color: AppColors.white,
                                                  borderRadius: BorderRadius.circular(8)
                                              ),
                                              child: Text('SEEALL'.tr,style: TextStyle(color: AppColors.red,fontSize: 18,fontFamily: 'agency',fontWeight: FontWeight.bold),)).marginOnly(right: 0),
                                        ),
                                      )



                                    ],
                                  ),

                                  //Second Pic Selected
                                  Stack(
                                    clipBehavior: Clip.none,
                                    children: [

                                      Positioned(
                                        right: 2,
                                        top: 10,
                                        child: InkWell(
                                          onTap: () async {
                                            await controller.updatedStackIndex(index, 3);
                                          },
                                          child: Stack(
                                            children: [
                                              Container(
                                                width: 120,
                                                height: 200,
                                                decoration: BoxDecoration(
                                                    color: AppColors.black,
                                                    border: Border.all(color: AppColors.white,width: 3),
                                                    borderRadius: BorderRadius.circular(15)
                                                ),
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(15),
                                                  child: FadeInImage(
                                                    fit: BoxFit.fill,
                                                    placeholderFit: BoxFit.contain,
                                                    placeholder: AssetImage("assets/images/circle_logo.png"),
                                                    image: CachedNetworkImageProvider('${controller.categoryDeckList![index].wallpaperdata![3].image}'),
                                                  ),

                                                ),
                                              ),
                                              Visibility(
                                                visible: (controller.categoryDeckList![index].wallpaperdata![3].forPremium==1)?true:false,
                                                child: Positioned(
                                                  right: 15,
                                                  top: 10,
                                                  child: Column(
                                                    children: [
                                                      CircleAvatar(
                                                        backgroundColor: Colors.transparent,
                                                        radius: 10,
                                                        child: Icon(Icons.workspace_premium_outlined,color: Colors.white,),
                                                      ),
                                                      SizedBox(height: 10,),

                                                      Container(
                                                        padding: EdgeInsets.symmetric(horizontal: 3,vertical: 2),
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(10),
                                                          color: Colors.white,
                                                        ),
                                                        child: Image.asset("assets/images/play.png",width: 20,height: 20,),
                                                      ).marginOnly(left: 5)
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: MediaQuery.of(context).size.width*0.4,
                                        top: 10,
                                        child: InkWell(
                                          onTap: () async {
                                            await controller.updatedStackIndex(index, 2);
                                          },
                                          child: Stack(
                                            children: [
                                              Container(
                                                width: 120,
                                                height: 200,
                                                decoration: BoxDecoration(
                                                    color: AppColors.black,
                                                    border: Border.all(color: AppColors.white,width: 3),
                                                    borderRadius: BorderRadius.circular(15)
                                                ),
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(15),
                                                  child: FadeInImage(
                                                    fit: BoxFit.fill,
                                                    placeholderFit: BoxFit.contain,
                                                    placeholder: AssetImage("assets/images/circle_logo.png"),
                                                    image: CachedNetworkImageProvider('${controller.categoryDeckList![index].wallpaperdata![2].image}'),
                                                  ),

                                                ),
                                              ),

                                              Visibility(
                                                visible: (controller.categoryDeckList![index].wallpaperdata![2].forPremium==1)?true:false,
                                                child: Positioned(
                                                  right: 15,
                                                  top: 10,
                                                  child: Column(
                                                    children: [
                                                      CircleAvatar(
                                                        backgroundColor: Colors.transparent,
                                                        radius: 10,
                                                        child: Icon(Icons.workspace_premium_outlined,color: Colors.white,),
                                                      ),
                                                      SizedBox(height: 10,),

                                                      Container(
                                                        padding: EdgeInsets.symmetric(horizontal: 3,vertical: 2),
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(10),
                                                          color: Colors.white,
                                                        ),
                                                        child: Image.asset("assets/images/play.png",width: 20,height: 20,),
                                                      ).marginOnly(left: 5)
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 2,
                                        top: 10,
                                        child: InkWell(
                                          onTap: () async {
                                            await controller.updatedStackIndex(index, 0);
                                          },
                                          child: Stack(
                                            children: [
                                              Container(
                                                width: 120,
                                                height: 200,
                                                decoration: BoxDecoration(
                                                    color: AppColors.black,
                                                    border: Border.all(color: AppColors.white,width: 3),
                                                    borderRadius: BorderRadius.circular(15)
                                                ),
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(15),
                                                  child: FadeInImage(
                                                    fit: BoxFit.fill,
                                                    placeholderFit: BoxFit.contain,
                                                    placeholder: AssetImage("assets/images/circle_logo.png"),
                                                    image: CachedNetworkImageProvider('${controller.categoryDeckList![index].wallpaperdata![0].image}'),
                                                  ),

                                                ),
                                              ),

                                              Visibility(
                                                visible: (controller.categoryDeckList![index].wallpaperdata![0].forPremium==1)?true:false,
                                                child: Positioned(
                                                  right: 15,
                                                  top: 10,
                                                  child: Column(
                                                    children: [
                                                      CircleAvatar(
                                                        backgroundColor: Colors.transparent,
                                                        radius: 10,
                                                        child: Icon(Icons.workspace_premium_outlined,color: Colors.white,),
                                                      ),
                                                      SizedBox(height: 10,),

                                                      Container(
                                                        padding: EdgeInsets.symmetric(horizontal: 3,vertical: 2),
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(10),
                                                          color: Colors.white,
                                                        ),
                                                        child: Image.asset("assets/images/play.png",width: 20,height: 20,),
                                                      ).marginOnly(left: 5)
                                                    ],
                                                  ),
                                                ),
                                              ),

                                            ],
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: MediaQuery.of(context).size.width*0.2,
                                        top: 0,
                                        child: InkWell(
                                          onTap: () async {
                                            await controller.updatedStackIndex(index, 1);

                                            CommonController commonController = Get.find<CommonController>();
                                            commonController.setLoading(true);
                                            AuthenticationController authenticationController = Get.find<AuthenticationController>();
                                            if(controller.categoryDeckList![index].wallpaperdata![1].forPremium ==1){
                                              if(authenticationController.myUser!.data!.isPremium==0 || authenticationController.myUser!.data!.isPremium==null){
                                                commonController.setLoading(false);
                                                showDialog(context: context, builder: (context) {
                                                  return AlertDialog(
                                                    title: Text('premiummember'.tr),
                                                    backgroundColor: AppColors.white,
                                                    elevation: 3,
                                                    content: Text("viewwallpaper".tr),
                                                    actions: [
                                                      InkWell(
                                                          onTap: () async {
                                                            commonController.setLoading(true);
                                                            List<ProductData> data =[];
                                                            Navigator.pop(context);
                                                            data.add(controller.categoryDeckList![index].wallpaperdata![1]);
                                                            await commonController.getReliventData(data);
                                                            await commonController.showRewardedAd(controller.categoryDeckList![index].wallpaperdata![1],true,);
                                                            commonController.setLoading(false);
                                                            // Get.to(()=>SetWallpaperScreen(widget.wallpaper,true));
                                                          },
                                                          child: Text("ViewAd".tr,style: TextStyle(color: Colors.blue),)),
                                                      ElevatedButton(
                                                          style: ElevatedButton.styleFrom(backgroundColor: AppColors.red),
                                                          onPressed: () {
                                                            Navigator.of(context).pop();
                                                            Get.to(()=>PremiumPackage());

                                                          }, child: Text('BuyPremium'.tr,style: TextStyle(color: AppColors.white),))
                                                    ],
                                                  );
                                                },);

                                              }
                                              else{
                                                CommonController commonController = Get.find<CommonController>();
                                                await commonController.setLoading(true);
                                                List<ProductData> data =[];
                                                data!.add(controller.categoryDeckList![index].wallpaperdata![1]);
                                                await commonController.getReliventData(data);
                                                await commonController.setLoading(false);
                                                Get.to(()=>SetWallpaperScreen(controller.categoryDeckList![index].wallpaperdata![1],true));            // await commonController.setCount();


                                              }

                                            }
                                            else{

                                              if(authenticationController.myUser?.data!.isPremium ==0 || authenticationController.myUser?.data!.isPremium ==null){
                                                CommonController commonController = Get.find<CommonController>();
                                                await commonController.setLoading(true);
                                                List<ProductData> data =[];
                                                data!.add(controller.categoryDeckList![index].wallpaperdata![1]);
                                                await commonController.getReliventData(data);
                                                await commonController.setCount();
                                                await commonController.setLoading(false);
                                                Get.to(()=>SetWallpaperScreen(controller.categoryDeckList![index].wallpaperdata![1],true));
                                              }else{
                                                CommonController commonController = Get.find<CommonController>();
                                                await commonController.setLoading(true);
                                                List<ProductData> data =[];
                                                data!.add(controller.categoryDeckList![index].wallpaperdata![1]);
                                                await commonController.getReliventData(data);
                                                await commonController.setLoading(false);
                                                Get.to(()=>SetWallpaperScreen(controller.categoryDeckList![index].wallpaperdata![1],true));
                                              }

                                            }

                                          },
                                          child: Stack(
                                            children: [
                                              Container(
                                                width: 130,
                                                height: 215,
                                                decoration: BoxDecoration(
                                                    color: AppColors.black,
                                                    border: Border.all(color: AppColors.white,width: 3),
                                                    borderRadius: BorderRadius.circular(15)
                                                ),
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(15),
                                                  child: FadeInImage(
                                                    fit: BoxFit.fill,
                                                    placeholderFit: BoxFit.contain,
                                                    placeholder: AssetImage("assets/images/circle_logo.png"),
                                                    image: CachedNetworkImageProvider('${controller.categoryDeckList![index].wallpaperdata![1].image}'),
                                                  ),

                                                ),
                                              ),
                                              Visibility(
                                                visible: (controller.categoryDeckList![index].wallpaperdata![1].forPremium==1)?true:false,
                                                child: Positioned(
                                                  right: 15,
                                                  top: 10,
                                                  child: Column(
                                                    children: [
                                                      CircleAvatar(
                                                        backgroundColor: Colors.transparent,
                                                        radius: 10,
                                                        child: Icon(Icons.workspace_premium_outlined,color: Colors.white,),
                                                      ),
                                                      SizedBox(height: 10,),

                                                      Container(
                                                        padding: EdgeInsets.symmetric(horizontal: 3,vertical: 2),
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(10),
                                                          color: Colors.white,
                                                        ),
                                                        child: Image.asset("assets/images/play.png",width: 20,height: 20,),
                                                      ).marginOnly(left: 5)
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),

                                      Positioned(
                                        top: -16,
                                        right: 2,
                                        child:  InkWell(
                                          onTap: () async {
                                            print("Clicked");
                                            CommonController commonController = Get.find<CommonController>();
                                            AuthenticationController authenticationController = Get.find<AuthenticationController>();
                                            if(authenticationController.myUser!.data!.isPremium==0){
                                              await commonController.setCount();
                                            }
                                            commonController.getSelectedCategoryProduct(commonController.productModelList,controller.categoryDeckList![index].id);
                                            Get.to(()=>RelatedCategoryScreen(CategoryModel(id:controller.categoryDeckList![index].id,name: controller.categoryDeckList![index].name,image: controller.categoryDeckList![index].image)));

                                          },
                                          child: Container(
                                              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                              decoration: BoxDecoration(
                                                  color: AppColors.white,
                                                  borderRadius: BorderRadius.circular(8)
                                              ),
                                              child: Text('SEEALL'.tr,style: TextStyle(color: AppColors.red,fontSize: 18,fontFamily: 'agency',fontWeight: FontWeight.bold),)).marginOnly(right: 0),
                                        ),
                                      )

                                    ],
                                  ),

                                  //Third Pic Selected
                                  Stack(
                                    clipBehavior: Clip.none,
                                    children: [


                                      Positioned(
                                        left: 2,
                                        top: 10,
                                        child: InkWell(
                                          onTap: () async {
                                            await controller.updatedStackIndex(index, 0);
                                          },
                                          child: Stack(
                                            children: [
                                              Container(
                                                width: 120,
                                                height: 200,
                                                decoration: BoxDecoration(
                                                    color: AppColors.black,
                                                    border: Border.all(color: AppColors.white,width: 3),
                                                    borderRadius: BorderRadius.circular(15)
                                                ),
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(15),
                                                  child: FadeInImage(
                                                    fit: BoxFit.fill,
                                                    placeholderFit: BoxFit.contain,
                                                    placeholder: AssetImage("assets/images/circle_logo.png"),
                                                    image: CachedNetworkImageProvider('${controller.categoryDeckList![index].wallpaperdata![0].image}'),
                                                  ),

                                                ),
                                              ),
                                              Visibility(
                                                visible: (controller.categoryDeckList![index].wallpaperdata![0].forPremium==1)?true:false,
                                                child: Positioned(
                                                  right: 15,
                                                  top: 10,
                                                  child: Column(
                                                    children: [
                                                      CircleAvatar(
                                                        backgroundColor: Colors.transparent,
                                                        radius: 10,
                                                        child: Icon(Icons.workspace_premium_outlined,color: Colors.white,),
                                                      ),
                                                      SizedBox(height: 10,),

                                                      Container(
                                                        padding: EdgeInsets.symmetric(horizontal: 3,vertical: 2),
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(10),
                                                          color: Colors.white,
                                                        ),
                                                        child: Image.asset("assets/images/play.png",width: 20,height: 20,),
                                                      ).marginOnly(left: 5)
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        right: 2,
                                        top: 10,
                                        child: InkWell(
                                          onTap: () async {
                                            await controller.updatedStackIndex(index, 3);
                                          },
                                          child: Stack(
                                            children: [
                                              Container(
                                                width: 120,
                                                height: 200,
                                                decoration: BoxDecoration(
                                                    color: AppColors.black,
                                                    border: Border.all(color: AppColors.white,width: 3),
                                                    borderRadius: BorderRadius.circular(15)
                                                ),
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(15),
                                                  child: FadeInImage(
                                                    fit: BoxFit.fill,
                                                    placeholderFit: BoxFit.contain,
                                                    placeholder: AssetImage("assets/images/circle_logo.png"),
                                                    image: CachedNetworkImageProvider('${controller.categoryDeckList![index].wallpaperdata![3].image}'),
                                                  ),

                                                ),
                                              ),

                                              Visibility(
                                                visible: (controller.categoryDeckList![index].wallpaperdata![3].forPremium==1)?true:false,
                                                child: Positioned(
                                                  right: 15,
                                                  top: 10,
                                                  child: Column(
                                                    children: [
                                                      CircleAvatar(
                                                        backgroundColor: Colors.transparent,
                                                        radius: 10,
                                                        child: Icon(Icons.workspace_premium_outlined,color: Colors.white,),
                                                      ),
                                                      SizedBox(height: 10,),

                                                      Container(
                                                        padding: EdgeInsets.symmetric(horizontal: 3,vertical: 2),
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(10),
                                                          color: Colors.white,
                                                        ),
                                                        child: Image.asset("assets/images/play.png",width: 20,height: 20,),
                                                      ).marginOnly(left: 5)
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: MediaQuery.of(context).size.width*0.2,
                                        top: 10,
                                        child: InkWell(
                                          onTap: () async {
                                            await controller.updatedStackIndex(index, 1);
                                          },
                                          child: Stack(
                                            children: [
                                              Container(
                                                width: 120,
                                                height: 200,
                                                decoration: BoxDecoration(
                                                    color: AppColors.black,
                                                    border: Border.all(color: AppColors.white,width: 3),
                                                    borderRadius: BorderRadius.circular(15)
                                                ),
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(15),
                                                  child: FadeInImage(
                                                    fit: BoxFit.fill,
                                                    placeholderFit: BoxFit.contain,
                                                    placeholder: AssetImage("assets/images/circle_logo.png"),
                                                    image: CachedNetworkImageProvider('${controller.categoryDeckList![index].wallpaperdata![1].image}'),
                                                  ),

                                                ),
                                              ),
                                              Visibility(
                                                visible: (controller.categoryDeckList![index].wallpaperdata![1].forPremium==1)?true:false,
                                                child: Positioned(
                                                  right: 15,
                                                  top: 10,
                                                  child: Column(
                                                    children: [
                                                      CircleAvatar(
                                                        backgroundColor: Colors.transparent,
                                                        radius: 10,
                                                        child: Icon(Icons.workspace_premium_outlined,color: Colors.white,),
                                                      ),
                                                      SizedBox(height: 10,),

                                                      Container(
                                                        padding: EdgeInsets.symmetric(horizontal: 3,vertical: 2),
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(10),
                                                          color: Colors.white,
                                                        ),
                                                        child: Image.asset("assets/images/play.png",width: 20,height: 20,),
                                                      ).marginOnly(left: 5)
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: MediaQuery.of(context).size.width*0.4,
                                        top: 0,
                                        child: InkWell(
                                          onTap: () async {
                                            await controller.updatedStackIndex(index, 2);

                                            CommonController commonController = Get.find<CommonController>();
                                            commonController.setLoading(true);
                                            AuthenticationController authenticationController = Get.find<AuthenticationController>();
                                            if(controller.categoryDeckList![index].wallpaperdata![2].forPremium ==1){
                                              if(authenticationController.myUser!.data!.isPremium==0 || authenticationController.myUser!.data!.isPremium==null){
                                                commonController.setLoading(false);
                                                showDialog(context: context, builder: (context) {
                                                  return AlertDialog(
                                                    title: Text('premiummember'.tr),
                                                    backgroundColor: AppColors.white,
                                                    elevation: 3,
                                                    content: Text("viewwallpaper".tr),
                                                    actions: [
                                                      InkWell(
                                                          onTap: () async {
                                                            commonController.setLoading(true);
                                                            List<ProductData> data =[];
                                                            Navigator.pop(context);
                                                            data.add(controller.categoryDeckList![index].wallpaperdata![2]);
                                                            await commonController.getReliventData(data);
                                                            await commonController.showRewardedAd(controller.categoryDeckList![index].wallpaperdata![2],true,);
                                                            commonController.setLoading(false);
                                                            // Get.to(()=>SetWallpaperScreen(widget.wallpaper,true));
                                                          },
                                                          child: Text("ViewAd".tr,style: TextStyle(color: Colors.blue),)),
                                                      ElevatedButton(
                                                          style: ElevatedButton.styleFrom(backgroundColor: AppColors.red),
                                                          onPressed: () {
                                                            Navigator.of(context).pop();
                                                            Get.to(()=>PremiumPackage());

                                                          }, child: Text('BuyPremium'.tr,style: TextStyle(color: AppColors.white),))
                                                    ],
                                                  );
                                                },);

                                              }
                                              else{
                                                CommonController commonController = Get.find<CommonController>();
                                                await commonController.setLoading(true);
                                                List<ProductData> data =[];
                                                data!.add(controller.categoryDeckList![index].wallpaperdata![2]);
                                                await commonController.getReliventData(data);
                                                await commonController.setLoading(false);
                                                Get.to(()=>SetWallpaperScreen(controller.categoryDeckList![index].wallpaperdata![2],true));            // await commonController.setCount();


                                              }

                                            }
                                            else{

                                              if(authenticationController.myUser?.data!.isPremium ==0 || authenticationController.myUser?.data!.isPremium ==null){
                                                CommonController commonController = Get.find<CommonController>();
                                                await commonController.setLoading(true);
                                                List<ProductData> data =[];
                                                data!.add(controller.categoryDeckList![index].wallpaperdata![2]);
                                                await commonController.getReliventData(data);
                                                await commonController.setCount();
                                                await commonController.setLoading(false);
                                                Get.to(()=>SetWallpaperScreen(controller.categoryDeckList![index].wallpaperdata![2],true));
                                              }else{
                                                CommonController commonController = Get.find<CommonController>();
                                                await commonController.setLoading(true);
                                                List<ProductData> data =[];
                                                data!.add(controller.categoryDeckList![index].wallpaperdata![2]);
                                                await commonController.getReliventData(data);
                                                await commonController.setLoading(false);
                                                Get.to(()=>SetWallpaperScreen(controller.categoryDeckList![index].wallpaperdata![2],true));
                                              }

                                            }


                                          },
                                          child: Stack(
                                            children: [
                                              Container(
                                                width: 130,
                                                height: 215,
                                                decoration: BoxDecoration(
                                                    color: AppColors.black,
                                                    border: Border.all(color: AppColors.white,width: 3),
                                                    borderRadius: BorderRadius.circular(15)
                                                ),
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(15),
                                                  child: FadeInImage(
                                                    fit: BoxFit.fill,
                                                    placeholderFit: BoxFit.contain,
                                                    placeholder: AssetImage("assets/images/circle_logo.png"),
                                                    image: CachedNetworkImageProvider('${controller.categoryDeckList![index].wallpaperdata![2].image}'),
                                                  ),

                                                ),
                                              ),

                                              Visibility(
                                                visible: (controller.categoryDeckList![index].wallpaperdata![2].forPremium==1)?true:false,
                                                child: Positioned(
                                                  right: 15,
                                                  top: 10,
                                                  child: Column(
                                                    children: [
                                                      CircleAvatar(
                                                        backgroundColor: Colors.transparent,
                                                        radius: 10,
                                                        child: Icon(Icons.workspace_premium_outlined,color: Colors.white,),
                                                      ),
                                                      SizedBox(height: 10,),

                                                      Container(
                                                        padding: EdgeInsets.symmetric(horizontal: 3,vertical: 2),
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(10),
                                                          color: Colors.white,
                                                        ),
                                                        child: Image.asset("assets/images/play.png",width: 20,height: 20,),
                                                      ).marginOnly(left: 5)
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),

                                      Positioned(
                                        top: -16,
                                        right: 2,
                                        child:  InkWell(
                                          onTap: () async {
                                            print("Clicked");
                                            CommonController commonController = Get.find<CommonController>();
                                            AuthenticationController authenticationController = Get.find<AuthenticationController>();
                                            if(authenticationController.myUser!.data!.isPremium==0){
                                              await commonController.setCount();
                                            }
                                            commonController.getSelectedCategoryProduct(commonController.productModelList,controller.categoryDeckList![index].id);
                                            Get.to(()=>RelatedCategoryScreen(CategoryModel(id:controller.categoryDeckList![index].id,name: controller.categoryDeckList![index].name,image: controller.categoryDeckList![index].image)));

                                          },
                                          child: Container(
                                              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                              decoration: BoxDecoration(
                                                  color: AppColors.white,
                                                  borderRadius: BorderRadius.circular(8)
                                              ),
                                              child: Text('SEEALL'.tr,style: TextStyle(color: AppColors.red,fontSize: 18,fontFamily: 'agency',fontWeight: FontWeight.bold),)).marginOnly(right: 0),
                                        ),
                                      )

                                    ],
                                  ),

                                  //Fourth Pic Selected
                                  Stack(
                                    clipBehavior: Clip.none,
                                    children: [

                                      Positioned(
                                        left: 2,
                                        top: 10,
                                        child: InkWell(
                                          onTap: () async {
                                            await controller.updatedStackIndex(index, 0);
                                          },
                                          child: Stack(
                                            children: [
                                              Container(
                                                width: 120,
                                                height: 200,
                                                decoration: BoxDecoration(
                                                    color: AppColors.black,
                                                    border: Border.all(color: AppColors.white,width: 3),
                                                    borderRadius: BorderRadius.circular(15)
                                                ),
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(15),
                                                  child: FadeInImage(
                                                    fit: BoxFit.fill,
                                                    placeholderFit: BoxFit.contain,
                                                    placeholder: AssetImage("assets/images/circle_logo.png"),
                                                    image: CachedNetworkImageProvider('${controller.categoryDeckList![index].wallpaperdata![0].image}'),
                                                  ),

                                                ),
                                              ),
                                              Visibility(
                                                visible: (controller.categoryDeckList![index].wallpaperdata![0].forPremium==1)?true:false,
                                                child: Positioned(
                                                  right: 15,
                                                  top: 10,
                                                  child: Column(
                                                    children: [
                                                      CircleAvatar(
                                                        backgroundColor: Colors.transparent,
                                                        radius: 10,
                                                        child: Icon(Icons.workspace_premium_outlined,color: Colors.white,),
                                                      ),
                                                      SizedBox(height: 10,),

                                                      Container(
                                                        padding: EdgeInsets.symmetric(horizontal: 3,vertical: 2),
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(10),
                                                          color: Colors.white,
                                                        ),
                                                        child: Image.asset("assets/images/play.png",width: 20,height: 20,),
                                                      ).marginOnly(left: 5)
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: MediaQuery.of(context).size.width*0.2,
                                        top: 10,
                                        child: InkWell(
                                          onTap: () async {
                                            await controller.updatedStackIndex(index, 1);
                                          },
                                          child: Stack(
                                            children: [
                                              Container(
                                                width: 120,
                                                height: 200,
                                                decoration: BoxDecoration(
                                                    color: AppColors.black,
                                                    border: Border.all(color: AppColors.white,width: 3),
                                                    borderRadius: BorderRadius.circular(15)
                                                ),
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(15),
                                                  child: FadeInImage(
                                                    fit: BoxFit.fill,
                                                    placeholderFit: BoxFit.contain,
                                                    placeholder: AssetImage("assets/images/circle_logo.png"),
                                                    image: CachedNetworkImageProvider('${controller.categoryDeckList![index].wallpaperdata![1].image}'),
                                                  ),

                                                ),
                                              ),
                                              Visibility(
                                                visible: (controller.categoryDeckList![index].wallpaperdata![1].forPremium==1)?true:false,
                                                child: Positioned(
                                                  right: 15,
                                                  top: 10,
                                                  child: Column(
                                                    children: [
                                                      CircleAvatar(
                                                        backgroundColor: Colors.transparent,
                                                        radius: 10,
                                                        child: Icon(Icons.workspace_premium_outlined,color: Colors.white,),
                                                      ),
                                                      SizedBox(height: 10,),

                                                      Container(
                                                        padding: EdgeInsets.symmetric(horizontal: 3,vertical: 2),
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(10),
                                                          color: Colors.white,
                                                        ),
                                                        child: Image.asset("assets/images/play.png",width: 20,height: 20,),
                                                      ).marginOnly(left: 5)
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: MediaQuery.of(context).size.width*0.4,
                                        top: 10,
                                        child: InkWell(
                                          onTap: () async {
                                            await controller.updatedStackIndex(index, 2);
                                          },
                                          child: Stack(
                                            children: [
                                              Container(
                                                width: 120,
                                                height: 200,
                                                decoration: BoxDecoration(
                                                    color: AppColors.black,
                                                    border: Border.all(color: AppColors.white,width: 3),
                                                    borderRadius: BorderRadius.circular(15)
                                                ),
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(15),
                                                  child: FadeInImage(
                                                    fit: BoxFit.fill,
                                                    placeholderFit: BoxFit.contain,
                                                    placeholder: AssetImage("assets/images/circle_logo.png"),
                                                    image: CachedNetworkImageProvider('${controller.categoryDeckList![index].wallpaperdata![2].image}'),

                                                  ),

                                                ),
                                              ),
                                              Visibility(
                                                visible: (controller.categoryDeckList![index].wallpaperdata![2].forPremium==1)?true:false,
                                                child: Positioned(
                                                  right: 15,
                                                  top: 10,
                                                  child: Column(
                                                    children: [
                                                      CircleAvatar(
                                                        backgroundColor: Colors.transparent,
                                                        radius: 10,
                                                        child: Icon(Icons.workspace_premium_outlined,color: Colors.white,),
                                                      ),
                                                      SizedBox(height: 10,),

                                                      Container(
                                                        padding: EdgeInsets.symmetric(horizontal: 3,vertical: 2),
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(10),
                                                          color: Colors.white,
                                                        ),
                                                        child: Image.asset("assets/images/play.png",width: 20,height: 20,),
                                                      ).marginOnly(left: 5)
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        right: 2,
                                        top: 0,
                                        child: InkWell(
                                          onTap: () async {
                                            await controller.updatedStackIndex(index, 3);

                                            CommonController commonController = Get.find<CommonController>();
                                            commonController.setLoading(true);
                                            AuthenticationController authenticationController = Get.find<AuthenticationController>();
                                            if(controller.categoryDeckList![index].wallpaperdata![3].forPremium ==1){
                                              if(authenticationController.myUser!.data!.isPremium==0 || authenticationController.myUser!.data!.isPremium==null){
                                                commonController.setLoading(false);
                                                showDialog(context: context, builder: (context) {
                                                  return AlertDialog(
                                                    title: Text('premiummember'.tr),
                                                    backgroundColor: AppColors.white,
                                                    elevation: 3,
                                                    content: Text("viewwallpaper".tr),
                                                    actions: [
                                                      InkWell(
                                                          onTap: () async {
                                                            commonController.setLoading(true);
                                                            List<ProductData> data =[];
                                                            Navigator.pop(context);
                                                            data.add(controller.categoryDeckList![index].wallpaperdata![3]);
                                                            await commonController.getReliventData(data);
                                                            await commonController.showRewardedAd(controller.categoryDeckList![index].wallpaperdata![3],true,);
                                                            commonController.setLoading(false);
                                                            // Get.to(()=>SetWallpaperScreen(widget.wallpaper,true));
                                                          },
                                                          child: Text("ViewAd".tr,style: TextStyle(color: Colors.blue),)),
                                                      ElevatedButton(
                                                          style: ElevatedButton.styleFrom(backgroundColor: AppColors.red),
                                                          onPressed: () {
                                                            Navigator.of(context).pop();
                                                            Get.to(()=>PremiumPackage());

                                                          }, child: Text('BuyPremium'.tr,style: TextStyle(color: AppColors.white),))
                                                    ],
                                                  );
                                                },);

                                              }
                                              else{
                                                CommonController commonController = Get.find<CommonController>();
                                                await commonController.setLoading(true);
                                                List<ProductData> data =[];
                                                data!.add(controller.categoryDeckList![index].wallpaperdata![3]);
                                                await commonController.getReliventData(data);
                                                await commonController.setLoading(false);
                                                Get.to(()=>SetWallpaperScreen(controller.categoryDeckList![index].wallpaperdata![3],true));            // await commonController.setCount();


                                              }

                                            }
                                            else{

                                              if(authenticationController.myUser?.data!.isPremium ==0 || authenticationController.myUser?.data!.isPremium ==null){
                                                CommonController commonController = Get.find<CommonController>();
                                                await commonController.setLoading(true);
                                                List<ProductData> data =[];
                                                data!.add(controller.categoryDeckList![index].wallpaperdata![3]);
                                                await commonController.getReliventData(data);
                                                await commonController.setCount();
                                                await commonController.setLoading(false);
                                                Get.to(()=>SetWallpaperScreen(controller.categoryDeckList![index].wallpaperdata![3],true));
                                              }else{
                                                CommonController commonController = Get.find<CommonController>();
                                                await commonController.setLoading(true);
                                                List<ProductData> data =[];
                                                data!.add(controller.categoryDeckList![index].wallpaperdata![3]);
                                                await commonController.getReliventData(data);
                                                await commonController.setLoading(false);
                                                Get.to(()=>SetWallpaperScreen(controller.categoryDeckList![index].wallpaperdata![3],true));
                                              }

                                            }


                                          },
                                          child: Stack(
                                            children: [
                                              Container(
                                                width: 130,
                                                height: 215,
                                                decoration: BoxDecoration(
                                                    color: AppColors.black,
                                                    border: Border.all(color: AppColors.white,width: 3),
                                                    borderRadius: BorderRadius.circular(15)
                                                ),
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(15),
                                                  child: FadeInImage(
                                                    fit: BoxFit.fill,
                                                    placeholderFit: BoxFit.contain,
                                                    placeholder: AssetImage("assets/images/circle_logo.png"),
                                                    image: CachedNetworkImageProvider('${controller.categoryDeckList![index].wallpaperdata![3].image}'),
                                                  ),

                                                ),
                                              ),

                                              Visibility(
                                                visible: (controller.categoryDeckList![index].wallpaperdata![3].forPremium==1)?true:false,
                                                child: Positioned(
                                                  right: 15,
                                                  top: 10,
                                                  child: Column(
                                                    children: [
                                                      CircleAvatar(
                                                        backgroundColor: Colors.transparent,
                                                        radius: 10,
                                                        child: Icon(Icons.workspace_premium_outlined,color: Colors.white,),
                                                      ),
                                                      SizedBox(height: 10,),

                                                      Container(
                                                        padding: EdgeInsets.symmetric(horizontal: 3,vertical: 2),
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(10),
                                                          color: Colors.white,
                                                        ),
                                                        child: Image.asset("assets/images/play.png",width: 20,height: 20,),
                                                      ).marginOnly(left: 5)
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),

                                      Positioned(
                                        top: -20,
                                        right: 2,
                                        child:  GestureDetector(
                                          onTap: () async {
                                            print("Clicked");
                                            CommonController commonController = Get.find<CommonController>();
                                            AuthenticationController authenticationController = Get.find<AuthenticationController>();
                                            if(authenticationController.myUser!.data!.isPremium==0){
                                              await commonController.setCount();
                                            }
                                            commonController.getSelectedCategoryProduct(commonController.productModelList,controller.categoryDeckList![index].id);
                                            Get.to(()=>RelatedCategoryScreen(CategoryModel(id:controller.categoryDeckList![index].id,name: controller.categoryDeckList![index].name,image: controller.categoryDeckList![index].image)));

                                          },
                                          child: Container(
                                              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                              decoration: BoxDecoration(
                                                  color: AppColors.white,
                                                  borderRadius: BorderRadius.circular(8)
                                              ),
                                              child: Text('SEEALL'.tr,style: TextStyle(color: AppColors.red,fontSize: 18,fontFamily: 'agency',fontWeight: FontWeight.bold),)).marginOnly(right: 0),
                                        ),
                                      )

                                    ],
                                  ),


                                ],),
                            ),
                          ],
                        ),
                      );
                    },
                    childCount: controller.categoryDeckList!.length, // Number of items in the list
                  ),
                ),
              ],
            ).marginOnly(top: 10);


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
        },).marginSymmetric(horizontal:10),
      ),
    );
  }
}
