
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:wallmaster/Constants/ApiConstants.dart';
import 'package:wallmaster/Controllers/AuthenticationController.dart';
import 'package:wallmaster/Controllers/CommonController.dart';
import 'package:wallmaster/DB/SharedPreferences/SharedPreferences.dart';
import 'package:wallmaster/Model/LikedWallpaperModel.dart';
import 'package:wallmaster/Model/UserModel.dart';
import 'package:http/http.dart' as http;
import 'package:wallmaster/Screens/HomeScreen/HomeScreen.dart';
import 'package:wallmaster/Screens/HomeScreen/SubScreens/Drawer/LikedWallpaper/LikedWallpaperScreen.dart';

import '../Constants/AppColors.dart';
import '../CustomWidgets/CustomSnackbar.dart';
import '../Model/GetCategoryModel.dart';
import '../Model/GetProductModel.dart';
import '../Screens/Onboarding/Onborading.dart';

class DatabaseHelper{
  AuthenticationController authController = Get.find<AuthenticationController>();
  CommonController commonController = Get.find<CommonController>();


  //SignUp Function
  Future<void> SignUp(name,email,password)async{

  Map<String, String> header = {
    "Accept": "application/json",
    'Content-Type': 'application/json',
  };
  var body =
      '{"name": "${name.trim()}","email": "${email
      .trim()}","password": "${password.trim()}"}';

  var url = Uri.parse(ApiConstants.baseUrl+ApiConstants.registerApi);

  if (kDebugMode) {
    print('Verify User API URL - ${url.toString()}');
    print('Verify User Request Body - ${body.toString()}');
  }
  final response = await http.post(
    url,
    headers: header,
    body: body,
  );
  var responseJson = json.decode(response.body.toString());

