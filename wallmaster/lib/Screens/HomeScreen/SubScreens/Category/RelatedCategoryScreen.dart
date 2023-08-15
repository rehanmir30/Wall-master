import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallmaster/Controllers/AuthenticationController.dart';
import 'package:wallmaster/Screens/HomeScreen/SubScreens/Drawer/PremiumPackages/PremiumPackage.dart';

import '../../../../../Constants/AppColors.dart';
import '../../../../../Controllers/CommonController.dart';
import '../../../../Controllers/LocalizationController.dart';
import '../../../../CustomWidgets/CustomSnackbar.dart';
import '../../../../CustomWidgets/LoadingAnimation.dart';
import '../../../../CustomWidgets/MixWidget.dart';
import '../../../../Model/CategoryModel.dart';



class NotPremiumSheet extends StatelessWidget {
  CommonController _commonController = Get.find<CommonController>();
  var wallpaper;

  NotPremiumSheet(this.wallpaper,{super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 800,
      decoration: BoxDecoration(
        // color: Colors.white
        borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15)),

      ),
      child: SingleChildScrollView(
        child: Column(
          children: [

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('premiumOffer'.tr,textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 26,fontWeight: FontWeight.bold),),

                Image.asset('assets/images/crown.png',width: 40,height: 40,),
                // InkWell(
                //     onTap: (){
                //       Get.back();
                //     },
                //     child: Icon(Icons.clear,color: AppColors.white,)),
              ],).marginOnly(top: 10,left: 15,right: 15,bottom: 5),

            // Lottie.asset('assets/images/premiumCrown.json',),
            Align(
                alignment: Alignment.centerLeft,
                child: Text("youget".tr,style: TextStyle(color: Colors.yellowAccent,fontSize: 22),).marginSymmetric(horizontal: 15)),

            SizedBox(height: 10,),
            Row(
              children: [
                // Icon(Icons.done_sharp,color: Colors.greenAccent,size: 18,),
                Image.asset('assets/images/check_mark.png',width: 14,height: 14,fit: BoxFit.fill,),
                SizedBox(width: 2,),
                Text("Access".tr,style: TextStyle(color: Colors.white,fontSize: 15),),
              ],).marginOnly(left: 18),
            Row(
              children: [
                // Icon(Icons.done_outlined,color: Colors.greenAccent,size: 18,),
                Image.asset('assets/images/check_mark.png',width: 14,height: 14,fit: BoxFit.fill,),
                SizedBox(width: 2,),
                Text("ExclusivePremium".tr,style: TextStyle(color: Colors.white,fontSize: 15),),
              ],).marginOnly(left: 18),
            Row(
              children: [
                // Icon(Icons.done_outlined,color: Colors.greenAccent,size: 18,),
                Image.asset('assets/images/check_mark.png',width: 14,height: 14,fit: BoxFit.fill,),
                SizedBox(width: 2,),
                Text("NoAd".tr,style: TextStyle(color: Colors.white,fontSize: 15),),
              ],).marginOnly(left: 18),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icon(Icons.done_outlined,color: Colors.greenAccent,size: 18,),
                Image.asset('assets/images/check_mark.png',width: 14,height: 14,fit: BoxFit.fill,),
                SizedBox(width: 2,),
                Expanded(child: Text("AutomticCategory".tr,style: TextStyle(color: Colors.white,fontSize: 15),)),
              ],).marginOnly(left: 18),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icon(Icons.done_outlined,color: Colors.greenAccent,size: 18,),
                Image.asset('assets/images/check_mark.png',width: 14,height: 14,fit: BoxFit.fill,),
                SizedBox(width: 2,),
                Expanded(child: Text("AutomaticProduct".tr,style: TextStyle(color: Colors.white,fontSize: 15),)),
              ],).marginOnly(left: 18),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icon(Icons.done_outlined,color: Colors.greenAccent,size: 18,),
                Image.asset('assets/images/check_mark.png',width: 14,height: 14,fit: BoxFit.fill,),
                SizedBox(width: 2,),
                Expanded(child: Text("TotalControl".tr,style: TextStyle(color: Colors.white,fontSize: 15,),maxLines: null,)),
              ],).marginOnly(left: 18),

            SizedBox(height: 10,),

            Text("ForPrice".tr,style: TextStyle(fontSize: 14,color: Colors.white),).marginOnly(left: 18),
            SizedBox(height: 5,),
            GetBuilder<Localization>(builder: (controller) {
              return Align(
                  alignment: Alignment.center,
                  child: Image.asset((controller.dropdownValue['name']=='English')?"assets/images/borderOfferEnglish.png":"assets/images/borderOfferSpanish.png",width: MediaQuery.of(context).size.width*0.60,));
            },),


            SizedBox(height: 10,),
            InkWell(
              onTap: (){
                Get.back();
                Get.to(()=>PremiumPackage());
              },
              child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width*0.9,
                height: 60,
                decoration: BoxDecoration(
                  color: AppColors.red,
                  borderRadius: BorderRadius.circular(15)
                ),
                child: Text('BuyPremium'.tr.toUpperCase(),style: TextStyle(color: AppColors.white,fontSize: 22,fontWeight: FontWeight.bold),),),
            ),

            SizedBox(height: 10,),


          ],
        ),
      ),
    );
  }
}


