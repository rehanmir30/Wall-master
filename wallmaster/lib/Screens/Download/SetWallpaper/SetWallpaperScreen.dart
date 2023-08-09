import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wallmaster/Constants/AppColors.dart';
import 'package:wallmaster/Controllers/CommonController.dart';
import 'package:wallmaster/CustomWidgets/CustomSnackbar.dart';
import 'package:wallmaster/CustomWidgets/LoadingAnimation.dart';
import 'package:wallmaster/CustomWidgets/ReliventWidget.dart';
import 'package:wallmaster/Model/GetProductModel.dart';
import 'package:wallmaster/Model/LikedWallpaperModel.dart';
import 'package:wallmaster/Screens/Download/EditWallpaper/EditWallpaperScreen.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'package:wallmaster/Screens/Download/SetWallpaper/ReliventImages.dart';
import 'package:wallmaster/Screens/HomeScreen/HomeScreen.dart';

import '../../../CustomWidgets/MixWidget.dart';
import '../../../Model/CategoryModel.dart';

// class SetWallpaperScreen extends StatefulWidget {
//   var productData;
//   bool notFromLike;
//    SetWallpaperScreen(this.productData,this.notFromLike,{super.key});
//
//   @override
//   State<SetWallpaperScreen> createState() => _SetWallpaperScreenState();
// }
//
// class _SetWallpaperScreenState extends State<SetWallpaperScreen> {
//   var initialChildSize =0.11;
//   var minChildSize =0.11;
//   var maxChildSize =0.9;
//   // CommonController commonController = Get.find<CommonController>();
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     check();
//   }
//   check()async{
//     print("IDDDDDDDDDDDD: "+widget.productData.id.toString());
//     CommonController commonController = Get.find<CommonController>();
//     await commonController.isProductLiked(widget.productData.id);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         extendBody: true,
//         extendBodyBehindAppBar: true,
//         appBar: AppBar(
//           backgroundColor: Colors.transparent,
//           elevation: 0,
//           actions: [
//             InkWell(
//                 onTap: (){
//                   Get.to(()=>ReliventImages());
//                 },
//                 child: Icon(Icons.navigate_next)),
//           ],
//
//         ),
//         body: Stack(
//           children: [
//             Container(
//               width: MediaQuery.of(context).size.width,
//               height: MediaQuery.of(context).size.height,
//               decoration: BoxDecoration(
//                 image: DecorationImage(
//                   image: NetworkImage(widget.productData.image.toString()),
//                   fit: BoxFit.fill
//                 )
//               ),
//             ),
//             GestureDetector(
//               onVerticalDragUpdate: (DragUpdateDetails details){
//                 double dragPercentage = details.primaryDelta! / MediaQuery.of(context).size.height;
//
//                 // Update the sheet position by calling setState and modifying the initialChildSize
//                 setState(() {
//                   initialChildSize = (initialChildSize - dragPercentage).clamp(minChildSize, maxChildSize);
//                 });
//               },
//
//               child: DraggableScrollableSheet(
//                 initialChildSize: initialChildSize, // Initial size of the sheet (e.g., 0.2 for 20% of the screen)
//                 minChildSize: minChildSize, // Minimum size of the sheet
//                 maxChildSize: maxChildSize, // Maximum size of the sheet
//                 builder: (BuildContext context, ScrollController scrollController) {
//                   return Container(
//                     decoration: BoxDecoration(
//                       color: AppColors.black ,// Customize the background color
//                       borderRadius: BorderRadius.only(topLeft: Radius.circular(50),topRight: Radius.circular(50)),
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         SizedBox(height: 30,),
//
//                         Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             children: [
//                               GetBuilder<CommonController>(builder: (controller) {
//                                 return InkWell(
//                                     onTap: () async {
//                                       await controller.setLoading(true);
//                                       await controller.updateLikeProduct(widget.productData.id, widget.notFromLike);
//                                       await controller.setLiked(true);
//                                       await controller.setLoading(false);
//                                     },
//                                     child: (controller.isLiked==true)
//                                         ?Icon(CupertinoIcons.heart_fill,color: Colors.white,)
//                                         :Icon(CupertinoIcons.heart,color: Colors.white,));
//                               },),
//                               InkWell(
//                                   onTap: (){
//                                     showModalBottomSheet(
//                                       barrierColor: Colors.transparent,
//                                       backgroundColor: Color(0xff282828),
//                                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(15),topLeft: Radius.circular(15))),
//                                       context: context,
//                                       builder: (BuildContext context) {
//                                         return WallpaperBottomSheet(widget.productData.image);
//                                       },
//                                     );
//
//
//                                   },
//                                   child: Icon(Icons.phone_android_outlined,color: Colors.white,)),
//                               InkWell(
//                                   onTap: () async {
//                                     downloadImage(widget.productData.image!,context);
//                                   },
//                                   child: Icon(Icons.download,color: Colors.white,)),
//                               InkWell(
//                                   onTap: ()async{
//                                     Get.to(()=>EditWallPaperScreen(widget.productData.image));
//                                   },
//                                   child: Icon(Icons.crop,color: Colors.white,))
//
//                             ]),
//                         SizedBox(height: 21,),
//                         Expanded(
//                           child: GetBuilder<CommonController>(builder: (commonController) {
//                             return (commonController.productReliventData!.length==0 ||commonController.productReliventData!.length==null)
//                                 ?Center(child: Text("NoRelatedWallpaper".tr,style: TextStyle(color: AppColors.white,fontSize: 18),),)
//                                 :GridView.builder(
//                               shrinkWrap: true,
//                               primary: true,
//                               itemCount: commonController.productReliventData!.length,
//                               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                                 // crossAxisSpacing: 10.0,
//                                   mainAxisSpacing: 1.0,
//                                   mainAxisExtent: 300,
//                                   crossAxisCount: 2),
//                               itemBuilder: (context, index) {
//                                 // return CommonWidget(commonController.productModelList!.data![index]);
//                                 return ReliventWidget(commonController.productReliventData![index]);
//
//                               },).marginSymmetric(horizontal: 10);
//                           },),
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             ),
//
//            GetBuilder<CommonController>(builder: (commonController) {
//              return  Visibility(
//                  visible: commonController.isLoading,
//                  child: LoadingAnimation(),
//                  );
//            },)
//           ],
//         ),
//
//       ),
//     );
//   }
// }


