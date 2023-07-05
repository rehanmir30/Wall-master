import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallmaster/Controllers/InitControllers/InitController.dart';
import 'package:wallmaster/Screens/SplashScreen.dart';

import 'Constants/LocalizationTranslator.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
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