class PremiumSheet extends StatefulWidget {
  const PremiumSheet({super.key});

  @override
  State<PremiumSheet> createState() => _PremiumSheetState();
}


class _PremiumSheetState extends State<PremiumSheet> {
  CommonController commonCont = Get.find<CommonController>();
  var textController = TextEditingController();
  final List<String> timeOptions = ["1 minute", "2 minutes", "3 minutes", "4 minutes", "5 minutes","10 minutes", "15 Minutes","30 Minutes", "1 Hour", "3 Hours", "6 Hours", "12 Hours", "24 Hours" ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    textController.text = 'setTime'.tr;
  }

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
              Text('premiumFeature'.tr,textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 26,fontWeight: FontWeight.bold),),
              InkWell(
                  onTap: (){
                    Get.back();
                  },
                  child: Icon(Icons.clear,color: AppColors.white,)),
            ],).marginSymmetric(vertical: 10),
          SizedBox(height: 10,),

          Text('PleaseSelectTime'.tr,style: TextStyle(color: AppColors.white,fontSize: 14,fontWeight: FontWeight.normal),),
          SizedBox(height: 10,),

          // Text('Set Timer',style: TextStyle(color: AppColors.white,fontSize: 18,fontWeight: FontWeight.bold),),

          SizedBox(height: 10,),



          GetBuilder<CommonController>(builder: (commonController) {
            return Column(
              children: [
                if(commonController.workManagerMagazine==false)
                  InkWell(
                    onTap: () async {
                      String? selectedTime = await showDialog<String>(context: context, builder: (context) {
                        return Container(
                          child: AlertDialog(
                            title: Text('Set Wallpaper Change Time'),
                            content: Container(
                              height: 300,
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: timeOptions.map((time) => GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).pop(time.toString());

                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(vertical: 16),
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(color: Colors.grey.shade300),
                                        ),
                                      ),
                                      child: Center(
                                        child: Text('${time.toString()}',
                                          style: const TextStyle(fontSize: 18),
                                        ),
                                      ),
                                    ),
                                  ),
                                  ).toList(),
                                ),
                              ),
                            ),
                          ),
                        );
                      },);

                          if(selectedTime!=null){
                            setState(() {
                              textController.text = selectedTime.toString();});
                          }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width*0.8,
                      height: 60,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: AppColors.black,width: 4),
                        color: AppColors.white
                      ),
                      child: Text("${textController.text??""}",style: TextStyle(fontSize: 26,fontWeight: FontWeight.bold),),
                      // child: TextFormField(
                      //   textAlign: TextAlign.center,
                      //   controller: textController,
                      //   readOnly: true,
                      //   style: TextStyle(color: AppColors.white),
                      //   decoration: InputDecoration(
                      //     border: OutlineInputBorder(borderSide: BorderSide(color: AppColors.white,width: 1)),
                      //     enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.white,width: 1)),
                      //     focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.white,width: 1)),
                      //   ),
                      //   onTap: ()async{
                      //
                      //     String? selectedTime = await showDialog<String>(context: context, builder: (context) {
                      //       return Container(
                      //         child: AlertDialog(
                      //           title: Text('Set Wallpaper Change Time'),
                      //           content: Container(
                      //             height: 300,
                      //             child: SingleChildScrollView(
                      //               child: Column(
                      //                 mainAxisSize: MainAxisSize.min,
                      //                 children: timeOptions.map((time) => GestureDetector(
                      //                     onTap: () {
                      //                       Navigator.of(context).pop(time.toString());
                      //
                      //                     },
                      //                     child: Container(
                      //                       padding: EdgeInsets.symmetric(vertical: 16),
                      //                       decoration: BoxDecoration(
                      //                         border: Border(
                      //                           bottom: BorderSide(color: Colors.grey.shade300),
                      //                         ),
                      //                       ),
                      //                       child: Center(
                      //                         child: Text('${time.toString()}',
                      //                           style: const TextStyle(fontSize: 18),
                      //                         ),
                      //                       ),
                      //                     ),
                      //                   ),
                      //                 ).toList(),
                      //               ),
                      //             ),
                      //           ),
                      //         ),
                      //       );
                      //     },);
                      //
                      //     if(selectedTime!=null){
                      //       textController.text = selectedTime.toString();
                      //     }
                      //
                      //   },
                      // )
                ),
                  ),
                SizedBox(height: 15,),
                (commonController.workManagerMagazine==true)?InkWell(
                  onTap: () async {
                    Get.back();
                    await commonController.setLoading(true);
                    // await commonController.stopWorkManagerTasks();
                    final service = FlutterBackgroundService();
                    bool isRunning=await service.isRunning();
                    if(isRunning){
                      service.invoke('stopService');
                      final SharedPreferences prefs = await SharedPreferences.getInstance();
                      await prefs.remove("wallpaperLength");
                      await prefs.remove("wallpaperInterval");
                      List<String>wallpaperUrls=[];
                      if(commonController.productData!.length>25){
                        wallpaperUrls = commonController.productData?.take(25).map((item) => item.image!).toList() ?? [];
                      }else{
                        wallpaperUrls = commonController.productData?.map((item) => item.image!).toList() ?? [];
                      }
                      for(int i=0;i< wallpaperUrls.length;i++){
                        await prefs.remove('wallpaper${i}');
                      }
                    }
                    await commonController.setMagazine(!commonController.workManagerMagazine);

                    await commonController.setLoading(false);

                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    height: 60,
                    decoration: BoxDecoration(color: Colors.red,borderRadius: BorderRadius.circular(10),border: Border.all(color: AppColors.black,width: 2)),
                    child: Text('ServiceStopState'.tr,style: TextStyle(color: AppColors.white,fontSize: 27,fontWeight: FontWeight.bold),),),
                )
                    : InkWell(
                  onTap: () async {
                    if(textController.text=="setTime".tr){
                      CustomSnackbar.show('Please select time', AppColors.red);
                    }
                    else{
                     if(commonController.productData!.length==null || commonController.productData!.length<10 ){

                       CustomSnackbar.show('Wallpaper album should have at least 10 wallpapers', AppColors.red);

                     }else{
                       if(commonController.workManagerMagazine==false){
                         String? timeInMinutes;

                         if(textController.text=="1 minute"){
                           setState(() {
                             timeInMinutes = "1";
                           });

                         }else if(textController.text=="2 minutes")
                         {
                           setState(() {
                             timeInMinutes = "2";
                           });

                         }else if(textController.text=="3 minutes")
                         {
                           setState(() {
                             timeInMinutes = "3";
                           });

                         }else if(textController.text=="4 minutes")
                         {
                           setState(() {
                             timeInMinutes = "4";
                           });

                         }else if(textController.text=="5 minutes")
                         {
                           setState(() {
                             timeInMinutes = "5";
                           });

                         }else if(textController.text=="10 minutes")
                         {
                           setState(() {
                             timeInMinutes = "10";
                           });

                         }else if(textController.text=="15 Minutes")
                         {
                           setState(() {
                             timeInMinutes = "15";
                           });

                         }else if(textController.text=="30 Minutes")
                         {
                           setState(() {
                             timeInMinutes = "30";
                           });

                         }else if(textController.text=="1 Hour")
                         {
                           setState(() {
                             timeInMinutes = "60";
                           });

                         }else if(textController.text=="3 Hours")
                         {
                           setState(() {
                             timeInMinutes = "180";
                           });

                         }else if(textController.text=="6 Hours")
                         {
                           setState(() {
                             timeInMinutes = "360";
                           });

                         }else if(textController.text=="12 Hours")
                         {
                           setState(() {
                             timeInMinutes = "720";
                           });

                         }else if(textController.text=="24 Hours"){
                           setState(() {
                             timeInMinutes = "1440";
                           });
                         }else{
                           setState(() {
                             timeInMinutes = "";
                           });
                         }

                         if(timeInMinutes !="" ||timeInMinutes!=null){
                           // await commonController.startWorkManagerTask(timeInMinutes);
                           final service = FlutterBackgroundService();
                           // Obtain shared preferences.
                           final SharedPreferences prefs = await SharedPreferences.getInstance();
                           List<String>wallpaperUrls=[];
                           if(commonController.productData!.length>25){
                             wallpaperUrls = commonController.productData?.take(25).map((item) => item.image!).toList() ?? [];
                           }else{
                             wallpaperUrls = commonController.productData?.map((item) => item.image!).toList() ?? [];
                           }


                           await prefs.setInt('wallpaperLength', wallpaperUrls.length);
                           await prefs.setInt('wallpaperInterval', int.parse(timeInMinutes!));
                           for(int i=0;i< wallpaperUrls.length;i++){
                             await prefs.setString('wallpaper${i}', wallpaperUrls[i]);
                           }
                           // await SharedPref.saveUser(usermodel);
                           // await commonController.startWorkManagerLikeWallpaperTask(timeInMinutes);
                           // FlutterBackgroundService().invoke("setAsBackground");
                           service.startService();
                         }else{
                           CustomSnackbar.show("Something went wrong please set the timer again", AppColors.red);
                         }
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
                    height: 60,
                    decoration: BoxDecoration(color: Colors.yellowAccent,borderRadius: BorderRadius.circular(10),border: Border.all(color: AppColors.black,width: 2)),
                    child: Text('ServiceStartState'.tr,style: TextStyle(color: AppColors.black,fontSize: 27,fontWeight: FontWeight.bold),),),
                ),
              ],
            );
          },),

        ],
      ).marginSymmetric(horizontal: 15),
    );
  }
}