void downloadImage(String imageUrl, BuildContext context) async {
  CommonController _commonController = Get.find<CommonController>();
  _commonController.setLoading(true);

  // Fetch the image data from the provided URL
  http.Response response = await http.get(Uri.parse(imageUrl));
  Uint8List imageData = response.bodyBytes;

  PermissionStatus status = await Permission.storage.request();
  if (status != PermissionStatus.granted) {
    await Permission.storage.request();
  }

  final directory = Directory('/storage/emulated/0/Download');
  UniqueKey k = UniqueKey();
  final imagePath = "${directory.path}/${k}.png";

  File imageFile = File(imagePath);
  imageFile.writeAsBytesSync(imageData);

  final result = await ImageGallerySaver.saveFile(imagePath);

  if (result["isSuccess"]) {
    // Wallpaper saved successfully
    String wallpaperPath = result["filePath"];
    CustomSnackbar.show('WallpaperDownloadedSuccessfully'.tr, AppColors.green);
    _commonController.setLoading(false);
  } else {
    CustomSnackbar.show('WallpaperDownloadFailed'.tr, AppColors.red);
    _commonController.setLoading(false);
  }
}



class WallpaperBottomSheet extends StatelessWidget {
  CommonController _commonController = Get.find<CommonController>();
  var wallpaper;

