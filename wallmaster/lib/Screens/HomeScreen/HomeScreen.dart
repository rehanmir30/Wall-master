import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallmaster/Constants/AppColors.dart';
import 'package:wallmaster/Controllers/AuthenticationController.dart';
import 'package:wallmaster/Controllers/CommonController.dart';
import 'package:wallmaster/Screens/HomeScreen/SubScreens/Category/SearchScreen.dart';
import 'package:wallmaster/Screens/Onboarding/Onborading.dart';
import '../../Controllers/LocalizationController.dart';
import 'SubScreens/Category/CategoryScreen.dart';
import 'SubScreens/Drawer/LikedWallpaper/LikedWallpaperScreen.dart';
import 'SubScreens/Drawer/PremiumPackages/PremiumPackage.dart';
import 'SubScreens/Drawer/PrivacyPolicy/PrivacyPolicyScreen.dart';
import 'SubScreens/Premium/PremiumScreen.dart';
import 'SubScreens/Recent/RecentScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        backgroundColor: AppColors.black,
        elevation: 0,
        title: Text("WallMaster".tr,style: TextStyle(color: Colors.white,fontSize: 24),),
        centerTitle: true,
        actions: [
          InkWell(
              onTap: (){
                Get.to(()=>SearchScreen());
              },
              child: Icon(Icons.search,size: 24,color: Colors.white,).marginOnly(right: 15))
        ],

        bottom: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: TabBar(
            indicatorColor: AppColors.red,
            indicatorWeight: 3,
            controller: _tabController,
            isScrollable: true,
            tabs: [
              Tab(
                child: Text(
                  'Categories'.tr,
                  style: TextStyle(fontSize: 20), // Increase the font size
                ),
              ),
              Tab(
                child: Text(
                  'Recent'.tr,
                  style: TextStyle(fontSize: 20), // Increase the font size
                ),
              ),
              Tab(
                child: Text(
                  'Premium'.tr,
                  style: TextStyle(fontSize: 20), // Increase the font size
                ),
              ),
              // Other tabs...
            ],
          ),

        ),
      ),

      body: TabBarView(
        controller: _tabController,
        children: [
          CategoryScreen(),
          RecentScreen(),
          PremiumScreen(),
          // RandomScreen(),
          // WeeklyScreen(),
          // MonthlyPopularScreen(),
          // MostPopularScreen(),
        ],
      ),

      drawer: MyDrawer(),
    );
  }
}




class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        elevation: 2,
        backgroundColor: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
             DrawerHeader(
              // margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color:  Colors.black,
              ),
              child: Container(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 25,
                      backgroundImage: AssetImage("assets/images/logo.png"),
                    ),
                    SizedBox(height: 10,),
                    Text(
                      'WallMaster'.tr,
                      style: TextStyle(
                        letterSpacing: 2,
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Text("version 1.0",style: TextStyle(color: AppColors.white,fontSize: 14),),
                  ],
                ),
              ),
            ),
            ListTile(
              leading: Container(
                width: 35,
                height: 35,
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.purple,
                ),
                child: Icon(Icons.change_circle_outlined,color: AppColors.white,size: 15,),
              ),
              title: Text('ChangeLanguage'.tr),
              onTap: () async{
                Navigator.pop(context);
                Localization _localization = Get.find<Localization>();
                CommonController _commonController = Get.find<CommonController>();
                if('English'==_localization.dropdownValue['name']){
                await _localization.setSelectedLang('spanish');
                await _commonController.changeLanguage('spanish');

                }else{
                  await _localization.setSelectedLang('English');
                  await _commonController.changeLanguage('English');
                }
                // Get.to(()=>PremiumPackage());
                // Handle drawer item click for About
              },
            ),
            ListTile(
              leading: Container(
                width: 35,
                height: 35,
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blueAccent,
                ),
                child: Icon(Icons.workspace_premium_outlined,color: AppColors.white,size: 15,),
              ),
              title: Text('BuyPremium'.tr),
              onTap: () {
                Navigator.pop(context);
                Get.to(()=>PremiumPackage());
                // Handle drawer item click for About
              },
            ),
            ListTile(
              leading: Container(
                width: 35,
                height: 35,
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.pinkAccent,
                ),
                child: Image.asset("assets/images/heart.png",width: 15,height: 15,),
              ),
              title: Text('LikedWallpapers'.tr),
              onTap: () {
                Navigator.pop(context);
                Get.to(()=>LikedWallpaperScreen());
                // Handle drawer item click for Home
              },
            ),
            ListTile(
              leading: Container(
                width: 35,
                height: 35,
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.green,
                ),
                child: Image.asset("assets/images/bell.png",width: 15,height: 15,),
              ),
              title: Text('Notifications'.tr),
              onTap: () {
                // Handle drawer item click for About
              },
            ),
            ListTile(
              leading: Container(
                width: 35,
                height: 35,
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.deepOrangeAccent,
                ),
                child: Image.asset("assets/images/privacy.png",width: 15,height: 15,),
              ),
              title: Text('PrivacyPolicy'.tr),
              onTap: () {
                Navigator.pop(context);
                Get.to(()=>PrivacyPolicyScreen());
                // Handle drawer item click for About
              },
            ),
            ListTile(
              leading: Container(
                width: 35,
                height: 35,
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.red,
                ),
                child:Icon(Icons.exit_to_app,color: AppColors.white,size: 16,),
              ),
              title: Text('Logout'.tr),
              onTap: () {
                Navigator.pop(context);
                AuthenticationController auth = Get.find<AuthenticationController>();
                auth.SignOut(auth.myUser!);
                // Handle drawer item click for About
              },
            ),

          ],
        ),
      ),
    );
  }
}