  if(responseJson['status']==200){
    final usermodel = UserModel.fromJson(response.body.toString());
    await authController.setUserData(usermodel);
    CustomSnackbar.show('${usermodel.message}',AppColors.green);

    await SharedPref.saveUser(usermodel);
    CommonController commonController = Get.find<CommonController>();
    await commonController.getCategories();
    await commonController.getAllProducts();

    Get.offAll(()=>const HomeScreen());

  }else{
    final userModelFailure = UserModelFailure.fromJson(response.body.toString());
    CustomSnackbar.show('${userModelFailure.message}',AppColors.red);

    // Get.snackbar(
    //   '${userModelFailure.message}',
    //   "",
    //   snackPosition: SnackPosition.BOTTOM,
    //   duration: const Duration(seconds: 1),
    // );
  }

}

 //SignIn with Google
  Future<void>SignInGoogle()async{
    await Firebase.initializeApp();
    try{

      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    final user= await FirebaseAuth.instance.signInWithCredential(credential);

    Map<String, String> header = {
      "Accept": "application/json",
      'Content-Type': 'application/json',
    };
    var body =
        '{"email": "${user.user!.email}","is_social": 1,"name":"${user.user!.displayName}","social_uuid":"${user.user!.uid}"}';
    var url = Uri.parse(ApiConstants.baseUrl+ApiConstants.loginApi);
    if (kDebugMode) {
      print('Verify User API URL - ${url.toString()}');
      print('Verify User Request Body - ${body.toString()}');
    }
    final response = await http.post(
      url,
      headers: header,
      body: body,
    );
    var responseJson = json.decode(response.body.toString());
    if(responseJson['status']==200){
      final usermodel = UserModel.fromJson(response.body.toString());
      await authController.setUserData(usermodel);
      CustomSnackbar.show('${usermodel.message}',AppColors.green);
      await SharedPref.saveUser(usermodel);
      CommonController commonController = Get.find<CommonController>();
      await commonController.getCategories();
      await commonController.getAllProducts();

      Get.offAll(()=>const HomeScreen());

    }else{
      final userModelFailure = UserModelFailure.fromJson(response.body.toString());
      CustomSnackbar.show('${userModelFailure.message}',AppColors.red);
    }

    } on FirebaseAuthException catch(e){
 CustomSnackbar.show('${e.message}',AppColors.red);
    }
  }

  //SignIn Function
  Future<void> SignIn(email,password)async{
    print("Email: ${email} Pass: ${password}");

    Map<String, String> header = {
      "Accept": "application/json",
      'Content-Type': 'application/json',
    };
    var body =
        '{"email": "${email}","password": "${password}"}';

    var url = Uri.parse(ApiConstants.baseUrl+ApiConstants.loginApi);

    if (kDebugMode) {
      print('Verify User API URL - ${url.toString()}');
      print('Verify User Request Body - ${body.toString()}');
    }
    final response = await http.post(
      url,
      headers: header,
      body: body,
    );
    var responseJson = json.decode(response.body.toString());

    if(responseJson['status']==200){
      final usermodel = UserModel.fromJson(response.body.toString());
      await authController.setUserData(usermodel);
      CustomSnackbar.show('${usermodel.message}',AppColors.green);
      await SharedPref.saveUser(usermodel);
      CommonController commonController = Get.find<CommonController>();
      await commonController.getCategories();
      await commonController.getAllProducts();

      Get.offAll(()=>const HomeScreen());

    }else{
      final userModelFailure = UserModelFailure.fromJson(response.body.toString());
      CustomSnackbar.show('${userModelFailure.message}',AppColors.red);
    }

  }

  //Logout Function
  Future<void> SignOut(UserModel model)async{
    print(model.accessToken);
    Map<String, String> header = {
      'Authorization': 'Bearer ${model.accessToken}',
    };

    var url = Uri.parse(ApiConstants.baseUrl+ApiConstants.logoutApi);

    if (kDebugMode) {
      print('Verify User API URL - ${url.toString()}');

    }
    final response = await http.post(
      url,
      headers: header,
    );
    var responseJson = json.decode(response.body.toString());
    if(responseJson['status']==200){
      final usermodel = UserModelFailure.fromJson(response.body.toString());
      CustomSnackbar.show('${usermodel.message}',AppColors.green);
      await SharedPref.removeUser();

      // Get.snackbar(
      //   "${usermodel.message}",
      //   "",
      //   snackPosition: SnackPosition.BOTTOM,
      //   duration: Duration(seconds: 1),
      // );
      await Get.find<AuthenticationController>().setUserData(UserModel());
      Get.offAll(()=>Onboarding());
    }else{
      final usermodel = UserModelFailure.fromJson(response.body.toString());
      CustomSnackbar.show('${usermodel.message}',AppColors.red);

      // Get.snackbar(
      //   "${usermodel.message}",
      //   "",
      //   snackPosition: SnackPosition.BOTTOM,
      //   duration: Duration(seconds: 1),
      // );
    }

  }

  //Get All Categories Function
  Future<void> getCategories()async{
    AuthenticationController authenticationController =
    Get.find<AuthenticationController>();
    Map<String, String> headers = {
      "Accept": "application/json",
      'Content-Type': 'multipart/form-data',
      'Authorization': 'Bearer ${authenticationController.myUser?.accessToken}'
    };
    var url = Uri.parse(ApiConstants.baseUrl+ApiConstants.getCategoryListUrl);

    var response = await http.get(url,headers: headers);

    var responseJson = json.decode(response.body.toString());

    if(responseJson['status']==200){
      CommonController commonController = Get.find<CommonController>();
      final getCategoryModel = GetCategoryModel.fromJson(response.body.toString());
      // await .setAdminData(adminModel);
      List<Datum> categories = parseDataList(response.body);

      await commonController.setCategoryModelList(categories);

      await commonController.setCategoryList(getCategoryModel);
      print(getCategoryModel.message.toString());

    } else{
      final getCategoryModel = GetCategoryModel.fromJson(response.body.toString());
      print(getCategoryModel.message.toString());
    }


  }

  List<Datum> parseDataList(String responseBody) {
    final parsed = jsonDecode(responseBody)['data'].cast<Map<String, dynamic>>();
    return parsed.map<Datum>((json) => Datum.fromMap(json)).toList();
  }

  //Get All Wallpapers Function
  Future<void> getAllProducts()async{
    AuthenticationController authenticationController =
    Get.find<AuthenticationController>();
    Map<String, String> headers = {
      "Accept": "application/json",
      'Content-Type': 'multipart/form-data',
      'Authorization': 'Bearer ${authenticationController.myUser?.accessToken}'
    };
    var url = Uri.parse(ApiConstants.baseUrl+ApiConstants.getProductListUrl);

    var response = await http.get(url,headers: headers);

    var responseJson = json.decode(response.body.toString());

    if(responseJson['status']==200){
      CommonController commonController = Get.find<CommonController>();
      final getProductModel = GetProductModel.fromJson(response.body.toString());
      // await .setAdminData(adminModel);
      await commonController.setProductList(getProductModel);
      await commonController.getPremiumProduct(getProductModel);
      // CustomSnackbar.show('${getCategoryModel.message}',AppColors.green);
      await getLikedProduct();
      print(getProductModel.message.toString());
      // await SharedPref.saveUser(adminModel);
      // Get.offAll(()=>const HomeScreen());
    } else{
      final getProductModel = GetProductModel.fromJson(response.body.toString());
      print(getProductModel.message.toString());
    }


  }

  Future<List<ProductData>?>getSelectedCategoryProduct(GetProductModel? model,id)async{
    List<ProductData>? productdata =  model?.data?.where((product) => product.categoryId==id).toList();
    return productdata;
  }

  Future<void>getPremiumProduct(GetProductModel? model)async{
    List<ProductData>? productdata =  model?.data?.where((product) => int.parse(product.forPremium.toString())!=0).toList();
    // return productdata;
    await commonController.setPremiumProduct(productdata);
  }

  Future<void> getLikedProduct()async{
    AuthenticationController authenticationController =
    Get.find<AuthenticationController>();
    Map<String, String> headers = {
      "Accept": "application/json",
      'Content-Type': 'multipart/form-data',
      'Authorization': 'Bearer ${authenticationController.myUser?.accessToken}'
    };
    var url = Uri.parse(ApiConstants.baseUrl+ApiConstants.getAllLikeProductUrl);

    var response = await http.get(url,headers: headers);

    var responseJson = json.decode(response.body.toString());

    if(responseJson['status']==200){
      CommonController commonController = Get.find<CommonController>();
      final getLikedWallpaperModel = LikedWallpaperModel.fromJson(response.body.toString());
      // await .setAdminData(adminModel);
      await commonController.setLikedProduct(getLikedWallpaperModel);

      // CustomSnackbar.show('${getCategoryModel.message}',AppColors.green);
      print(getLikedWallpaperModel.message.toString());
      // await SharedPref.saveUser(adminModel);
      // Get.offAll(()=>const HomeScreen());
    } else{
      final getLikedWallpaperModel = LikedWallpaperModel.fromJson(response.body.toString());
      print(getLikedWallpaperModel.message.toString());
    }

  }

  Future<void> updateLikeProduct(productId, bool isLike)async{
    AuthenticationController authController = Get.find<AuthenticationController>();
    print("product_id: ${productId} is_like: ${isLike}");

    Map<String, String> header = {
      "Accept": "application/json",
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${authController.myUser?.accessToken}'
    };
    var body =
        '{"product_id": "${productId}","is_like": "${isLike}"}';

    var url = Uri.parse(ApiConstants.baseUrl+ApiConstants.updateLikeProductUrl);

    if (kDebugMode) {
      print('Verify User API URL - ${url.toString()}');
      print('Verify User Request Body - ${body.toString()}');
    }
    final response = await http.post(
      url,
      headers: header,
      body: body,
    );
    var responseJson = json.decode(response.body.toString());

    if(responseJson['status']==200){
      CustomSnackbar.show('${responseJson['message']}',AppColors.green);

      CommonController commonController = Get.find<CommonController>();
      await commonController.getCategories();
      await commonController.getAllProducts();
      await getLikedProduct();

    }else{
      CustomSnackbar.show('${responseJson['message']}',AppColors.red);

    }


  }

  // Create a method to compare tags and store matching products
  Future<void> getMatchingProducts(List<ProductData> productDataList, GetProductModel getProductModel) async {
    List<ProductData> matchingProducts = [];

    for (ProductData productData in productDataList) {
      for (ProductData product in getProductModel.data ?? []) {
        if (product.tags != null && product.tags!.isNotEmpty && productData.tags != null && productData.tags!.isNotEmpty) {
          for (dynamic tag in productData.tags!) {
            if (product.tags!.any((t) => t['tag'].toLowerCase() == tag['tag'].toLowerCase()) && product.id != productData.id) {
              print(product.id.toString());
              print(product.name.toString());
              if (matchingProducts.any((element) => element.name!.contains(productData.name!))){

              }else{
                matchingProducts.add(productData);
              }

              break;
            }
          }
        }
      }
    }

    CommonController commonController = Get.find<CommonController>();
    await commonController.setReliventData(matchingProducts);
  }



  Future<void> getSearchedProduct(String searchParameter, GetProductModel getProductModel) async {
    List<ProductData> filteredProducts = [];

    // Iterate over the list of ProductData objects in GetProductModel
    for (ProductData product in getProductModel.data ?? []) {
      // Check if the tags list contains the search parameter
      if (product.tags != null && product.tags!.any((tag) => tag['tag'].toLowerCase().contains(searchParameter.toLowerCase()))) {
        filteredProducts.add(product);
      }
    }

    CommonController commonController = Get.find<CommonController>();
    await commonController.setSearchedData(filteredProducts);
  }




}