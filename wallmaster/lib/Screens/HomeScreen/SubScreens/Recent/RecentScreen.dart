import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:wallmaster/Controllers/CommonController.dart';
import 'package:wallmaster/CustomWidgets/CommonWidget.dart';
import 'package:wallmaster/CustomWidgets/MixWidget.dart';

import '../../../../../Constants/AppColors.dart';
import '../../../../AdsMob/AdMobService.dart';

class RecentScreen extends StatefulWidget {
  const RecentScreen({super.key});

  @override
  State<RecentScreen> createState() => _RecentScreenState();
}

class _RecentScreenState extends State<RecentScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


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
          // reverse: true,
          itemCount: commonController.productModelList!.data!.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 0.0,
            mainAxisSpacing: 0.0,
            mainAxisExtent: 230,
            crossAxisCount: 3,
          ),
          itemBuilder: (context, index) {
              return MixWidget(commonController.productModelList!.data![index]);

          },
        ).marginSymmetric(horizontal: 3);

        //     :GridView.builder(
        //   shrinkWrap: true,
        //   primary: true,
        //   // reverse: true,
        //   itemCount: commonController.productModelList!.data!.length + (commonController.productModelList!.data!.length ~/ 5),
        //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //     crossAxisSpacing: 1.0,
        //     mainAxisSpacing: 1.0,
        //     mainAxisExtent: 230,
        //     crossAxisCount: 3,
        //   ),
        //   itemBuilder: (context, index) {
        //     if (index % 6 == 5 && index != 0) {
        //       final adIndex = (index ~/ 6) * 5;
        //       return Container(
        //         alignment: Alignment.center,
        //         width: MediaQuery.of(context).size.width,
        //         height: 200,
        //         decoration: BoxDecoration(
        //           color: AppColors.white,
        //           borderRadius: BorderRadius.circular(10),
        //         ),
        //         child: ClipRRect(
        //           borderRadius: BorderRadius.circular(10),
        //           child: AdWidget(ad: commonController.nativeAdList![adIndex]..load()),
        //         ),
        //       ).marginSymmetric(horizontal: 2, vertical: 2);
        //
        //     }
        //     else {
        //       final productIndex = index - (index ~/ 6);
        //       return MixWidget(commonController.productModelList!.data![productIndex]);
        //     }
        //   },
        // ).marginSymmetric(horizontal: 15);

      },)
    );
  }
}
