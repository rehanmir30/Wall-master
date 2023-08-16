import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wallmaster/Constants/ApiConstants.dart';
import 'package:wallmaster/Controllers/AuthenticationController.dart';
import 'package:wallmaster/Controllers/CommonController.dart';
import 'package:wallmaster/Controllers/LocalizationController.dart';
import 'package:wallmaster/DB/SharedPreferences/SharedPreferences.dart';
import 'package:wallmaster/Model/CategoryDeckModel.dart';
import 'package:wallmaster/Model/LikedWallpaperModel.dart';
import 'package:wallmaster/Model/UserModel.dart';
import 'package:http/http.dart' as http;
import 'package:wallmaster/Screens/HomeScreen/HomeScreen.dart';
import 'package:wallmaster/Screens/HomeScreen/SubScreens/Drawer/LikedWallpaper/LikedWallpaperScreen.dart';
import 'package:wallmaster/Screens/auth/LoginScreen.dart';
import 'package:workmanager/workmanager.dart';

import '../AdsMob/AdMobService.dart';
import '../Constants/AppColors.dart';
import '../CustomWidgets/CustomSnackbar.dart';
import '../Model/GetCategoryModel.dart';
import '../Model/GetProductModel.dart';
import '../Screens/Onboarding/Onborading.dart';

class DatabaseHelper {
  AuthenticationController authController = Get.find<AuthenticationController>();
  CommonController commonController = Get.find<CommonController>();

  //SignUp Function
  Future<void> SignUp(name, email, password) async {
    Localization _localization = Get.find<Localization>();
    Map<String, String> header = {
      "Accept": "application/json",
      'Content-Type': 'application/json',
    };
    var body =
        '{"name": "${name.trim()}","email": "${email.trim()}","password": "${password.trim()}","language":"${_localization.dropdownValue['name'].toLowerCase()}"}';

    var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.registerApi);

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

