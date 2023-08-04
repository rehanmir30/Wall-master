import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:lottie/lottie.dart';
import 'package:wallmaster/Controllers/AuthenticationController.dart';
import 'package:wallmaster/Screens/HomeScreen/SubScreens/Drawer/PremiumPackages/PremiumPackage.dart';

import '../../../../../Constants/AppColors.dart';
import '../../../../../Controllers/CommonController.dart';
import '../../../../CustomWidgets/CustomSnackbar.dart';
import '../../../../CustomWidgets/MixWidget.dart';
import '../../../../Model/CategoryModel.dart';



class NotPremiumSheet extends StatelessWidget {
  CommonController _commonController = Get.find<CommonController>();
  var wallpaper;

  NotPremiumSheet(this.wallpaper,{super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 430,
      decoration: BoxDecoration(
        // color: Colors.white
        borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15)),

      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Premium Offer'.tr,textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 26,fontWeight: FontWeight.bold),),
              InkWell(
                  onTap: (){
                    Get.back();
                  },
                  child: Icon(Icons.clear,color: AppColors.white,)),
            ],).marginSymmetric(horizontal: 15,vertical: 10),

          Lottie.asset('assets/images/premiumCrown.json',),
          Text("This feature is only for premium members you are not a premium member. If you want to use this feature buy our premium package.",style: TextStyle(color: AppColors.white),).marginSymmetric(horizontal: 15),
          SizedBox(height: 20,),
          InkWell(
            onTap: (){
              Get.back();
              Get.to(()=>PremiumPackage());
            },
            child: Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width*0.9,
              height: 50,
              decoration: BoxDecoration(
                color: AppColors.red,
                borderRadius: BorderRadius.circular(15)
              ),
              child: Text('BUY PREMIUM',style: TextStyle(color: AppColors.white),),),
          ),

          SizedBox(height: 10,),


        ],
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
                     if(commonController.productData!.length==null || commonController.productData!.length<10 ){

                       CustomSnackbar.show('Wallpaper album should have at least 10 wallpapers', AppColors.red);

                     }else{
                       if(commonController.workManagerMagazine==false){
                         await commonController.startWorkManagerTask(textController.text);
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

                showModalBottomSheet(
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

      body: GetBuilder<CommonController>(builder: (controller) {
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


    );
  }
}
