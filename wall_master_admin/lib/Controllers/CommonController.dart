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
import 'package:wall_master_admin/Models/UpdateProductModel.dart';

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

  late List<ProductData> _multiSelectionProduct =[];
  List<ProductData> get multiSelectionProduct=>_multiSelectionProduct;


  List<Datum>? _categoryList;
  List<Datum>? get categoryList=>_categoryList;

  List<Datum>?  _sortCategoriesList;
  List<Datum>? get sortCategoriesList=>_sortCategoriesList;

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
  bool _multiSelectEnabled = false;
  bool get multiSelectEnabled =>_multiSelectEnabled;

  late List<bool> _multicheckBox = [];
  List<bool> get multicheckBox => _multicheckBox;


  @override
  onInit()async{
    super.onInit();
   getImages();
  }


  sendCategoryPriority(List<Datum> sortedCategories)async{
    await DatabaseHelper().sendCategoryPriority(sortedCategories);
    update();
  }

  setSortCategories(list)async{
    _sortCategoriesList = list;
    update();
  }

  addProductUsingMultiSelect(ProductData productData)async{
    print('Last Add LENGTH: ${productData.id}');
    _multiSelectionProduct.add(productData);
    print('After Add Updated LENGTH: ${_multiSelectionProduct.length}');
    update();
  }

  removeProductUsingMultiSelect(ProductData productData)async{
    print('Last LENGTH: ${_multiSelectionProduct.length}');
    _multiSelectionProduct.removeWhere((element) => element.id==productData.id);
    print('Updated LENGTH: ${_multiSelectionProduct.length}');
    update();
  }

  clearProductUsingMultiSelect( )async{
    _multiSelectionProduct.clear();
    print('Updated LENGTH: ${_multiSelectionProduct.length}');
    _multicheckBox.clear();
    update();
  }

  setMultiSelectSupport(bool value,bool selectAll)async{
    if(value==true){
      _multiSelectEnabled =value;
     if(selectAll==false){
       for(var i=0; i<=productData!.length-1;i++){
         _multicheckBox.add(false);
       }
     }else{
       for(var i=0; i<=productData!.length-1;i++){
         _multicheckBox.add(true);
       }
     }
    }else{
      _multiSelectEnabled =value;
      _multicheckBox.clear();
    }
    update();
  }

  leaveByClearingProductUsingMultiSelect( )async{
    _multiSelectionProduct.clear();
    print('Updated LENGTH: ${_multiSelectionProduct.length}');
    _multicheckBox.clear();
    // update();
  }

  LeaveAndSetMultiSelectSupport(bool value,bool selectAll)async{
    if(value==true){
      _multiSelectEnabled =value;
      if(selectAll==false){
        for(var i=0; i<=productData!.length-1;i++){
          _multicheckBox.add(false);
        }
      }else{
        for(var i=0; i<=productData!.length-1;i++){
          _multicheckBox.add(true);
        }
      }
    }else{
      _multiSelectEnabled =value;
      _multicheckBox.clear();
    }
    // update();
  }


  updateMulticheckBoxValue(bool value,index)async{
    _multicheckBox[index] = value;
    update();
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
    _sortCategoriesList = list;
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
   data =  data?.reversed.toList();
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

  updateProduct(UpdateProductModel model ,context)async{
    await DatabaseHelper().updateProduct(model,context);
    update();
  }

  deleteProduct(id,category_id,context)async{
    await DatabaseHelper().deleteProduct(id,category_id,context);
    update();
  }

  DeleteMultipleProduct(List<ProductData> productList,context)async{
    await DatabaseHelper().DeleteMultipleProduct(productList,context);
    await setMultiSelectSupport(false,false);
    await clearProductUsingMultiSelect();
    update();
  }


  UpdateMultipleProducts(List<ProductData> productList,context)async{
    List<UpdateProductModel> modelList =[];

    for(var i in productList){
      modelList.add(UpdateProductModel(
          i.id,
          tags: i.tags!,
          name: i.name,
          image: i.image,
          category_id: i.categoryId,
          for_premium: i.forPremium)
      );
    }

    await DatabaseHelper().UpdateMultipleProducts(modelList,context);
    await setMultiSelectSupport(false,false);
    await clearProductUsingMultiSelect();
    update();
  }

  selectAll()async{
    await clearProductUsingMultiSelect();
    await setMultiSelectSupport(true,true);
    for(var i in productData!){
      await addProductUsingMultiSelect(i);
    }

  }



}