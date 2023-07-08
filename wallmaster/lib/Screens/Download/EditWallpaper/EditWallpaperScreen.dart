import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wallmaster/Constants/AppColors.dart';
import 'package:wallmaster/Constants/filters.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'dart:ui' as ui;
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:wallmaster/CustomWidgets/LoadingAnimation.dart';

import '../../../Controllers/CommonController.dart';
import '../../../CustomWidgets/CustomSnackbar.dart';


class EditWallPaperScreen extends StatefulWidget {
  var wallpaper;
  EditWallPaperScreen(this.wallpaper, {Key? key}) : super(key: key);

  @override
  State<EditWallPaperScreen> createState() => _EditWallPaperScreenState();
}

class _EditWallPaperScreenState extends State<EditWallPaperScreen> {
  final GlobalKey _globalKey = GlobalKey();
  final List<List<double>> filters = [
    filterColor.Original_MATRIX,
    filterColor.SEPIA_MATRIX,
    filterColor.GREYSCALE_MATRIX,
    filterColor.VINTAGE_MATRIX,
    filterColor.SWEET_MATRIX,
    filterColor.SAD_MATRIX,
    filterColor.NO_COLOR,
  ];

  int selectedFilterIndex = 0; // Track the selected filter index
  


  void convertWidgetToImage() async {
    CommonController commonController = Get.find<CommonController>();
    await commonController.setLoading(true);
    RenderRepaintBoundary repaintBoundary = _globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image boxImage = await repaintBoundary.toImage(pixelRatio: 10.0);
    ByteData? byteData = await boxImage.toByteData(format: ui.ImageByteFormat.png);
    Uint8List uint8list = byteData!.buffer.asUint8List();

    final directory = await getTemporaryDirectory();
    final imagePath = "${directory.path}/wallpaper.png";

    File imageFile = File(imagePath);
    imageFile.writeAsBytesSync(uint8list);

    await commonController.setLoading(false);

    showModalBottomSheet(
      barrierColor: Colors.transparent,
      backgroundColor: Color(0xff282828),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(15),topLeft: Radius.circular(15))),
      context: context,
      builder: (BuildContext context) {
        return WallpaperBottomSheet(imagePath,context);
      },
    );

  }
  Future<String> convertFilterToImage() async {
    CommonController commonController = Get.find<CommonController>();
    await commonController.setLoading(true);
    RenderRepaintBoundary repaintBoundary = _globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image boxImage = await repaintBoundary.toImage(pixelRatio: 10.0);
    ByteData? byteData = await boxImage.toByteData(format: ui.ImageByteFormat.png);
    Uint8List uint8list = byteData!.buffer.asUint8List();

    final directory = await getTemporaryDirectory();
    final imagePath = "${directory.path}/wallpaper.png";

    File imageFile = File(imagePath);
    imageFile.writeAsBytesSync(uint8list);

    await commonController.setLoading(false);

    return imagePath;
  }

  Future<void> cropFilteredImage() async {
    var imageUrl = await convertFilterToImage();
    // ImagePicker picker = ImagePicker();
    // final pickedFile = await picker.getImage(source: ImageSource.gallery);

    final croppedFile = await ImageCropper().cropImage(
      compressFormat: ImageCompressFormat.png,
      sourcePath: imageUrl,
      aspectRatioPresets: [
        CropAspectRatioPreset.original,

      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Crop',
            toolbarColor: AppColors.black,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            activeControlsWidgetColor: Color(0xffA61892),
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        ),
        WebUiSettings(
          context: context,
        ),
      ],
    );

    // Handle the cropped file (e.g., display, upload, etc.)
    if (croppedFile != null) {
      // Do something with the cropped file
      showModalBottomSheet(
        barrierColor: Colors.transparent,
        backgroundColor: Color(0xff282828),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(15),topLeft: Radius.circular(15))),
        context: context,
        builder: (BuildContext context) {
          return WallpaperBottomSheet(croppedFile.path,context);
        },
      );
    } else {
      // Crop operation was canceled or failed
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final Image image = Image.network(
      widget.wallpaper.toString(),
      width: size.width,
      fit: BoxFit.cover,
    );

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text("ImageFilters".tr),
        backgroundColor: AppColors.black.withOpacity(0.3),
        elevation: 0,
        actions: [
          IconButton(onPressed: () async {

            await cropFilteredImage();
            //
            // showModalBottomSheet(
            //   barrierColor: Colors.transparent,
            //   backgroundColor: Color(0xff282828),
            //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(15),topLeft: Radius.circular(15))),
            //   context: context,
            //   builder: (BuildContext context) {
            //     return WallpaperBottomSheet(croppedFile?.path,context);
            //   },
            // );



          }, icon: Icon(Icons.crop)),
          IconButton(icon: Icon(Icons.check), onPressed: convertWidgetToImage),
        ],
      ),
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Center(
                  child: RepaintBoundary(
                    key: _globalKey,
                    child: Container(
                      constraints: BoxConstraints(
                        maxWidth: size.width,
                        maxHeight: size.height,
                        minHeight: size.height,
                      ),
                      child: ColorFiltered(
                        colorFilter: ColorFilter.matrix(filters[selectedFilterIndex]),
                        child: image,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: 80,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: filters.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedFilterIndex = index;
                        });
                      },
                      child: Container(
                        width: 60,
                        height: 60,
                        margin: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: selectedFilterIndex == index ? 2 : 0),
                        ),
                        child: ColorFiltered(
                          colorFilter: ColorFilter.matrix(filters[index]),
                          child: image,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),

          GetBuilder<CommonController>(builder: (commonController) {
            return Visibility(
                visible: commonController.isLoading,
                child: LoadingAnimation());
          },)
        ],
      ),
    );
  }
}


