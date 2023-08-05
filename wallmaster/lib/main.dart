import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:wallpaper_manager_flutter/wallpaper_manager_flutter.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wallmaster/Controllers/InitControllers/InitController.dart';
import 'package:wallmaster/DB/DatabaseHelper.dart';
import 'package:wallmaster/Screens/SplashScreen.dart';
import 'package:flutter/services.dart';
import 'package:workmanager/workmanager.dart';
import 'Constants/AppColors.dart';
import 'Constants/LocalizationTranslator.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

import 'CustomWidgets/CustomSnackbar.dart';
import 'Model/GetProductModel.dart';



@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((taskName, inputData) async {
    // Retrieve the wallpaper URLs from inputData
    print("TASK: "+taskName);
    List<String> wallpaperUrls = List<String>.from(inputData?['wallpaperUrls'] ?? []);

    String  time = inputData?['time'];
    int timer = int.parse(time);

    // Call a function to change the wallpaper with the retrieved URLs
    await changeLockScreenWallpaper(wallpaperUrls,timer);

    return Future.value(true);
  });
}

Future<void> changeLockScreenWallpaper(List<String> wallpaperUrls,timer) async {
  print("TASK: FUNCTION");

  // Example using flutter_wallpaper_manager plugin (Android only):

  for (var i=0; i < wallpaperUrls.length; i++) {
    try {
      final wallpaperUrl = wallpaperUrls[i];
      if (kDebugMode) {
        print("URLSSSSS: "+wallpaperUrl.toString());
      }

      http.Response response = await http.get(Uri.parse(wallpaperUrl));
      Uint8List imageData = response.bodyBytes;

      final directory =  await getApplicationSupportDirectory();
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

        if (kDebugMode) {
          print("Success");
          sleep( Duration(minutes: timer));
        }

      }else{
        if (kDebugMode) {
          print("Fail");
          sleep(Duration(minutes:  timer));
          changeLockScreenWallpaper(wallpaperUrls,timer);
        }
        // CustomSnackbar.show('WallpaperUpdateFailed'.tr,AppColors.red);

      }

    } catch (e) {
      print('Error setting lock screen wallpaper: $e');
    }
  }
  sleep(Duration(minutes: timer));
  await changeLockScreenWallpaper(wallpaperUrls,timer);
}





Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

  Workmanager().initialize(callbackDispatcher,isInDebugMode: false);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(const MyApp()));
}




class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //Using Getx
    return GetMaterialApp(
      title: "WallMaster",
      initialBinding: InitController(),
      translations: LocalizationTranslator(),
      locale: Locale('es','US'),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "exo",
      ),
      home: SplashScreen(),
    );
  }
}

