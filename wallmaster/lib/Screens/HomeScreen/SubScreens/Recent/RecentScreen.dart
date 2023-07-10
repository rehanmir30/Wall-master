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
          itemCount: commonController.productModelList!.data!.length + (commonController.productModelList!.data!.length ~/ 5),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 1.0,
            mainAxisSpacing: 3.0,
            mainAxisExtent: 300,
            crossAxisCount: 2,
          ),
          itemBuilder: (context, index) {
            if (index % 6 == 5 && index != 0) {
              final adIndex = (index ~/ 6) * 5;
              return Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                height: 280,
                decoration: BoxDecoration(
                  color: AppColors.black,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: AdWidget(ad: commonController.createListBannerAd()!),
                ),
              ).marginSymmetric(horizontal: 5, vertical: 5);

            }
            else {
              final productIndex = index - (index ~/ 6);
              return MixWidget(commonController.productModelList!.data![productIndex]);
            }
          },
        ).marginSymmetric(horizontal: 30);

      },)
    );
  }
}
