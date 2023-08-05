import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallmaster/Controllers/CommonController.dart';
import 'package:wallmaster/CustomWidgets/CustomSnackbar.dart';
import 'package:wallmaster/CustomWidgets/LikeWidget.dart';
import 'package:wallmaster/CustomWidgets/MixWidget.dart';

import '../../../../../../Constants/AppColors.dart';
import '../../../../../../CustomWidgets/CommonWidget.dart';
import '../../../../../Controllers/AuthenticationController.dart';
import '../../Category/RelatedCategoryScreen.dart';




class LikedPremiumSheet extends StatefulWidget {
  const LikedPremiumSheet({super.key});

  @override
  State<LikedPremiumSheet> createState() => _LikedPremiumSheetState();
}

class _LikedPremiumSheetState extends State<LikedPremiumSheet> {
  CommonController commonCont = Get.find<CommonController>();
  var textController = TextEditingController();
  final List<int> timeOptions = [1, 2, 3, 4, 5];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Premium Feature'.tr,textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 26,fontWeight: FontWeight.bold),),
              InkWell(
                  onTap: (){
                    Get.back();
                  },
                  child: Icon(Icons.clear,color: AppColors.white,)),
            ],).marginSymmetric(vertical: 10),
          SizedBox(height: 10,),

          Text('Please select time for wallpaper to change.',style: TextStyle(color: AppColors.white,fontSize: 14,fontWeight: FontWeight.normal),),
          SizedBox(height: 10,),

          Text('Set Timer',style: TextStyle(color: AppColors.white,fontSize: 18,fontWeight: FontWeight.bold),),

          SizedBox(height: 10,),



          GetBuilder<CommonController>(builder: (commonController) {
            return Column(
              children: [
                if(commonController.workManagerMagazine==false)Row(
                  children: [
                    Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width*0.27,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: AppColors.white,width: 1)
                        ),
                        child: TextFormField(
                          textAlign: TextAlign.center,
                          controller: textController,
                          readOnly: true,
                          style: TextStyle(color: AppColors.white),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(borderSide: BorderSide(color: AppColors.white,width: 1)),
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.white,width: 1)),
                            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.white,width: 1)),
                          ),
                          onTap: ()async{

                            int? selectedTime = await showDialog<int>(context: context, builder: (context) {
                              return AlertDialog(
                                title: Text('Set Wallpaper Change Time'),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: timeOptions
                                      .map(
                                        (time) => GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).pop(time);

                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(vertical: 16),
                                        decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(color: Colors.grey.shade300),
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            '$time minute${time == 1 ? '' : 's'}',
                                            style: TextStyle(fontSize: 18),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                      .toList(),
                                ),
                              );
                            },);

                            if(selectedTime!=null){
                              textController.text = selectedTime.toString();
                            }

                          },
                        )
                    ),
                    SizedBox(width: 20,),
                    Text("Minutes",style: TextStyle(color: AppColors.white,fontSize: 18),)
                  ],
                ),
                SizedBox(height: 30,),
                InkWell(
                  onTap: () async {
                    if(textController.text.isEmpty && commonController.workManagerMagazine==false){
                      CustomSnackbar.show('Please select time', AppColors.red);
                    }else{
                      if(commonController.likedWallpaperModel!.data!.length==null || commonController.likedWallpaperModel!.data!.length<3 ){

                        CustomSnackbar.show('Wallpaper album should have at least 3 wallpapers', AppColors.red);

                      }else{
                        if(commonController.workManagerMagazine==false){
                          await commonController.startWorkManagerLikeWallpaperTask(textController.text);
                        }else{
                          await commonController.stopWorkManagerTasks();
                        }
                        await commonController.setMagazine(!commonController.workManagerMagazine);
                        Get.back();
                      }
                    }

                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    decoration: BoxDecoration(color: AppColors.red,borderRadius: BorderRadius.circular(10)),
                    child: Text((commonController.workManagerMagazine==true)?'Stop':'Start',style: TextStyle(color: AppColors.white),),),
                ),
              ],
            );
          },),

        ],
      ).marginSymmetric(horizontal: 15),
    );
  }
}



class LikedWallpaperScreen extends StatefulWidget {
  const LikedWallpaperScreen({super.key});

  @override
  State<LikedWallpaperScreen> createState() => _LikedWallpaperScreenState();
}

class _LikedWallpaperScreenState extends State<LikedWallpaperScreen> {
  CommonController commonController = Get.find<CommonController>();
  bool value = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        backgroundColor: AppColors.black,
        elevation: 0,
        title: Text("LikedWallpaper".tr),
        centerTitle: true,
        leading: InkWell(
            onTap: (){
              Get.back();
            },
            child: Icon(Icons.arrow_back_ios_new_rounded,size: 24,color: AppColors.white,)),

        actions:  [

          InkWell(
              onTap: ()async{
                AuthenticationController authController = Get.find<AuthenticationController>();
                // if(authController.myUser!.data!.isPremium==1){
                //
                  showModalBottomSheet(
                    barrierColor: Colors.transparent,
                    backgroundColor: Color(0xff282828),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(15),topLeft: Radius.circular(15))),
                    context: context,
                    builder: (BuildContext context) {
                      return LikedPremiumSheet();
                    },
                  );
                //
                //
                // }else{
                //   showModalBottomSheet(
                //     barrierColor: Colors.transparent,
                //     backgroundColor: Color(0xff282828),
                //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(15),topLeft: Radius.circular(15))),
                //     context: context,
                //     builder: (BuildContext context) {
                //       return NotPremiumSheet('');
                //     },
                //   );
                // }
              },
              child: Row(
                children: [

                  Image.asset('assets/images/crown.png',width: 25,height: 25),
                  Text('AutoChange'.tr),
                ],
              ).marginSymmetric(horizontal: 10)
          )



        // GetBuilder<CommonController>(builder: (commonController) {
        //   return  InkWell(
        //       onTap: () async {
        //        if(commonController.likedWallpaperModel!.data!.length==null || commonController.likedWallpaperModel!.data!.length<10 ){
        //
        //          CustomSnackbar.show('Wallpaper album should have at least 10 wallpapers', AppColors.red);
        //
        //        }else{
        //          if(commonController.workManagerMagazine==false){
        //            await commonController.startWorkManagerLikeWallpaperTask();
        //          }else{
        //            await commonController.stopWorkManagerTasks();
        //          }
        //          await commonController.setMagazine(!commonController.workManagerMagazine);
        //        }
        //
        //       },
        //       child: Container(
        //           alignment: Alignment.center,
        //           child: (commonController.workManagerMagazine==false)
        //               ?Text('Play ',style: TextStyle(color: AppColors.white),)
        //               :Text('Stop',style: TextStyle(color: AppColors.white),)
        //       ).marginSymmetric(horizontal: 10)
        //   );
        // },),


        ],
      ),

      body:  GetBuilder<CommonController>(builder: (controller) {
        return (controller.likedWallpaperModel!.data?.length==0 || controller.likedWallpaperModel!.data?.length==null)
            ?Center(child: Text("No wallpaper",style: TextStyle(color: AppColors.white,fontSize: 18),),)
            :GridView.builder(
          shrinkWrap: true,
          primary: true,
          itemCount: controller.likedWallpaperModel!.data!.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 0.0,
              mainAxisSpacing: 0.0,
              mainAxisExtent: 230,
              crossAxisCount: 3),
          itemBuilder: (context, index) {
            return LikeWidget(controller.likedWallpaperModel!.data![index]);

          },).marginSymmetric(horizontal: 30);
      },)
    );
  }
}