class RelatedCategoryScreen extends StatefulWidget {
  CategoryModel _categoryModel;
   RelatedCategoryScreen(this._categoryModel,{super.key});

  @override
  State<RelatedCategoryScreen> createState() => _RelatedCategoryScreenState();
}

class _RelatedCategoryScreenState extends State<RelatedCategoryScreen> {

  CommonController commonController = Get.find<CommonController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: InkWell(
            onTap: (){
              Get.back();
            },
            child: Icon(Icons.arrow_back_ios_new_rounded,size: 24,color: AppColors.white,)),
        backgroundColor: AppColors.black,
        elevation: 0,
        title: Text("${widget._categoryModel.name}",style: TextStyle(color: AppColors.white),),
        centerTitle: true,

        actions: [
          InkWell(
            onTap: ()async{
              AuthenticationController authController = Get.find<AuthenticationController>();
              if(authController.myUser!.data!.isPremium==1){

               if(commonController.isLoading==false) showModalBottomSheet(
                  barrierColor: Colors.transparent,
                  backgroundColor: Color(0xff282828),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(15),topLeft: Radius.circular(15))),
                  context: context,
                  builder: (BuildContext context) {
                    return PremiumSheet();
                  },
                );


              }else{
                showModalBottomSheet(
                  barrierColor: Colors.transparent,
                  backgroundColor: Color(0xff282828),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(15),topLeft: Radius.circular(15))),
                  context: context,
                  builder: (BuildContext context) {
                    return NotPremiumSheet('');
                  },
                );
              }
            },
              child: Row(
                children: [

                  Image.asset('assets/images/crown.png',width: 25,height: 25),
                  Text('AutoChange'.tr),
                ],
              ).marginSymmetric(horizontal: 10)
          )
        ],
      ),

      body: Stack(
        children: [
          GetBuilder<CommonController>(builder: (controller) {
                return (controller.productData!.length==0||controller.productData!.length==null)
                    ?Center(child: Text("No wallpaper found",style: TextStyle(color: AppColors.white),),)
                    :GridView.builder(
                  shrinkWrap: true,
                  primary: true,
                  itemCount: controller.productData!.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 0.0,
                    mainAxisSpacing: 0.0,
                    mainAxisExtent: 230,
                    crossAxisCount: 3,
                  ),
                  itemBuilder: (context, index) {
                      return MixWidget(controller.productData![index]);
                  },
                ).marginSymmetric(horizontal: 3);
              },),
          GetBuilder<CommonController>(builder: (controller) {
            return Visibility(
              visible: controller.isLoading,
                child: LoadingAnimation());
          },)
        ],
      ),


    );
  }
}