class WallpaperBottomSheet extends StatelessWidget {
  CommonController _commonController = Get.find<CommonController>();
  var wallpaper;
  var lastcontext;

  WallpaperBottomSheet(this.wallpaper,this.lastcontext,{super.key});

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
            title: Text('SetWallpaper'.tr,textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.lock,color: Colors.white,),
            title: Text('LockScreen'.tr,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
            onTap: () async {
              Navigator.of(context).pop();
              _commonController.setLoading(true);
              // ByteData byteData = await rootBundle.load(wallpaper);
              //
              // Uint8List imageData = byteData.buffer.asUint8List();

              PermissionStatus status = await Permission.storage.request();
              if(status!=PermissionStatus.granted){
                print("Not Granted");
                await Permission.storage.request();
              }

              // final directory =  await getTemporaryDirectory();
              // final  directory = Directory('/storage/emulated/0/Download');
              // final imagePath = "${directory.path}/wallpaper.png";

              // File imageFile = File(imagePath);
              // imageFile.writeAsBytesSync(imageData);
              final results = await WallpaperManager.setWallpaperFromFile(
                wallpaper,
                WallpaperManager.LOCK_SCREEN,

                // Set// wallpaper for the home screen
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
                Get.back();
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
            title: Text('HomeScreen'.tr,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
            onTap: () async {
              Navigator.of(context).pop();
              _commonController.setLoading(true);

              // ByteData byteData = await rootBundle.load(wallpaper);
              // Uint8List imageData = byteData.buffer.asUint8List();

              PermissionStatus status = await Permission.storage.request();
              if(status!=PermissionStatus.granted){
                await Permission.storage.request();
              }

              final results = await WallpaperManager.setWallpaperFromFile(
                wallpaper,
                WallpaperManager.HOME_SCREEN, // Set// wallpaper for the home screen
              );
              if(results==true){
                print("Success");
                CustomSnackbar.show('WallpaperUpdatedSuccessfully'.tr,AppColors.green);

                _commonController.setLoading(false);
                Get.back();
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
            title: Text('Both'.tr,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
            onTap: () async {
              Navigator.of(context).pop();
              _commonController.setLoading(true);

              // ByteData byteData = await rootBundle.load(wallpaper);
              // Uint8List imageData = byteData.buffer.asUint8List();

              PermissionStatus status = await Permission.storage.request();
              if(status!=PermissionStatus.granted){
                await Permission.storage.request();
              }

              // final directory =  await getTemporaryDirectory();
              // final  directory = Directory('/storage/emulated/0/Download');
              // final imagePath = "${directory.path}/wallpaper.png";
              //
              // File imageFile = File(imagePath);
              // imageFile.writeAsBytesSync(imageData);

              final results = await WallpaperManager.setWallpaperFromFile(
                wallpaper,
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
                Get.back();
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