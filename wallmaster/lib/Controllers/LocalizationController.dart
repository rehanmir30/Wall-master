import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../DB/SharedPreferences/SharedPreferences.dart';

class Localization extends GetxController{
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    dropdownValue = locals[1];
  }

  List locals = [
    {'name':'English','locale':Locale('en','US')},
    // {'name':'Spanish','locale':Locale('es','AR')},
    {'name':'Spanish','locale':Locale('es','US')},

  ];
  late Map<String,dynamic> dropdownValue ;
  // Map<String,dynamic> get dropdownValue =>_dropdownValue;

    setSelectedLang(value)async{

    if(value=="English"){
      LanguageSelected(locals[0]);
    }else{
      LanguageSelected(locals[1]);
    }
    update();
  }

  void LanguageSelected(local)async{
    // print(locals[0]);
    dropdownValue = local;
    update();
    print("Selcedt: "+dropdownValue.toString());
    changeLanguage(local!['locale']);
    await SharedPref.saveSelectedLanguage(local!['name']);
  }

  changeLanguage(Locale local){
    Get.updateLocale(local);
  }

}