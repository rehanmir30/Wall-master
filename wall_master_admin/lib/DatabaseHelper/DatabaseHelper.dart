import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:wall_master_admin/Controllers/AuthenticationController.dart';
import 'package:http/http.dart' as http;
import 'package:wall_master_admin/Controllers/CommonController.dart';
import 'package:wall_master_admin/Models/AdminModel.dart';
import 'package:wall_master_admin/Models/CreateCategoryModel.dart';
import 'package:wall_master_admin/Models/CreateProductModel.dart';
import 'package:wall_master_admin/Models/GetAllUserModel.dart';
import 'package:wall_master_admin/Models/GetCategoryModel.dart';
import 'package:wall_master_admin/Models/GetProductModel.dart';
import 'package:wall_master_admin/Views/Screens/AuthScreens/LoginScreen.dart';
import '../Constants/ApiConstants.dart';
import '../Constants/AppColors.dart';
import '../Controllers/LocalizationController.dart';
import '../CustomWidgets/CustomSnackbar.dart';
import '../Models/CategoryModel.dart';
import '../Views/Screens/HomeScreen/HomeScreen.dart';
import 'SharedPreferences/SharedPreferences.dart';


class DatabaseHelper{

  //SignIn Function
  Future<void> signIn(email,password)async{
    AuthenticationController authController = Get.find<AuthenticationController>();
    Localization _localization = Get.find<Localization>();
    print("Email: ${email} Pass: ${password}, language ${_localization.dropdownValue['name'].toLowerCase()}");

    Map<String, String> header = {
      "Accept": "application/json",
      'Content-Type': 'application/json',
    };

    var body = '{"email": "${email}","password": "${password}","language": "${_localization.dropdownValue['name'].toLowerCase()}"}';

    var url = Uri.parse(ApiConstants.baseUrl+ApiConstants.loginUrl);
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
      final adminModel = AdminModel.fromJson(response.body.toString());
      await authController.setAdminData(adminModel);
      CustomSnackbar.show('${adminModel.message}',AppColors.green);
      await SharedPref.saveUser(adminModel);
      CommonController commonController = Get.find<CommonController>();
      await commonController.getCategories();
      await commonController.getAllProducts();
      await commonController.getAllUsers();
      Get.offAll(()=>const HomeScreen());

    }else{
      final userModelFailure = AdminModelFailure.fromJson(response.body.toString());
      CustomSnackbar.show('${userModelFailure.message}',AppColors.red);
    }

  }

  //Logout Function
  Future<void> signOut(AdminModel model)async{
    print(model.accessToken);
    Map<String, String> header = {
      'Authorization': 'Bearer ${model.accessToken}',
    };

    var url = Uri.parse(ApiConstants.baseUrl+ApiConstants.logoutUrl);

    if (kDebugMode) {
      print('Verify User API URL - ${url.toString()}');

    }
    final response = await http.post(
      url,
      headers: header,
    );
    var responseJson = json.decode(response.body.toString());
    if(responseJson['status']==200){
      final usermodel = AdminModelFailure.fromJson(response.body.toString());
      CustomSnackbar.show('${usermodel.message}',AppColors.green);
      await SharedPref.removeUser();

      // Get.snackbar(
      //   "${usermodel.message}",
      //   "",
      //   snackPosition: SnackPosition.BOTTOM,
      //   duration: Duration(seconds: 1),
      // );
      await Get.find<AuthenticationController>().setAdminData(AdminModel());
      Get.offAll(()=>LoginScreen());
    }else{
      final usermodel = AdminModelFailure.fromJson(response.body.toString());
      CustomSnackbar.show('${usermodel.message}',AppColors.red);

      // Get.snackbar(
      //   "${usermodel.message}",
      //   "",
      //   snackPosition: SnackPosition.BOTTOM,
      //   duration: Duration(seconds: 1),
      // );
    }

  }

  //Update Profile Function
  Future<void> updateProfile(name,email,password,image)async{
    AuthenticationController authenticationController = Get.find<AuthenticationController>();
    Localization _localization = Get.find<Localization>();
    Map<String, String> headers = {
      "Accept": "application/json",
      'Content-Type': 'multipart/form-data',
      'Authorization': 'Bearer ${authenticationController.adminModel?.accessToken}'
    };

    var request = http.MultipartRequest(
      'POST',
      Uri.parse(ApiConstants.baseUrl + ApiConstants.profileUpdateUrl),
    );
    print("PASSWORD: ${password}");
    if(image==null||image==""){
      if( password==null || password==""){
        request.headers.addAll(headers);
        request.fields['name'] = name;
        request.fields['email'] = email.toString();
        request.fields['language'] = _localization.dropdownValue['name'].toLowerCase().toString();
      }else{
        request.headers.addAll(headers);
        request.fields['name'] = name;
        request.fields['email'] = email.toString();
        request.fields['language'] = _localization.dropdownValue['name'].toLowerCase().toString();
        request.fields['password'] = password.toString();
      }

    }else{
      request.headers.addAll(headers);
      request.fields['name'] = name;
      request.fields['email'] = email.toString();
      request.fields['language'] = _localization.dropdownValue['name'].toLowerCase().toString();
      request.fields['password'] = password.toString();
      request.files.add(await http.MultipartFile.fromPath('image', image.path));
    }

    if (kDebugMode) {
      print('Update Profile API URL - ${request.url.toString()}');
      print('Update Profile Request Body - ${request.fields.toString()}');
    }

    var response = await request.send();
    var responseJson = await response.stream.bytesToString();
    var jsonResponse = jsonDecode(responseJson);
    if (jsonResponse['status'] == 200) {
      // File successfully uploaded
      print('File uploaded!');
      CustomSnackbar.show('${jsonResponse['message']}', AppColors.green);
      AuthenticationController _authController = Get.find<AuthenticationController>();
      AdminModel? _adminModel = _authController.adminModel;
      _adminModel!.data!.name = name;
      _adminModel.data!.email = email;
      _adminModel.data!.image = image;
      await _authController.setAdminData(_adminModel);
      await SharedPref.saveUser(_adminModel);
      // Get.back();
      // Get.offAll(()=>const HomeScreen());
      await getCategories();
      await getAllProducts();
      Get.offAll(()=>HomeScreen());
    } else {
      // File upload failed
      print('File upload failed with status code: ${response.statusCode}');
      // var jsonResponse = jsonDecode(responseJson);
      CustomSnackbar.show('${jsonResponse['message']}', AppColors.red);
    }

  }

  //Create Category Function
  Future<void> createCategory(CreateCategoryModel model) async {
    AuthenticationController authenticationController =
    Get.find<AuthenticationController>();
    Map<String, String> headers = {
      "Accept": "application/json",
      'Content-Type': 'multipart/form-data',
      'Authorization': 'Bearer ${authenticationController.adminModel?.accessToken}'
    };

    var request = http.MultipartRequest(
      'POST',
      Uri.parse(ApiConstants.baseUrl + ApiConstants.createCategoryUrl),
    );
    request.headers.addAll(headers);
    request.fields['name'] = model.name;
    request.files.add(await http.MultipartFile.fromPath('image', model.image!.path));

    if (kDebugMode) {
      print('Create Category API URL - ${request.url.toString()}');
      print('Create Category Request Body - ${request.fields.toString()}');
    }

    var response = await request.send();
    var responseJson = await response.stream.bytesToString();
    var jsonResponse = jsonDecode(responseJson);
    if (jsonResponse['status'] == 200) {
      // File successfully uploaded
      print('File uploaded!');
      CustomSnackbar.show('${jsonResponse['message']}', AppColors.green);
      // Get.back();
      await getCategories();
      await getAllProducts();
      Get.offAll(()=>const HomeScreen());
    } else {
      // File upload failed
      print('File upload failed with status code: ${response.statusCode}');
      // var jsonResponse = jsonDecode(responseJson);
      CustomSnackbar.show('${jsonResponse['message']}', AppColors.red);
    }
  }

  //Update Category Function
  Future<void> updateCategory(CategoryModel model) async {
    AuthenticationController authenticationController =
    Get.find<AuthenticationController>();
    Map<String, String> headers = {
      "Accept": "application/json",
      'Content-Type': 'multipart/form-data',
      'Authorization': 'Bearer ${authenticationController.adminModel?.accessToken}'
    };

    var request = http.MultipartRequest(
      'POST',
      Uri.parse(ApiConstants.baseUrl + ApiConstants.updateCategoryUrl),
    );
    if(model.image?.path==null||model.image?.path==""){
      request.headers.addAll(headers);
      request.fields['id'] = model.id.toString();
      request.fields['name'] = model.name;
    }else{
      request.headers.addAll(headers);
      request.fields['id'] = model.id.toString();
      request.fields['name'] = model.name;
      request.files.add(await http.MultipartFile.fromPath('image', model.image!.path));
    }

    if (kDebugMode) {
      print('Create Category API URL - ${request.url.toString()}');
      print('Create Category Request Body - ${request.fields.toString()}');
    }

    var response = await request.send();
    var responseJson = await response.stream.bytesToString();
    var jsonResponse = jsonDecode(responseJson);
    if (jsonResponse['status'] == 200) {
      // File successfully uploaded
      print('File uploaded!');
      CustomSnackbar.show('${jsonResponse['message']}', AppColors.green);
      // Get.back();
      // Get.offAll(()=>const HomeScreen());
      await getCategories();
      await getAllProducts();
      Get.offAll(()=>HomeScreen());
    } else {
      // File upload failed
      print('File upload failed with status code: ${response.statusCode}');
      // var jsonResponse = jsonDecode(responseJson);
      CustomSnackbar.show('${jsonResponse['message']}', AppColors.red);
    }

  }

  //Delete Category Function
  Future<void> deleteCategory(CategoryModel model)async{
    AuthenticationController authenticationController =
    Get.find<AuthenticationController>();
    Map<String, String> headers = {
      "Accept": "application/json",
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${authenticationController.adminModel?.accessToken}'
    };

    var body =
        '{"id": "${model.id}"}';
    var url = Uri.parse(ApiConstants.baseUrl+ApiConstants.deleteCategoryUrl);
    if (kDebugMode) {
      print('Verify User API URL - ${url.toString()}');
      print('Verify User Request Body - ${body.toString()}');
    }
    final response = await http.post(
      url,
      headers: headers,
      body: body,
    );
    var responseJson = json.decode(response.body.toString());

    if(responseJson['status']==200){
      CustomSnackbar.show('${responseJson['message']}',AppColors.green);
      CommonController commonController = Get.find<CommonController>();
      await commonController.getCategories();
      await commonController.getAllProducts();
      Get.offAll(()=>const HomeScreen());

    }else{
      CustomSnackbar.show('${responseJson['message']}',AppColors.red);
    }


  }

  //Get All Categories Function
  Future<void> getCategories()async{
    AuthenticationController authenticationController =
    Get.find<AuthenticationController>();
    Map<String, String> headers = {
      "Accept": "application/json",
      'Content-Type': 'multipart/form-data',
      'Authorization': 'Bearer ${authenticationController.adminModel?.accessToken}'
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
      'Authorization': 'Bearer ${authenticationController.adminModel?.accessToken}'
    };
    var url = Uri.parse(ApiConstants.baseUrl+ApiConstants.getProductListUrl);

    var response = await http.get(url,headers: headers);

    var responseJson = json.decode(response.body.toString());

    if(responseJson['status']==200){
      CommonController commonController = Get.find<CommonController>();
      final getProductModel = GetProductModel.fromJson(response.body.toString());
      // await .setAdminData(adminModel);
      await commonController.setProductList(getProductModel);
      // CustomSnackbar.show('${getCategoryModel.message}',AppColors.green);
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

  //Create Product Function
  Future<void> createProduct(CreateProductModel model,CategoryModel categoryModel,context)async {
    print("LENGTH OF TAGS: ${model.tags.length}");
    var tagsValue = model.tags.join(',');

    AuthenticationController authenticationController =
    Get.find<AuthenticationController>();
    Map<String, String> headers = {
      "Accept": "application/json",
      'Content-Type': 'multipart/form-data',
      'Authorization': 'Bearer ${authenticationController.adminModel
          ?.accessToken}'
    };

    var request = http.MultipartRequest(
      'POST',
      Uri.parse(ApiConstants.baseUrl + ApiConstants.createProductUrl),
    );
    request.headers.addAll(headers);
    request.fields['name'] = model.name;
    request.fields['category_id'] = model.category_id.toString();
    request.fields['for_premium'] = model.for_premium.toString();
    for (var i = 0; i < model.tags.length; i++) {
      print(i.toString());
      request.fields['tags[${i}]'] = model.tags[i];
    }
      request.files.add(
          await http.MultipartFile.fromPath('image', model.image!.path));

      if (kDebugMode) {
        print('Create Category API URL - ${request.url.toString()}');
        print('Create Category Request Body - ${request.fields.toString()}');
      }

      var response = await request.send();
      var responseJson = await response.stream.bytesToString();
      var jsonResponse = jsonDecode(responseJson);
      if (jsonResponse['status'] == 200) {
        // File successfully uploaded
        print('File uploaded!');
        CustomSnackbar.show(
            '${jsonResponse['message']}', AppColors.green);
        // Get.back();
        // Get.offAll(()=>const HomeScreen());
        CommonController commonController = Get.find<CommonController>();
        await getCategories();
        await getAllProducts();
        await commonController.getSelectedCategoryProduct(commonController.productModelList,categoryModel.id);
        Navigator.pop(context);
      }
      else {
        // File upload failed
        print('File upload failed with status code: ${response.statusCode}');
        // var jsonResponse = jsonDecode(responseJson);
        CustomSnackbar.show(
            '${jsonResponse['message']}', AppColors.red);
      }
  }

  //Update Product Function
  Future<void> updateProduct(CreateProductModel model ,context)async{
    AuthenticationController authenticationController =
    Get.find<AuthenticationController>();
    Map<String, String> headers = {
      "Accept": "application/json",
      'Content-Type': 'multipart/form-data',
      'Authorization': 'Bearer ${authenticationController.adminModel?.accessToken}'
    };

    var request = http.MultipartRequest(
      'POST',
      Uri.parse(ApiConstants.baseUrl + ApiConstants.updateProductUrl),
    );
    if(model.image?.path==null||model.image?.path==""){
      request.headers.addAll(headers);
      request.fields['name'] = model.name;
      request.fields['category_id'] = model.category_id.toString();
      request.fields['for_premium'] = model.for_premium.toString();
      request.fields['id'] = model.id.toString().toString();
      for (var i = 0; i < model.tags.length; i++) {
        print(i.toString());
        request.fields['tags[${i}]'] = model.tags[i];
      }
    }else{
      request.headers.addAll(headers);
      request.fields['name'] = model.name;
      request.fields['category_id'] = model.category_id.toString();
      request.files.add(await http.MultipartFile.fromPath('image', model.image!.path));
      request.fields['for_premium'] = model.for_premium.toString();
      request.fields['id'] = model.id.toString();
      for (var i = 0; i < model.tags.length; i++) {
        print(i.toString());
        request.fields['tags[${i}]'] = model.tags[i];
      }
    }

    if (kDebugMode) {
      print('Create Category API URL - ${request.url.toString()}');
      print('Create Category Request Body - ${request.fields.toString()}');
    }

    var response = await request.send();
    var responseJson = await response.stream.bytesToString();
    var jsonResponse = jsonDecode(responseJson);
    if (jsonResponse['status'] == 200) {
      // File successfully uploaded
      print('File uploaded!');
      CustomSnackbar.show('${jsonResponse['message']}', AppColors.green);
      // Get.back();
      // Get.offAll(()=>const HomeScreen());
      await getCategories();
      await getAllProducts();
      Get.offAll(()=>HomeScreen());
    } else {
      // File upload failed
      print('File upload failed with status code: ${response.statusCode}');
      // var jsonResponse = jsonDecode(responseJson);
      CustomSnackbar.show('${jsonResponse['message']}', AppColors.red);
    }

  }

  //Delete Product Function
  Future<void> deleteProduct(id,category_id,context)async{
    AuthenticationController authenticationController =
    Get.find<AuthenticationController>();
    Map<String, String> headers = {
      "Accept": "application/json",
      'Content-Type': 'multipart/form-data',
      'Authorization': 'Bearer ${authenticationController.adminModel?.accessToken}'
    };

    var request = http.MultipartRequest(
      'POST',
      Uri.parse(ApiConstants.baseUrl + ApiConstants.deleteProductUrl),
    );
    request.headers.addAll(headers);
    request.fields['id'] = id.toString();

    if (kDebugMode) {
      print('Create Category API URL - ${request.url.toString()}');
      print('Create Category Request Body - ${request.fields.toString()}');
    }

    var response = await request.send();
    var responseJson = await response.stream.bytesToString();
    var jsonResponse = jsonDecode(responseJson);
    if (jsonResponse['status'] == 200) {
      // File successfully uploaded
      print('File uploaded!');
      CustomSnackbar.show('${jsonResponse['message']}', AppColors.green);
      CommonController commonController = Get.find<CommonController>();
      await getCategories();
      await getAllProducts();
      await commonController.getSelectedCategoryProduct(commonController.productModelList,category_id);
      Navigator.pop(context);
      Navigator.pop(context);
      // Get.back();
    } else {
      // File upload failed
      print('File upload failed with status code: ${response.statusCode}');
      // var jsonResponse = jsonDecode(responseJson);
      CustomSnackbar.show('${jsonResponse['message']}', AppColors.red);
    }


  }

  //Get ALl Users
  Future<void> getAllUsers()async{
    AuthenticationController authenticationController =
    Get.find<AuthenticationController>();
    Map<String, String> headers = {
      "Accept": "application/json",
      'Content-Type': 'multipart/form-data',
      'Authorization': 'Bearer ${authenticationController.adminModel?.accessToken}'
    };

    var request = http.MultipartRequest(
      'GET',
      Uri.parse(ApiConstants.baseUrl + ApiConstants.getAllUsersUrl),
    );
    request.headers.addAll(headers);

    if (kDebugMode) {
      print('Create Category API URL - ${request.url.toString()}');
      print('Create Category Request Body - ${request.fields.toString()}');
    }

    var response = await request.send();
    var responseJson = await response.stream.bytesToString();
    var jsonResponse = jsonDecode(responseJson);
    if (jsonResponse['status'] == 200) {
      // File successfully uploaded
      print('File uploaded!');

      GetAllUserModel model = GetAllUserModel.fromJson(responseJson);
      CommonController controller = Get.find<CommonController>();
      await controller.setAllUsers(model);
      // Get.back();
    } else {
      // File upload failed
      print('File upload failed with status code: ${response.statusCode}');
      // var jsonResponse = jsonDecode(responseJson);

    }

  }
}