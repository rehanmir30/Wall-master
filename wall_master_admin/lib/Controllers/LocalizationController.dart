import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Localization extends GetxController{
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    dropdownValue = locals[0];
  }

  List locals = [
    {'name':'English','locale':Locale('en','US')},
    // {'name':'Spanish','locale':Locale('es','AR')},
    {'name':'Spanish','locale':Locale('es','US')},

  ];
  late Map<String,dynamic> dropdownValue ;
  // Map<String,dynamic> get dropdownValue =>_dropdownValue;

  void LanguageSelected(local){
    // print(locals[0]);
    dropdownValue = local;
    update();
    print("Selcedt: "+dropdownValue.toString());
    changeLanguage(local!['locale']);
  }
  setSelectedLang(value)async{

    if(value=="English"){
      LanguageSelected(locals[0]);
    }else{
      LanguageSelected(locals[1]);
    }
    update();
  }

  changeLanguage(Locale local){
    Get.updateLocale(local);
  }

}