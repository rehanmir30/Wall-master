import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallmaster/Constants/AppColors.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        title:  Text('PrivacyPolicy'.tr),
        centerTitle: true,
        backgroundColor: AppColors.black,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            Text('WallMasterPrivacyPolicy'.tr, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.white),),
            SizedBox(height: 16),
            Text('ThisPrivacyPolicy'.tr, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.white),),
            SizedBox(height: 8),
            Text('GWebSoft'.tr, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.white),),
            Text('Thispageinformsyouofourpolicies'.tr, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.white),),
            Text('ByusingtheService'.tr, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.white),),

            SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  width: 7,
                  height: 7,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.white,
                  ),
                ),
                SizedBox(width: 6,),
                Text('InformationCollectionandUse'.tr, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.white),),
              ],
            ),
            SizedBox(height: 8),
            Text('ToprovideandimproveourService'.tr, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.white),),

            SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  width: 7,
                  height: 7,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.white,
                  ),
                ),
                SizedBox(width: 6,),
                Text('UsageData'.tr, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.white),),
              ],
            ),
            SizedBox(height: 8),
            Text('WhenyouaccesstheService'.tr, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.white),),

            SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  width: 7,
                  height: 7,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.white,
                  ),
                ),
                SizedBox(width: 6,),
                Text('CookiesandUsageData'.tr, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.white),),
              ],
            ),
            SizedBox(height: 8),
            Text('Weusecookies'.tr, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.white),),

            SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  width: 7,
                  height: 7,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.white,
                  ),
                ),
                SizedBox(width: 6,),
                Text('DataTransfer'.tr, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.white),),
              ],
            ),
            SizedBox(height: 8),
            Text('Yourinformation'.tr, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.white),),

            SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  width: 7,
                  height: 7,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.white,
                  ),
                ),
                SizedBox(width: 6,),
                Text('DataDisclosure'.tr, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.white),),
              ],
            ),
            SizedBox(height: 8),
            Text('Wemaydisclose'.tr, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.white),),

            SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: 6,),
                Container(
                  alignment: Alignment.center,
                  width: 5,
                  height: 5,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.white,
                  ),
                ),
                SizedBox(width: 6,),
                Text('ComplyWith'.tr, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.white),),
              ],
            ),

            SizedBox(height: 4),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: 6,),
                Container(
                  alignment: Alignment.center,
                  width: 5,
                  height: 5,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.white,
                  ),
                ),
                SizedBox(width: 6,),
                Text('Protectanddefend'.tr, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.white),),
              ],
            ),

            SizedBox(height: 4),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: 6,),
                Container(
                  alignment: Alignment.center,
                  width: 5,
                  height: 5,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.white,
                  ),
                ),
                SizedBox(width: 6,),
                Expanded(child: Text('Preventorinvestigate'.tr, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.white),)),
              ],
            ),

            SizedBox(height: 4),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: 6,),
                Container(
                  alignment: Alignment.center,
                  width: 5,
                  height: 5,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.white,
                  ),
                ),
                SizedBox(width: 6,),
                Expanded(child: Text('Protectthepersonal'.tr, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.white),)),
              ],
            ),

            SizedBox(height: 4),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: 6,),
                Container(
                  alignment: Alignment.center,
                  width: 5,
                  height: 5,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.white,
                  ),
                ),
                SizedBox(width: 6,),
                Expanded(child: Text('ProtectAgainst'.tr, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.white),)),
              ],
            ),

            SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  width: 5,
                  height: 5,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.white,
                  ),
                ),
                SizedBox(width: 6,),
                Expanded(child: Text('DataSecurity'.tr, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.white),)),
              ],
            ),
            SizedBox(height: 8),
            Text('Thesecurityofyourdata'.tr, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.white),),

            SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  width: 5,
                  height: 5,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.white,
                  ),
                ),
                SizedBox(width: 6,),
                Expanded(child: Text('LinkstoOtherSites'.tr, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.white),)),
              ],
            ),
            SizedBox(height: 8),
            Text('OurService'.tr, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.white),),

            SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  width: 5,
                  height: 5,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.white,
                  ),
                ),
                SizedBox(width: 6,),
                Expanded(child: Text('ChangestoThisPrivacyPolicy'.tr, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.white),)),
              ],
            ),
            SizedBox(height: 8),
            Text('Wemayupdate'.tr, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.white),),

            SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  width: 5,
                  height: 5,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.white,
                  ),
                ),
                SizedBox(width: 6,),
                Expanded(child: Text('Contact'.tr, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.white),)),
              ],
            ),
            SizedBox(height: 8),
            Wrap(
              direction: Axis.horizontal,
              children: [
                Text('pleasecontactus'.tr, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.white),),
                InkWell(
                    overlayColor: MaterialStatePropertyAll(Colors.transparent),
                    onTap: (){

                    },
                    child: Text('email'.tr, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.red),)),

              ],
            ),

            SizedBox(height: 16,)
          ],
        ),
      ),
    );
  }
}