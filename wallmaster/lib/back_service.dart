import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> initializeService() async {
  final service = FlutterBackgroundService();
  await service.configure(
      iosConfiguration: IosConfiguration(
        autoStart: true,
        onForeground: onStart,
        onBackground: onIosBackground,
      ),
      androidConfiguration: AndroidConfiguration(
          onStart: onStart, isForegroundMode: true, autoStart: false));
}
@pragma('vm:entry-point')
Future<bool>onIosBackground(ServiceInstance service)async{
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();
  return true;
}
@pragma('vm:entry-point')
void onStart(ServiceInstance service) async{
  DartPluginRegistrant.ensureInitialized();
  if(service is AndroidServiceInstance){
   service.on('setAsForeground').listen((event) {
     service.setAsForegroundService();
   });
   service.on('setAsBackground').listen((event) {
     service.setAsBackgroundService();
   });
  }
  service.on('stopService').listen((event) {
    service.stopSelf();
  });
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final int interval = prefs.getInt('wallpaperInterval')!;
  final int counter = prefs.getInt('wallpaperLength')!;
  final String action = prefs.getString('wallpaper${0}')!;
  http.Response response = await http.get(Uri.parse(action));
  Uint8List imageData = response.bodyBytes;

  final directory =  await getApplicationSupportDirectory();
  UniqueKey k = UniqueKey();
  final imagePath = "${directory.path}/${k}.png";

  File imageFile = File(imagePath);
  imageFile.writeAsBytesSync(imageData);

  final results = await WallpaperManager.setWallpaperFromFile(
    imagePath,
    WallpaperManager.BOTH_SCREEN, // Set// wallpaper for the home screen
  );
  if(results){
    print("Background service runing : "+action);
  }else{
    print("Background service runing : failed to set wallpaper");
  }

  Timer.periodic(Duration(minutes: interval),(timer)async{
    if(service is AndroidServiceInstance){
      if(await service.isForegroundService()){
        service.setForegroundNotificationInfo(title: "Visual Scape ", content: "");
      }
    }

    // for(int i=0;i<counter;i++){
    Random random = new Random();
    int randomNumber = random.nextInt(counter);
    if(randomNumber>-1){
      final String action = prefs.getString('wallpaper${randomNumber}')!;
      http.Response response = await http.get(Uri.parse(action));
      Uint8List imageData = response.bodyBytes;

      final directory =  await getApplicationSupportDirectory();
      UniqueKey k = UniqueKey();
      final imagePath = "${directory.path}/${k}.png";

      File imageFile = File(imagePath);
      imageFile.writeAsBytesSync(imageData);

      final results = await WallpaperManager.setWallpaperFromFile(
        imagePath,
        WallpaperManager.BOTH_SCREEN, // Set// wallpaper for the home screen
      );
      if(results){
        print("Background service runing : "+action);
      }else{
        print("Background service runing : failed to set wallpaper");
      }
    }

      // print("Background service runing : "+action);

      // sleep(Duration(minutes: interval));
    // }

    service.invoke('update');
  });
}