    if (responseJson['status'] == 200) {
      final usermodel = UserModel.fromJson(response.body.toString());
      await authController.setUserData(usermodel);
      CustomSnackbar.show('${usermodel.message}', AppColors.green);

      await SharedPref.saveUser(usermodel);
      CommonController commonController = Get.find<CommonController>();
      await commonController.getCategories();
      await commonController.getAllProducts();
      await getCategoriesWallpaper();

      Get.offAll(() => const HomeScreen());
    } else {
      final userModelFailure =
          UserModelFailure.fromJson(response.body.toString());
      CustomSnackbar.show('${userModelFailure.message}', AppColors.red);

      // Get.snackbar(
      //   '${userModelFailure.message}',
      //   "",
      //   snackPosition: SnackPosition.BOTTOM,
      //   duration: const Duration(seconds: 1),
      // );
    }
  }

  //SignIn with Google
  Future<void> SignInGoogle() async {
    Localization _localization = Get.find<Localization>();
    await Firebase.initializeApp();
    print('${_localization.dropdownValue['name'].toLowerCase()}');
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;


      if(googleUser?.email !=null){
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );
        var User = await FirebaseAuth.instance.signInWithCredential(credential);


        Map<String, String> header = {
          "Accept": "application/json",
          'Content-Type': 'application/json',
        };
        var body =
            '{"email": "${User.user!.email}","is_social": 1,"name":"${User.user!.displayName}","social_uuid":"${User.user!.uid}", "language":"${_localization.dropdownValue['name'].toLowerCase()}"}';
        var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.loginApi);
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
        if (responseJson['status'] == 200) {
          final usermodel = UserModel.fromJson(response.body.toString());
          await authController.setUserData(usermodel);

          await SharedPref.saveUser(usermodel);
          CommonController commonController = Get.find<CommonController>();
          await commonController.getCategories();
          if(commonController.productModelList==null){
            await commonController.getAllProducts();
          }
          await getCategoriesWallpaper();

          CustomSnackbar.show('${usermodel.message}', AppColors.green);
          Get.offAll(() => const HomeScreen());
        } else {
          final userModelFailure =
          UserModelFailure.fromJson(response.body.toString());
          CustomSnackbar.show('${userModelFailure.message}', AppColors.red);
        }

      }else{
        commonController.setLoading(false);
      }

    } on FirebaseAuthException catch (e) {
      commonController.setLoading(false);
      CustomSnackbar.show('${e.message}', AppColors.red);
    } on PlatformException catch(e){
      commonController.setLoading(false);
      CustomSnackbar.show('${e.message}', AppColors.red);
    }
  }

  //SignIn Function
  Future<void> SignIn(email, password) async {
    Localization _localization = Get.find<Localization>();
    print(
        "Email: ${email} Pass: ${password} language ${_localization.dropdownValue['name'].toLowerCase()}");

    Map<String, String> header = {
      "Accept": "application/json",
      'Content-Type': 'application/json',
    };
    var body =
        '{"email": "${email}","password": "${password}","language":"${_localization.dropdownValue['name'].toLowerCase()}"}';

    var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.loginApi);

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

    if (responseJson['status'] == 200) {
      final usermodel = UserModel.fromJson(response.body.toString());
      await authController.setUserData(usermodel);
      CustomSnackbar.show('${usermodel.message}', AppColors.green);
      await SharedPref.saveUser(usermodel);
      CommonController commonController = Get.find<CommonController>();
      await commonController.getCategories();
      await commonController.getAllProducts();
      await getCategoriesWallpaper();

      Get.offAll(() => const HomeScreen());
    } else {
      final userModelFailure =
          UserModelFailure.fromJson(response.body.toString());
      CustomSnackbar.show('${userModelFailure.message}', AppColors.red);
    }
  }

  //Logout Function
  Future<void> SignOut(UserModel model) async {
    print(model.accessToken);
    Map<String, String> header = {
      'Authorization': 'Bearer ${model.accessToken}',
    };

    var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.logoutApi);

    if (kDebugMode) {
      print('Verify User API URL - ${url.toString()}');
    }
    final response = await http.post(
      url,
      headers: header,
    );
    var responseJson = json.decode(response.body.toString());
    if (responseJson['status'] == 200) {
      final usermodel = UserModelFailure.fromJson(response.body.toString());
      CustomSnackbar.show('${usermodel.message}', AppColors.green);
      await SharedPref.removeUser();

      // Get.snackbar(
      //   "${usermodel.message}",
      //   "",
      //   snackPosition: SnackPosition.BOTTOM,
      //   duration: Duration(seconds: 1),
      // );
      await Get.find<AuthenticationController>().setUserData(UserModel());
      Get.offAll(() => Onboarding());
    } else {
      final usermodel = UserModelFailure.fromJson(response.body.toString());
      CustomSnackbar.show('${usermodel.message}', AppColors.red);

      // Get.snackbar(
      //   "${usermodel.message}",
      //   "",
      //   snackPosition: SnackPosition.BOTTOM,
      //   duration: Duration(seconds: 1),
      // );
    }
  }

  //Get All Categories Function
  Future<void> getCategories() async {
   try{
     AuthenticationController authenticationController =
     Get.find<AuthenticationController>();
     Map<String, String> headers = {
       "Accept": "application/json",
       'Content-Type': 'multipart/form-data',
       'Authorization': 'Bearer ${authenticationController.myUser?.accessToken}'
     };
     var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.getCategoryListUrl);

     var response = await http.get(url, headers: headers);

     var responseJson = json.decode(response.body.toString());

     if (responseJson['status'] == 200) {
       CommonController commonController = Get.find<CommonController>();
       final getCategoryModel =
       GetCategoryModel.fromJson(response.body.toString());
       // await .setAdminData(adminModel);
       List<Datum> categories = parseDataList(response.body);

       await commonController.setCategoryModelList(categories);

       await commonController.setCategoryList(getCategoryModel);
       print(getCategoryModel.message.toString());
     } else {
       final getCategoryModel =
       GetCategoryModel.fromJson(response.body.toString());
       print(getCategoryModel.message.toString());
     }
   }catch(e){
     CustomSnackbar.show("${e}", AppColors.red);

   }
  }

  List<Datum> parseDataList(String responseBody) {
    final parsed =
        jsonDecode(responseBody)['data'].cast<Map<String, dynamic>>();
    return parsed.map<Datum>((json) => Datum.fromMap(json)).toList();
  }

  //Get All Wallpapers Function
  Future<void> getAllProducts() async {
    AuthenticationController authenticationController =
        Get.find<AuthenticationController>();
    Map<String, String> headers = {
      "Accept": "application/json",
      'Content-Type': 'multipart/form-data',
      'Authorization': 'Bearer ${authenticationController.myUser?.accessToken}'
    };
    var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.getProductListUrl);

    var response = await http.get(url, headers: headers);

    var responseJson = json.decode(response.body.toString());

    if (responseJson['status'] == 200) {
      CommonController commonController = Get.find<CommonController>();
      final getProductModel =
          GetProductModel.fromJson(response.body.toString());
      // await .setAdminData(adminModel);
      await commonController.setProductList(getProductModel);
      await commonController.getPremiumProduct(getProductModel);
      // CustomSnackbar.show('${getCategoryModel.message}',AppColors.green);
      await getLikedProduct();
      print(getProductModel.message.toString());

      // await SharedPref.saveUser(adminModel);
      // Get.offAll(()=>const HomeScreen());
    } else {
      final getProductModel =
          GetProductModel.fromJson(response.body.toString());
      print(getProductModel.message.toString());
    }
  }

  Future<List<ProductData>?> getSelectedCategoryProduct(GetProductModel? model, id) async {
    List<ProductData>? productdata =
        model?.data?.where((product) => product.categoryId == id).toList();
    return productdata;
  }

  Future<void> getPremiumProduct(GetProductModel? model) async {
    List<ProductData>? productdata = model?.data
        ?.where((product) => int.parse(product.forPremium.toString()) != 0)
        .toList();
    // return productdata;
    await commonController.setPremiumProduct(productdata);
  }

  Future<bool> isProductLiked(id) async {
    final likedProducts = commonController.likedWallpaperModel!.data;

    if (likedProducts != null) {
      bool isLiked = likedProducts.any((element) => element.id == id);
      print("AVAVA: $isLiked");
      return isLiked;
    }
    print("NULL");

    return false;
  }

  Future<void> getLikedProduct() async {
    AuthenticationController authenticationController =
        Get.find<AuthenticationController>();
    Map<String, String> headers = {
      "Accept": "application/json",
      'Content-Type': 'multipart/form-data',
      'Authorization': 'Bearer ${authenticationController.myUser?.accessToken}'
    };
    var url =
        Uri.parse(ApiConstants.baseUrl + ApiConstants.getAllLikeProductUrl);

    var response = await http.get(url, headers: headers);

    var responseJson = json.decode(response.body.toString());

    if (responseJson['status'] == 200) {
      CommonController commonController = Get.find<CommonController>();
      final getLikedWallpaperModel =
          LikedWallpaperModel.fromJson(response.body.toString());
      // await .setAdminData(adminModel);
      await commonController.setLikedProduct(getLikedWallpaperModel);

      // CustomSnackbar.show('${getCategoryModel.message}',AppColors.green);
      print(getLikedWallpaperModel.message.toString());
      // await SharedPref.saveUser(adminModel);
      // Get.offAll(()=>const HomeScreen());
    } else {
      final getLikedWallpaperModel =
          LikedWallpaperModel.fromJson(response.body.toString());
      print(getLikedWallpaperModel.message.toString());
    }
  }

  Future<void> updateLikeProduct(productId, bool isLike) async {
    AuthenticationController authController =
        Get.find<AuthenticationController>();
    print("product_id: ${productId} is_like: ${isLike}");

    Map<String, String> header = {
      "Accept": "application/json",
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${authController.myUser?.accessToken}'
    };
    var body = '{"product_id": "${productId}","is_like": "${isLike}"}';

    var url =
        Uri.parse(ApiConstants.baseUrl + ApiConstants.updateLikeProductUrl);

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

    if (responseJson['status'] == 200) {
      CustomSnackbar.show('${responseJson['message']}', AppColors.green);

      CommonController commonController = Get.find<CommonController>();
      await commonController.getCategories();
      await commonController.getAllProducts();
      await getLikedProduct();
    } else {
      CustomSnackbar.show('${responseJson['message']}', AppColors.red);
    }
  }

  // Create a method to compare tags and store matching products
  Future<void> getMatchingProducts(List<ProductData> productDataList, GetProductModel getProductModel) async {
    List<ProductData> matchingProducts = [];
    matchingProducts.add(productDataList[0]);


      for (ProductData product in getProductModel.data!) {
        // print('List: ${product.tags}');
        // print('Target: ${productDataList[0].tags}');
        if (product.tags != null && product.tags!.isNotEmpty && productDataList[0].tags != null && productDataList[0].tags!.isNotEmpty) {
          for (dynamic tag in productDataList[0].tags!) {
              print('TAKKKK: ${tag['tag']}');
              for(dynamic foundedTag in product.tags!){
                if(tag['tag'].contains(foundedTag['tag'])){
                  if(matchingProducts.any((element) => element.id==product.id)){
                    print('Product ID: ${product.id}');

                  }else{
                    matchingProducts.add(product);
                  }
                }

              }

            // if (product.tags!.any((t) =>
            //         t['tag'].toLowerCase() == tag['tag'].toLowerCase()) && product.id != productDataList[0].id) {
            //   print(product.id.toString());
            //   print(product.name.toString());
            //   if (matchingProducts.any(
            //       (element) => element.name!.contains(productDataList[0].name!))) {
            //   } else {
            //     matchingProducts.add(productDataList[0]);
            //   }

              break;
            }
          }
        }



    CommonController commonController = Get.find<CommonController>();
    await commonController.setReliventData(matchingProducts);
  }

  //Get Searched Wallpapers
  Future<void> getSearchedProduct(String searchParameter, GetProductModel getProductModel) async {
    List<ProductData> filteredProducts = [];

    // Iterate over the list of ProductData objects in GetProductModel
    for (ProductData product in getProductModel.data ?? []) {
      // Check if the tags list contains the search parameter
      if (product.tags != null &&
          product.tags!.any((tag) => tag['tag']
              .toLowerCase()
              .contains(searchParameter.toLowerCase()))) {
        filteredProducts.add(product);
      }
    }

    CommonController commonController = Get.find<CommonController>();
    await commonController.setSearchedData(filteredProducts);
  }

  //Change Language
  Future<void> changeLanguage(value) async {
    try {
      AuthenticationController authController =
          Get.find<AuthenticationController>();
      // print("product_id: ${productId} is_like: ${isLike}");
      Map<String, String> header = {
        "Accept": "application/json",
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${authController.myUser?.accessToken}'
      };
      var body = '{"language": ${value.toLowerCase()}';

      var url =
          Uri.parse(ApiConstants.baseUrl + ApiConstants.changeLanguageApi);

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

      if (responseJson['status'] == 200) {
        CustomSnackbar.show('${responseJson['message']}', AppColors.green);
      } else {
        CustomSnackbar.show('${responseJson['message']}', AppColors.red);
      }
    } catch (e) {
      CustomSnackbar.show('$e', AppColors.red);
    }
  }

  //Get User Details
  Future<void> getUserDetails(UserModel? savedUser)async{
    CommonController commonController = Get.find<CommonController>();
    AuthenticationController authenticationController = Get.find<AuthenticationController>();

    Map<String, String> header = {
      "Accept": "application/json",
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${savedUser?.accessToken}'
    };
    // var body = '{"product_id": "${authController.myUser?.data?.isPremimum}"}';

    var url =
    Uri.parse(ApiConstants.baseUrl + ApiConstants.getDetailApi);

    if (kDebugMode) {
      print('Verify User API URL - ${url.toString()}');
      // print('Verify User Request Body - ${body.toString()}');
    }
    final response = await http.get(url, headers: header,);
    var responseJson = json.decode(response.body.toString());


    if (responseJson['status'] == 200) {
      final usermodel = UserModel.fromJson(response.body.toString());
      usermodel.accessToken = savedUser!.accessToken;
      usermodel.tokenType = savedUser.tokenType;
      await authenticationController.setUserData(usermodel);
      // CustomSnackbar.show('${usermodel.message}', AppColors.green);
      await SharedPref.saveUser(usermodel);

      CommonController commonController = Get.find<CommonController>();
      await commonController.getCategories();
      await commonController.getAllProducts();
      await getLikedProduct();
      await getCategoriesWallpaper();
    } else {
      CustomSnackbar.show('${responseJson['message']}', AppColors.red);
    }



  }

  // Future<void>getCategoriesWallpaper()async{
  //  CommonController commonController = Get.find<CommonController>();
  //  List<CategoryDeckModel>? data =[];
  //  int shouldPick =0;
  //
  //  for(var currentCategory in commonController.categoryModelList!.data!){
  //      commonController.productModelList?.data?.shuffle();
  //      CategoryDeckModel? deckModel = CategoryDeckModel();
  //
  //      deckModel.id = currentCategory.id;
  //      print('categorId: ${currentCategory.id}');
  //        deckModel.name = currentCategory.name;
  //        deckModel.imageName = currentCategory.imageName;
  //        deckModel.image = currentCategory.image;
  //        List<ProductData> productList =[];
  //
  //        for(var fetchProducts in commonController.productModelList!.data!){
  //          if(fetchProducts.categoryId ==currentCategory.id){
  //
  //            if(shouldPick==int.parse(fetchProducts.forPremium.toString())){
  //              print('${fetchProducts.forPremium}');
  //              print('${fetchProducts.id}');
  //              if(shouldPick==0){
  //                shouldPick=1;
  //                productList.add(fetchProducts);
  //              }else if(shouldPick==1){
  //                shouldPick=0;
  //                productList.add(fetchProducts);
  //              }
  //            }
  //
  //
  //          }
  //        }
  //      if(productList.length<4){
  //        for(var l in commonController.productModelList!.data!){
  //          if(l.forPremium==0 && l.categoryId==currentCategory.id) {
  //            bool result = productList.any((element) => element.id == l.id);
  //            print('${result}');
  //            if (result == false) {
  //              print("Regular Added Again: ${l.forPremium}");
  //              if(productList.length<4){
  //                productList.add(l);
  //              }
  //            }
  //          }
  //        }
  //      }
  //        deckModel.wallpaperdata = [];
  //        deckModel.wallpaperdata = productList;
  //        data.add(deckModel);
  //
  //        List<int>? indexes =[];
  //        for(var i=0;i<data.length;i++){
  //          indexes!.add(0);
  //        }
  //        await commonController.selectedStackIndex(indexes);
  //
  //        await commonController.setCategoryDeck(data);
  //
  //  }
  //  ///////////////////////////////////
  //
  //  // for(var i in commonController.categoryModelList!.data!){
  //  //   commonController.productModelList?.data?.shuffle();
  //  //   CategoryDeckModel? deckModel = CategoryDeckModel();
  //  //
  //  //   deckModel.id = i.id;
  //  //   print('categorId: ${i.id}');
  //  //     deckModel.name = i.name;
  //  //     deckModel.imageName = i.imageName;
  //  //     deckModel.image = i.image;
  //  //
  //  //     List<ProductData> productList =[];
  //  //     int lastWas=0;
  //  //     bool firstRun = true;
  //  //
  //  //     for(var j in commonController.productModelList!.data!){
  //  //       if(j.forPremium==0 && j.categoryId==i.id){
  //  //
  //  //         bool result = productList.any((element) => element.id==j.id);
  //  //         print('${result}');
  //  //         if(result==false){
  //  //           print("Regular Added: ${j.forPremium}");
  //  //           if(lastWas==1 && firstRun==false){
  //  //             productList.add(j);
  //  //             lastWas =0;
  //  //           }else if(lastWas==0 && firstRun ==true){
  //  //             productList.add(j);
  //  //             firstRun = false;
  //  //             lastWas =0;
  //  //           }
  //  //
  //  //           for(var k in commonController.productModelList!.data!){
  //  //             if(k.forPremium==1 && k.categoryId==i.id){
  //  //               bool result = productList.any((element) => element.id==k.id);
  //  //               if(result==false){
  //  //                 if(lastWas==0){
  //  //                   productList.add(k);
  //  //                   lastWas = 1;
  //  //                 }
  //  //
  //  //                 break;
  //  //               }
  //  //             }
  //  //           }
  //  //         }
  //  //       }else if(j.forPremium==1 && j.categoryId==i.id){
  //  //         bool result = productList.any((element) => element.id==j.id);
  //  //         if(result==false){
  //  //           print("Premium Added: ${j.forPremium}");
  //  //           if(lastWas==0 && firstRun==false){
  //  //             productList.add(j);
  //  //             lastWas =1;
  //  //           }else if(lastWas==0 && firstRun ==true){
  //  //             productList.add(j);
  //  //             firstRun = false;
  //  //             lastWas =1;
  //  //           }
  //  //
  //  //           for(var k in commonController.productModelList!.data!){
  //  //             if(k.forPremium==0 && k.categoryId==i.id){
  //  //               bool result = productList.any((element) => element.id==k.id);
  //  //               if(result==false){
  //  //                 if(lastWas==1){
  //  //                   productList.add(k);
  //  //                   lastWas = 0;
  //  //                 }
  //  //                 break;
  //  //               }
  //  //             }
  //  //           }
  //  //         }
  //  //       }
  //  //
  //  //       if(productList.length<4){
  //  //         for(var l in commonController.productModelList!.data!){
  //  //           if(l.forPremium==0 && l.categoryId==i.id) {
  //  //             bool result = productList.any((element) => element.id == l.id);
  //  //             print('${result}');
  //  //             if (result == false) {
  //  //               print("Regular Added Again: ${l.forPremium}");
  //  //               if(productList.length<4){
  //  //                 productList.add(l);
  //  //               }
  //  //             }
  //  //           }
  //  //         }
  //  //       }
  //  //     }
  //  //
  //  //
  //  //
  //  //
  //  //     deckModel.wallpaperdata = [];
  //  //     deckModel.wallpaperdata = productList;
  //  //     data.add(deckModel);
  //  //
  //  //     List<int>? indexes =[];
  //  //     for(var i=0;i<data.length;i++){
  //  //       indexes!.add(0);
  //  //     }
  //  //     await commonController.selectedStackIndex(indexes);
  //  //
  //  //     await commonController.setCategoryDeck(data);
  //  //
  //  // }
  //    await commonController.setCategoryDeck(data);
  //    print('Running Tests');
  //    for(var i in data){
  //      print(" Category: ${i.id}");
  //
  //          for(var j in i.wallpaperdata!){
  //            print('Product Premium: ${j.forPremium}');
  //          }
  //
  //    }
  //
  //    print('DECK DATA:   ${data!.length}');
  //
  // }



  Future<void> getCategoriesWallpaper() async {
    CommonController commonController = Get.find<CommonController>();
    List<CategoryDeckModel>? data = [];

    for (var currentCategory in commonController.categoryModelList!.data!) {
      CategoryDeckModel? deckModel = CategoryDeckModel();
      var randomNumber = Random();
      int number = randomNumber.nextInt(4);

      deckModel.id = currentCategory.id;
      print('categoryId: ${currentCategory.id}');
      deckModel.name = currentCategory.name;
      deckModel.imageName = currentCategory.imageName;
      deckModel.image = currentCategory.image;
      List<ProductData> productList = [];

      // Separate premium and non-premium products
      List<ProductData> premiumProducts = commonController.productModelList!.data!
          .where((product) =>
      product.categoryId == currentCategory.id &&
          product.forPremium == 1)
          .toList();

      List<ProductData> nonPremiumProducts = commonController.productModelList!.data!
          .where((product) =>
      product.categoryId == currentCategory.id &&
          product.forPremium == 0)
          .toList();

      // Add premium product at index 3 if available
      productList.addAll(nonPremiumProducts);
      if (premiumProducts.isNotEmpty) {
        // productList.add(premiumProducts[0]);
        productList[number] = premiumProducts[0];
      }

      if(productList.length<4){
        for(var l in commonController.productModelList!.data!){
          if(l.forPremium==0 && l.categoryId==currentCategory.id) {
            bool result = productList.any((element) => element.id == l.id);
            print('${result}');
            if (result == false) {
              print("Regular Added Again: ${l.forPremium}");
              if(productList.length<4){
                productList.add(l);
              }
            }
          }
        }
      }

      deckModel.wallpaperdata = productList;
      data.add(deckModel);
    }

    List<int>? indexes = List.filled(data.length, 0);
    await commonController.selectedStackIndex(indexes);

    await commonController.setCategoryDeck(data);

    print('Running Tests');
    for (var i in data) {
      print("Category: ${i.id}");

      for (var j in i.wallpaperdata!) {
        print('Product Premium: ${j.forPremium}');
      }
    }

    print('DECK DATA: ${data!.length}');
  }


  //Buy Premium Package
  Future<void> buyPremium()async{

    try {
      AuthenticationController authController = Get.find<AuthenticationController>();
      // print("product_id: ${productId} is_like: ${isLike}");
      Map<String, String> header = {
        "Accept": "application/json",
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${authController.myUser?.accessToken}'
      };
      var body = '{"is_premium": "${1}", "subscribe_date": "${DateTime.now()}"}';

      var url =
      Uri.parse(ApiConstants.baseUrl + ApiConstants.profileUpdateApi);

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

      if (responseJson['status'] == 200) {
        CustomSnackbar.show('${responseJson['message']}', AppColors.green);
        UserModel? model = authController.myUser;
        model!.data!.isPremium = 1;
        await authController.setUserData(model);
        await SharedPref.saveUser(model);

      } else {
        CustomSnackbar.show('${responseJson['message']}', AppColors.red);
      }
    } catch (e) {
      CustomSnackbar.show('$e', AppColors.red);
    }


  }

  //Forget Passsword
  Future<void> forgetPassword(email)async{

    Localization _localization = Get.find<Localization>();
    Map<String, String> header = {
      "Accept": "application/json",
      'Content-Type': 'application/json',
    };
    var body =
        '{"email": "${email.trim()}"}';

    var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.forgetPasswordApi);

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

    if (responseJson['status'] == 200) {

      CustomSnackbar.show('${responseJson['message']}', AppColors.green);
      Get.to(()=>LoginScreen());
    } else {

      CustomSnackbar.show('${responseJson['message']}', AppColors.red);
    }

  }

  Future<void>stopWorkManagerTasks()async{
    // await Future.delayed(const Duration(seconds: 14));
   try{
       await Workmanager().cancelByTag('heavy');
       // await Future.delayed(Duration(seconds: 20));
       // sleep(Duration(seconds: 10));


   }catch(e){
     print("Caught exception: $e");

   }

    // await Workmanager().cancelByUniqueName('taskOne');

  }



  Future<void> startWorkManagerTask(text)async{
    CommonController commonController = Get.find<CommonController>();

    // List<String> data =[];
  // for(var i in commonController.likedWallpaperModel!.data!){
  //   data.add(i.image!);
  // }
  //   List<String> wallpaperUrls = commonController.productData?.map((item) => item.image!)?.toList() ?? [];
    List<String> wallpaperUrls = commonController.productData?.take(25).map((item) => item.image!).toList() ?? [];

    // await Workmanager().cancelByUniqueName("changeWallpaperTask");

    Workmanager().registerOneOffTask(
      "taskOne",
      "changeWallpaperTask",
        tag: 'heavy',
        inputData: {
        'wallpaperUrls': wallpaperUrls,
          'time': text,
        },
         initialDelay: Duration(seconds: 5),
      constraints: Constraints(
        networkType: NetworkType.connected,
        requiresBatteryNotLow: true,
        requiresCharging: false,
        requiresDeviceIdle: false,
        requiresStorageNotLow: true,
      ),
      // frequency: Duration(minutes: 15),
    );

    CustomSnackbar.show('Album as been Set', AppColors.green);
  }

  Future<void> startWorkManagerLikeWallpaperTask(text)async{
    CommonController commonController = Get.find<CommonController>();

    // List<String> data =[];
  // for(var i in commonController.likedWallpaperModel!.data!){
  //   data.add(i.image!);
  // }
    List<String> wallpaperUrls = commonController.likedWallpaperModel!.data?.map((item) => item.image!)?.toList() ?? [];

  //   List<String> wallpaperUrls = commonController.productData?.take(25).map((item) => item.image!).toList() ?? [];

    // await Workmanager().cancelAll();
    int time= int.parse(text);
// for(var wallpaper in wallpaperUrls){
//   await Workmanager().registerPeriodicTask(
//     "taskOne",
//     "changeWallpaperTask",
//     tag: "heavy",
//     inputData: {
//       'wallpaperUrls': wallpaper,
//       'time': text,
//     },
//     constraints: Constraints(
//       networkType: NetworkType.connected,
//       requiresBatteryNotLow: true,
//       requiresCharging: false,
//       requiresDeviceIdle: false,
//       requiresStorageNotLow: true,
//     ),
//     initialDelay: Duration(seconds: 5),
//     frequency: Duration(minutes: time),
//     // frequency: Duration(minutes: 15),
//   );
//   time+=time;
//   print("Time: "+time.toString());
// }


    // CustomSnackbar.show('Album as been Set', AppColors.green);
  }

  ////////////////////////////////////////////////////////////////////////////////////

  Future<void>addColor() async{
    CommonController commonController = Get.find<CommonController>();
    List<PaletteColor?> dyColors = [];
    for(var image in commonController.productReliventData!){
      final PaletteGenerator pg = await PaletteGenerator.fromImageProvider(
        NetworkImage(image.image!),
        // size: Size(200, 200),
      );
      dyColors.add(pg.darkVibrantColor == null
          ?PaletteColor(Colors.white, 2)
          :pg.darkVibrantColor);
    }
    await commonController.setDyColor(dyColors);
  }


  createBannerAd() async {
    BannerAd? _banner= BannerAd(
      size: AdSize.banner,
      adUnitId: AdMobService.bannerAdUnitId!,
      listener: AdMobService.bannerAdListener,
      request: const AdRequest(
        keywords: ['gaming','pubg','freefire'],
      ),
    )..load();
    await commonController.setBannerAd(_banner);

  }

  createListBannerAd() async {
    BannerAd? _banner= BannerAd(
      size: AdSize.leaderboard,
      adUnitId: AdMobService.bannerAdUnitId!,
      listener: AdMobService.ListbannerAdListener,
      request: const AdRequest(
        keywords: ['gaming','pubg','freefire'],
      ),
    )..load();
    await commonController.setBannerListAd(_banner);

  }

  createInterstitialAd(){
    InterstitialAd.load(
      adUnitId: AdMobService.interstitialAdUnitId!,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (ad) async {
            await commonController.setInterstitialAd(ad);
          },
          onAdFailedToLoad: (error) async {
            await commonController.setInterstitialAd(null);
          }
      ),
    );
  }

  createRewardedAd(){
    RewardedAd.load(
      adUnitId: AdMobService.rewardedAdUniId!,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) async {
          await commonController.setRewardedAd(ad);
        },
        onAdFailedToLoad: (LoadAdError error) {
          commonController.setRewardedAd(null);
        },),
    );
  }

  showInterstitialAd(){
    if(commonController.interstitialAd !=null){
      commonController.interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad){
          ad.dispose();
          createInterstitialAd();
        },
        onAdFailedToShowFullScreenContent: (ad,error){
          ad.dispose();
          createInterstitialAd();
        },
      );
      commonController.interstitialAd!.show();
      commonController.setInterstitialAd(null);
    }
  }

  showRewardedAd() async {
    if(commonController.rewardedAd != null){
      commonController.rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
          onAdDismissedFullScreenContent: (ad){
            ad.dispose();
            createRewardedAd();
          },
          onAdFailedToShowFullScreenContent: (ad,error){
            ad.dispose();
            createRewardedAd();
          }
      );
      commonController.rewardedAd!.show(
          onUserEarnedReward:(ad,reward) async {
            await commonController.setRewardScore();

          } );
    await commonController.setRewardedAd(null);
    }

  }


}