  WallpaperBottomSheet(this.wallpaper,{super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // color: Colors.white
        borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15)),

      ),
      child: Wrap(
        children: [
          ListTile(
            title: Text('SetWallpaper'.tr,textAlign: TextAlign.center,style: TextStyle(color: Colors.yellowAccent,fontSize: 24,fontWeight: FontWeight.bold),),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.lock,color: Colors.white,),
            title: Text('LockScreen'.tr,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 23)),
            onTap: () async {
              Navigator.of(context).pop();
              _commonController.setLoading(true);
              // Fetch the image data from the provided URL
              http.Response response = await http.get(Uri.parse(wallpaper));
              Uint8List imageData = response.bodyBytes;

              PermissionStatus status = await Permission.storage.request();
              if(status!=PermissionStatus.granted){
                print("Not Granted");
                await Permission.storage.request();
              }

              final directory =  await getTemporaryDirectory();
              // final  directory = Directory('/storage/emulated/0/Download');
              UniqueKey k = UniqueKey();
              final imagePath = "${directory.path}/${k}.png";

              File imageFile = File(imagePath);
              imageFile.writeAsBytesSync(imageData);

              final results = await WallpaperManager.setWallpaperFromFile(
                imagePath,
                WallpaperManager.LOCK_SCREEN, // Set// wallpaper for the home screen
              );
              if(results==true){

                print("Success");
                CustomSnackbar.show('WallpaperUpdatedSuccessfully'.tr,AppColors.green);

                // Get.snackbar(
                //   'Wallpaper Updated Successfully',
                //   "",
                //   snackPosition: SnackPosition.BOTTOM,
                //   duration: Duration(seconds: 1),
                // );

                 _commonController.setLoading(false);
              }else{
                print("Fail");
                CustomSnackbar.show('WallpaperUpdateFailed'.tr,AppColors.red);
                // Get.snackbar(
                //   'Wallpaper Update failed',
                //   "",
                //   snackPosition: SnackPosition.BOTTOM,
                //   duration: Duration(seconds: 1),
                // );

                 _commonController.setLoading(false);
              }

            },
          ),
          ListTile(
            leading: Icon(Icons.home,color: Colors.white,),
            title: Text('HomeScreen'.tr,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 23)),
            onTap: () async {
              Navigator.of(context).pop();
              _commonController.setLoading(true);

              // ByteData byteData = await rootBundle.load(wallpaper);
              // Uint8List imageData = byteData.buffer.asUint8List();

              // Fetch the image data from the provided URL
              http.Response response = await http.get(Uri.parse(wallpaper));
              Uint8List imageData = response.bodyBytes;

              PermissionStatus status = await Permission.storage.request();
              if(status!=PermissionStatus.granted){
                await Permission.storage.request();
              }

              final directory =  await getTemporaryDirectory();
              // final  directory = Directory('/storage/emulated/0/Download');
              UniqueKey k = UniqueKey();
              final imagePath = "${directory.path}/${k}.png";

              File imageFile = File(imagePath);
              imageFile.writeAsBytesSync(imageData);

              final results = await WallpaperManager.setWallpaperFromFile(
                imagePath,
                WallpaperManager.HOME_SCREEN, // Set// wallpaper for the home screen
              );
              if(results==true){
                print("Success");
                CustomSnackbar.show('WallpaperUpdatedSuccessfully'.tr,AppColors.green);
                // Get.snackbar(
                //   'Wallpaper Updated Successfully',
                //   "",
                //   snackPosition: SnackPosition.BOTTOM,
                //   duration: Duration(seconds: 1),
                // );

                _commonController.setLoading(false);
              }else{
                print("Fail");
                CustomSnackbar.show('WallpaperUpdateFailed'.tr,AppColors.red);
                // Get.snackbar(
                //   'Wallpaper Update failed',
                //   "",
                //   snackPosition: SnackPosition.BOTTOM,
                //   duration: Duration(seconds: 1),
                // );

                _commonController.setLoading(false);
              }


            },
          ),
          ListTile(
            leading: Icon(Icons.phone_android,color: Colors.white,),
            title: Text('Both'.tr,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 23)),
            onTap: () async {
              Navigator.of(context).pop();
              _commonController.setLoading(true);

              // ByteData byteData = await rootBundle.load(wallpaper);
              // Uint8List imageData = byteData.buffer.asUint8List();

              // Fetch the image data from the provided URL
              http.Response response = await http.get(Uri.parse(wallpaper));
              Uint8List imageData = response.bodyBytes;

              PermissionStatus status = await Permission.storage.request();
              if(status!=PermissionStatus.granted){
                await Permission.storage.request();
              }

              final directory =  await getTemporaryDirectory();
              // final  directory = Directory('/storage/emulated/0/Download');
              UniqueKey k = UniqueKey();
              final imagePath = "${directory.path}/${k}.png";

              File imageFile = File(imagePath);
              imageFile.writeAsBytesSync(imageData);

              final results = await WallpaperManager.setWallpaperFromFile(
                imagePath,
                WallpaperManager.BOTH_SCREEN, // Set// wallpaper for the home screen
              );
              if(results==true){
                print("Success");
                CustomSnackbar.show('WallpaperUpdatedSuccessfully'.tr,AppColors.green);
                // Get.snackbar(
                //   'Wallpaper Updated Successfully',
                //   "",
                //   snackPosition: SnackPosition.BOTTOM,
                //   duration: Duration(seconds: 1),
                // );

                _commonController.setLoading(false);
              }else{
                print("Fail");
                CustomSnackbar.show('WallpaperUpdateFailed'.tr,AppColors.red);
                // Get.snackbar(
                //   'Wallpaper Update failed',
                //   "",
                //   snackPosition: SnackPosition.BOTTOM,
                //   duration: Duration(seconds: 1),
                // );

                _commonController.setLoading(false);
              }
            },
          ),
        ],
      ),
    );
  }
}




