import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:palette_generator/palette_generator.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:wallmaster/Model/GetCategoryModel.dart';

import '../DB/DatabaseHelper.dart';
import '../Model/GetProductModel.dart';
import '../Model/LikedWallpaperModel.dart';
import '../Screens/AdScreen/AdHelper.dart';


class CommonController extends GetxController{

  List<String> _Images=[];
  List<String> get Images =>_Images;
  List<PaletteColor?> _dycolors = [];
  List<PaletteColor?> get dycolors =>_dycolors;

  bool _isLoading = false;
  bool get isLoading =>_isLoading;

  bool _isLiked = false;
  bool get isLiked =>_isLiked;

  GetCategoryModel? _categoryModelList;
  GetCategoryModel? get categoryModelList=>_categoryModelList;

  LikedWallpaperModel? _likedWallpaperModel;
  LikedWallpaperModel? get likedWallpaperModel=>_likedWallpaperModel;

  List<Datum>? _categoryList;
  List<Datum>? get categoryList=>_categoryList;

  GetProductModel? _productModelList;
  GetProductModel? get productModelList=>_productModelList;

  List<ProductData>? _productData;
  List<ProductData>? get productData=>_productData;

  List<ProductData>? _productReliventData;
  List<ProductData>? get productReliventData=>_productReliventData;

  List<ProductData>? _producSearchedData;
  List<ProductData>? get producSearchedData=>_producSearchedData;

  List<ProductData>? _premiumProductData;
  List<ProductData>? get premiumProductData=>_premiumProductData;

  List<LikeProductData>? _likedProductData;
  List<LikeProductData>? get likedProductData=>_likedProductData;


  changeLanguage(value)async{
    await DatabaseHelper().changeLanguage(value);
    update();
  }

  setDyColor(color)async{
    _dycolors = color;
    update();
  }

  setLiked(bool value)async{
    _isLiked= value;
    update();
  }

  addColor()async{
    await DatabaseHelper().addColor();
    update();
  }

  isProductLiked(id)async{
   bool result =  await DatabaseHelper().isProductLiked(id);
   await setLiked(result);
    update();
  }

  setReliventData(List<ProductData>? data)async{
    _productReliventData = data;
    print("LENGTH OF MATCHING: ${_productReliventData!.length}");
    update();
  }

  setSearchedData(List<ProductData>? data)async{
    _producSearchedData = data;
    print("LENGTH OF MATCHING: ${_producSearchedData!.length}");
    update();
  }

  getReliventData(List<ProductData>? data)async{
    await DatabaseHelper().getMatchingProducts(data!, productModelList!);
    update();
  }

  getSearchedData(String data)async{
    await DatabaseHelper().getSearchedProduct(data, productModelList!);
    update();
  }

  setLoading(bool loading)async{
    print(loading.toString());
    _isLoading = loading;
    update();
  }

  getLikedProduct(List<LikeProductData> list)async{
    _likedProductData = list;
    update();
  }

  setLikedProduct(LikedWallpaperModel model)async{
    _likedWallpaperModel = model;
    update();
  }

  updateLikeProduct(productId,bool isLike)async{
    await DatabaseHelper().updateLikeProduct(productId, isLike);
    update();
  }

  setCategoryList(GetCategoryModel model)async{
    _categoryModelList = model;
    print("All categories updated");
    update();
  }

  setCategoryModelList(List<Datum>? list){
    _categoryList = list;
    print("LENGTH: ${list?.length}");
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

  setProductList(GetProductModel model)async{
    _productModelList = model;
    print("All product updated");
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

  getPremiumProduct(GetProductModel? model)async{
    await DatabaseHelper().getPremiumProduct(model);
    update();
  }

  setPremiumProduct(List<ProductData>? model)async{
    _premiumProductData = model;
    update();
  }




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

  @override
  onInit()async{
    super.onInit();
   getImages();
  //  loadBanner();
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



}