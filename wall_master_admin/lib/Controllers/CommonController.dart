import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wall_master_admin/Controllers/AuthenticationController.dart';
import 'package:wall_master_admin/DatabaseHelper/DatabaseHelper.dart';
import 'package:wall_master_admin/Models/CategoryModel.dart';
import 'package:wall_master_admin/Models/CreateCategoryModel.dart';
import 'package:wall_master_admin/Models/CreateProductModel.dart';
import 'package:wall_master_admin/Models/GetAllUserModel.dart';
import 'package:wall_master_admin/Models/GetCategoryModel.dart';

import '../Models/GetProductModel.dart';


class CommonController extends GetxController{


  GetCategoryModel? _categoryModelList;
  GetCategoryModel? get categoryModelList=>_categoryModelList;

  GetProductModel? _productModelList;
  GetProductModel? get productModelList=>_productModelList;

  GetAllUserModel? _allUserModel;
  GetAllUserModel? get allUserModel=>_allUserModel;

  List<String> _Images=[];
  List<String> get Images =>_Images;

  List<ProductData>? _productData;
  List<ProductData>? get productData=>_productData;

  List<Datum>? _categoryList;
  List<Datum>? get categoryList=>_categoryList;
  List<String> images =[
    "assets/images/1 (1).jpg",
    "assets/images/1 (2).jpg",
    "assets/images/1 (3).jpg",
    "assets/images/1 (4).jpg",
    "assets/images/1 (5).jpg",
    "assets/images/1 (6).jpg",
    "assets/images/1 (7).jpg",
    "assets/images/1 (8).jpg",
    "assets/images/1 (9).jpg",
    "assets/images/1 (10).jpg",
    "assets/images/1 (11).jpg",
    "assets/images/1 (12).jpg",
    "assets/images/1 (13).jpg"
  ];

  bool _isLoading = false;
  bool get isLoading =>_isLoading;


  @override
  onInit()async{
    super.onInit();
   getImages();
  }


  getAllUsers()async{
    await DatabaseHelper().getAllUsers();
  }

  updateProfile(name,email,password,image)async{
    await DatabaseHelper().updateProfile(name,email,password,image);
    update();
  }


  setAllUsers(GetAllUserModel model)async{
    _allUserModel = model;
    update();
  }

  setCategoryModelList(List<Datum>? list){
    _categoryList = list;
    print("LENGTH: ${list?.length}");
    update();
  }

  setLoading(bool loading)async{
    print(loading.toString());
    _isLoading = loading;
    update();
  }

  setImages(List<String> image)async{
    print("Function Called");
    _Images = image;
    print("Function ended");
    print(_Images.length.toString());
    update();
  }

  getImages(){
    setImages(images);
    update();
  }

  createCategory(CreateCategoryModel model)async{
    await DatabaseHelper().createCategory(model);
    print("Category Created");
  }

  updateCategory(CategoryModel model)async{
    await DatabaseHelper().updateCategory(model);
    print("Category updated");
    update();
  }

  deleteCategory(CategoryModel model)async{
    await DatabaseHelper().deleteCategory(model);
    print("Category deleted");
    update();
  }

  setCategoryList(GetCategoryModel model)async{
    _categoryModelList = model;
    print("All categories updated");
    update();
  }

  setProductList(GetProductModel model)async{
    _productModelList = model;
    print("All product updated");
    update();
  }

  getCategories()async{
    // Get.put(AuthenticationController());
    await DatabaseHelper().getCategories();
    print("All Categories updated");
    update();
  }

  getAllProducts()async{
    await DatabaseHelper().getAllProducts();
    update();
  }

  setListofProduct(List<ProductData>? data){
    _productData = data;
    update();
  }

  getSelectedCategoryProduct(GetProductModel? model,id)async{
   List<ProductData>? data = await DatabaseHelper().getSelectedCategoryProduct(model, id);
   await setListofProduct(data);
   update();
  }

  createProduct(CreateProductModel model,CategoryModel categoryModel,context)async{
    await DatabaseHelper().createProduct(model,categoryModel,context);
    update();
  }

  updateProduct(CreateProductModel model ,context)async{
    await DatabaseHelper().updateProduct(model,context);
    update();
  }

  deleteProduct(id,category_id,context)async{
    await DatabaseHelper().deleteProduct(id,category_id,context);
    update();
  }



}