class SetWallpaperScreen extends StatefulWidget {
  var productData;
  bool notFromLike;
   SetWallpaperScreen(this.productData,this.notFromLike,{super.key});

  @override
  State<SetWallpaperScreen> createState() => _SetWallpaperScreenState();
}

class _SetWallpaperScreenState extends State<SetWallpaperScreen> {
  int _index= 0;
  List<LikeProductData> data=[];

    @override
  void initState() {
    // TODO: implement initState
    super.initState();
    check();
  }
  check()async{
    print("IDDDDDDDDDDDD: "+widget.productData.id.toString());
    CommonController commonController = Get.find<CommonController>();
    await commonController.isProductLiked(widget.productData.id);
    if(widget.notFromLike==false){
      data.add(widget.productData);
    }
  }

  Future<bool> returnBack()async{
      Get.back();

      return true;
}

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return returnBack();

      },
      child: (widget.notFromLike==false)
          ?Scaffold(
        extendBodyBehindAppBar: true,
        extendBody: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          leading: IconButton(
              onPressed: () {
                returnBack();

              },icon: Icon(Icons.arrow_back,color: AppColors.white,)),
          elevation: 0,
          actions: [

            IconButton(onPressed: () {
              CommonController commonController = Get.find<CommonController>();
              Get.to(()=>EditWallPaperScreen(data[_index].image!));
            }, icon: Icon(Icons.edit,color: Colors.white,))
          ],
        ),
        body: GetBuilder<CommonController>(builder: (controller) {
          return  Stack(
            children: [
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(data[_index].image!),
                        fit: BoxFit.cover,
                      )
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 50.0, sigmaY: 50.0),
                    child: Container(
                      decoration: BoxDecoration(color: Colors.white.withOpacity(0.0)),
                    ),
                  )
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.75,
                    child: CarouselSlider.builder(
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index, int realIndex) {
                        final item = data[index];

                        return Container(
                          color: Colors.transparent,
                          child: CachedNetworkImage(
                            imageUrl: item.image!,
                            placeholder: (context, url) => Image.asset('assets/images/circle_logo.png'),
                            errorWidget: (context, url, error) => Icon(Icons.error),
                          ),
                        ).marginSymmetric(horizontal: 0);
                      },
                      options: CarouselOptions(
                        scrollPhysics: BouncingScrollPhysics(),
                        enlargeCenterPage: true,
                        viewportFraction: 0.76,
                        height: MediaQuery.of(context).size.height * 0.8,
                        enableInfiniteScroll: false,
                        initialPage: 0,
                        scrollDirection: Axis.horizontal,
                        onPageChanged: (int index, CarouselPageChangedReason reason) async {
                          setState(() {
                            _index = index;
                          });
                          controller.isProductLiked(data[index].id);
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(
                          onTap: () async {
                            await controller.setLoading(true);
                            await controller.updateLikeProduct(data[_index].id, widget.notFromLike);
                            await controller.setLiked(true);
                            await controller.setLoading(false);
                          },
                          child: (controller.isLiked==true)
                              ?Icon(CupertinoIcons.heart_fill,color: Colors.white,)
                              :Icon(CupertinoIcons.heart,color: Colors.white,)).marginSymmetric(horizontal: 10),
                      InkWell(
                        onTap: (){
                          showModalBottomSheet(
                            barrierColor: Colors.transparent,
                            backgroundColor: Color(0xff282828),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(15),topLeft: Radius.circular(15))),
                            context: context,
                            builder: (BuildContext context) {
                              return WallpaperBottomSheet(data[_index].image);
                            },
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.all(17),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white
                          ),
                          child: Icon(Icons.mobile_screen_share_sharp,size: 30,),
                        ).marginSymmetric(horizontal: 10),
                      ),
                      InkWell(
                          onTap: (){
                            downloadImage(data[_index].image!,context);
                          },
                          child: Icon(Icons.download,size: 34,color: Colors.white,).marginSymmetric(horizontal: 10))

                    ],),
                ],).marginSymmetric(horizontal: 0,vertical: 10),

              Visibility(
                  visible: controller.isLoading,
                  child: LoadingAnimation())
            ],);
        },),
      )

          :Scaffold(
        extendBodyBehindAppBar: true,
        extendBody: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          leading: IconButton(
              onPressed: () {
                returnBack();

          },icon: Icon(Icons.arrow_back,color: AppColors.white,)),
          elevation: 0,
          actions: [

            IconButton(onPressed: () {
              CommonController commonController = Get.find<CommonController>();
              Get.to(()=>EditWallPaperScreen(commonController.productReliventData![_index].image));
            }, icon: Icon(Icons.edit,color: Colors.white,))
          ],
        ),
        body: GetBuilder<CommonController>(builder: (controller) {
          return  Stack(
            children: [
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(controller.productReliventData![_index].image!),
                        fit: BoxFit.cover,
                      )
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 50.0, sigmaY: 50.0),
                    child: Container(
                      decoration: BoxDecoration(color: Colors.white.withOpacity(0.0)),
                    ),
                  )
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.75,
                    child: CarouselSlider.builder(
                      itemCount: controller.productReliventData!.length,
                      itemBuilder: (BuildContext context, int index, int realIndex) {
                        final item = controller.productReliventData![index];

                        return Container(
                          color: Colors.transparent,
                          child: CachedNetworkImage(
                            imageUrl: item.image!,
                            placeholder: (context, url) => Image.asset('assets/images/circle_logo.png'),
                            errorWidget: (context, url, error) => Icon(Icons.error),
                          ),
                        ).marginSymmetric(horizontal: 0);
                      },
                      options: CarouselOptions(
                        scrollPhysics: BouncingScrollPhysics(),
                        enlargeCenterPage: true,
                        viewportFraction: 0.76,
                        height: MediaQuery.of(context).size.height * 0.8,
                        enableInfiniteScroll: false,
                        initialPage: 0,
                        scrollDirection: Axis.horizontal,
                        onPageChanged: (int index, CarouselPageChangedReason reason) async {
                          setState(() {
                            _index = index;
                          });
                          controller.isProductLiked(controller.productReliventData![index].id);
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(
                          onTap: () async {
                            await controller.setLoading(true);
                            await controller.updateLikeProduct(controller.productReliventData![_index].id, widget.notFromLike);
                            await controller.setLiked(true);
                            await controller.setLoading(false);
                          },
                          child: (controller.isLiked==true)
                              ?Icon(CupertinoIcons.heart_fill,color: Colors.white,)
                              :Icon(CupertinoIcons.heart,color: Colors.white,)).marginSymmetric(horizontal: 10),
                      InkWell(
                        onTap: (){
                          showModalBottomSheet(
                            barrierColor: Colors.transparent,
                            backgroundColor: Color(0xff282828),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(15),topLeft: Radius.circular(15))),
                            context: context,
                            builder: (BuildContext context) {
                              return WallpaperBottomSheet(controller.productReliventData![_index].image);
                            },
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.all(17),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white
                          ),
                          child: Icon(Icons.mobile_screen_share_sharp,size: 30,),
                        ).marginSymmetric(horizontal: 10),
                      ),
                      InkWell(
                          onTap: (){
                            downloadImage(controller.productReliventData![_index].image!,context);
                          },
                          child: Icon(Icons.download,size: 34,color: Colors.white,).marginSymmetric(horizontal: 10))

                    ],),
                ],).marginSymmetric(horizontal: 0,vertical: 10),

              Visibility(
                  visible: controller.isLoading,
                  child: LoadingAnimation())
            ],);
        },),
      ),
    );
  }
}




/////////////////////////////////////////////////////////////////////////////////////

