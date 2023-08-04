import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:wallmaster/CustomWidgets/CustomSnackbar.dart';
import 'package:wallmaster/DB/SharedPreferences/SharedPreferences.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:wallmaster/Model/GetCategoryModel.dart';
import 'package:wallmaster/Model/UserModel.dart';

import '../AdsMob/AdMobService.dart';
import '../Constants/AppColors.dart';
import '../DB/DatabaseHelper.dart';
import '../Model/CategoryDeckModel.dart';
import '../Model/GetProductModel.dart';
import '../Model/LikedWallpaperModel.dart';
import '../Screens/AdScreen/AdHelper.dart';
import '../Screens/Download/SetWallpaper/SetWallpaperScreen.dart';


class CommonController extends GetxController{

  bool _isLoading = false;
  bool get isLoading =>_isLoading;

  bool _isLiked = false;
  bool get isLiked =>_isLiked;

  bool _interstitial = false;
  bool get interstitial => _interstitial;

  GetCategoryModel? _categoryModelList;
  GetCategoryModel? get categoryModelList=>_categoryModelList;

  List<String> _Images=[];
  List<String> get Images =>_Images;

  List<PaletteColor?> _dycolors = [];
  List<PaletteColor?> get dycolors =>_dycolors;

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

  List<CategoryDeckModel>? _categoryDeckList;
  List<CategoryDeckModel>? get categoryDeckList => _categoryDeckList;

  List<NativeAd>? _nativeAdList = [];
  List<NativeAd>? get nativeAdList=>_nativeAdList;


  BannerAd? _banner;
  BannerAd? _Listbanner;

  InterstitialAd? _interstitialAd;
  RewardedAd? _rewardedAd;

  int _rewardedScore = 0;

  List<int>? _stackIndex;
  List<int>? get stackIndex =>_stackIndex;

  late NativeAd _nativeAd;
  NativeAd get nativeAd=>_nativeAd;

  bool nativeIsLoaded = false;

  BannerAd? get banner=>_banner;
  BannerAd? get Listbanner=>_Listbanner;
  InterstitialAd? get interstitialAd =>_interstitialAd;
  RewardedAd? get rewardedAd=>_rewardedAd;
  int get rewardedScore => _rewardedScore;

  int _clickCount = 0;
  int get clickCount => _clickCount;

  String? _selectedString;
  String? get selectedString =>_selectedString;

  bool _selected = false;
  bool get selected => _selected;

  bool _workManagerMagazine = false;
  bool  get workManagerMagazine =>_workManagerMagazine;


  setMagazine(bool value)async{
    _workManagerMagazine = value;
    await SharedPref.setWorkManager(value);
    update();
  }

  stopWorkManagerTasks()async{
    await DatabaseHelper().stopWorkManagerTasks();
    update();
  }


  selectedStackIndex(value)async{
    _stackIndex = value;
    update();
  }

  updatedStackIndex(stackIndex,int selectedIndex)async{
    List<int>? demo =[];
    for(var i=0;i<categoryDeckList!.length;i++){
      demo!.add(0);
    }
    _stackIndex = demo;
    _stackIndex![stackIndex] = selectedIndex;
    update();
  }


  selectedImagebool(boo)async{
    _selected = boo;
    update();
  }

  selectedImage(image,bool value)async{
   _selectedString = image;
   _selected = value;
    update();
  }


  updateUI()async{
    update();
  }

  setCategoryDeck(List<CategoryDeckModel>? model)async{
    // model!.sort((a,b)=>a.name!.compareTo(b.name!));
    _categoryDeckList = model;
    update();
  }

  shuffleList()async{

    _likedWallpaperModel!.data?.shuffle(Random());
    _productData?.shuffle(Random());
    _productReliventData?.shuffle(Random());
    _premiumProductData?.shuffle(Random());
    print("Shuffle Lists");
    update();
  }

  getCategoriesWallpaper()async{
    await DatabaseHelper().getCategoriesWallpaper();
    update();

  }

  getUserDetails(UserModel? savedUser)async{
    await DatabaseHelper().getUserDetails(savedUser);
    update();
  }

  buyPremium()async{
    await DatabaseHelper().buyPremium();
    update();
  }

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

  forgetPassword(email)async{
    await DatabaseHelper().forgetPassword(email);
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

  AddNativeAd(NativeAd ad)async{
    nativeAdList!.add(ad);
    print("Ad LENGTH: ${nativeAdList!.length}");
    update();
  }

  setProductList(GetProductModel model)async{
    var reversed = model.data!.reversed;
    model.data =reversed.toList();

    _productModelList = model;
    print("All product updated");
    update();
  }

  setListofProduct(List<ProductData>? data){
    _productData = data;
    shuffleList();
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

  startWorkManagerTask(text)async{
    await DatabaseHelper().startWorkManagerTask(text);
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
    createBannerAd();
    createInterstitialAd();
    createRewardedAd();
    TimerCount();
  //  loadBanner();
  }
  // NativeAd loadNativeAd(){
  //   NativeAd LnativeAd = NativeAd(
  //       adUnitId: '${AdMobService.nativeAdUniId}',
  //       listener: AdMobService.nativeAdListener,
  //       factoryId: 'listTile',
  //       request: AdRequest(),
  //   )..load();
  //   return LnativeAd;
  // }

  setCount()async{
    _clickCount++;
    print('${_clickCount}');
    update();
  }

  TimerCount()async{
    Timer.periodic(Duration(seconds: 5), (timer) {
      called();
    });
  }

  called()async{
    if (kDebugMode) {
      print('checking Auto Ad');
    }
    if(clickCount>=5){
      if(interstitial==true){
        showInterstitialAd();
        await setInerstialBool();
        return;
      }else{
        showInterstitialAd();
       await setInerstialBool();
      }
    }else{
      return;
    }
  }

  setBannerAd(BannerAd? value)async{
    _banner = value;
    update();
  }

  setBannerListAd(BannerAd? value)async{
    _Listbanner = value;
    update();
  }

  setInterstitialAd(InterstitialAd? ad)async{
    _interstitialAd = ad;
    update();
  }

  setRewardedAd(RewardedAd? ad)async{
    _rewardedAd = ad;
    update();
  }

  setInerstialBool()async{
    _interstitial = !interstitial;
    _clickCount=0;
    update();
  }

  setRewardScore()async{
    _rewardedScore++;
    update();
  }

   createBannerAd(){
    _banner = BannerAd(
      size: AdSize.banner,
      adUnitId: AdMobService.bannerAdUnitId!,
      listener: AdMobService.bannerAdListener,
      request: const AdRequest(
        keywords: ['gaming','pubg','freefire'],
      ),
    )..load();

  }

   BannerAd?createListBannerAd(){
    _Listbanner = BannerAd(
      size: AdSize.banner,
      adUnitId: AdMobService.bannerAdUnitId!,
      listener: AdMobService.ListbannerAdListener,
      request: const AdRequest(
        keywords: ['gaming','pubg','freefire'],
      ),
    )..load();
    return _Listbanner;
  }

   createInterstitialAd(){
    InterstitialAd.load(
      adUnitId: AdMobService.interstitialAdUnitId!,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (ad)=>_interstitialAd = ad,
          onAdFailedToLoad: (LoadAdError error){
            _interstitialAd = null;
          }
      ),
    );
  }

   createRewardedAd(){
    RewardedAd.load(
      adUnitId: AdMobService.rewardedAdUniId!,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) => _rewardedAd= ad,
        onAdFailedToLoad: (LoadAdError error) {
            _rewardedAd = null;
            // CustomSnackbar.show("Ad is not available at the moment. Try again later.", AppColors.red);
        },),
    );
  }

   showInterstitialAd(){
    if(_interstitialAd !=null){
      _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad){
          ad.dispose();
          createInterstitialAd();
        },
        onAdFailedToShowFullScreenContent: (ad,error){
          ad.dispose();
          createInterstitialAd();
        },
      );
      _interstitialAd!.show();
      _interstitialAd = null;
    }
  }

   showRewardedAd(wallpaper,bool value){
    CommonController commonController = Get.find<CommonController>();
    if(_rewardedAd != null){
      _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
          onAdDismissedFullScreenContent: (ad){
            print("Dissmissed");
            ad.dispose();
            commonController.setLoading(false);
            createRewardedAd();
          },
          onAdFailedToShowFullScreenContent: (ad,error){
            CustomSnackbar.show("${error.message}", AppColors.red);
            print("Failed to Load");
            ad.dispose();
            commonController.setLoading(false);
            createRewardedAd();
          }
      );
      _rewardedAd!.show(
          onUserEarnedReward:(ad,reward){
            commonController.setLoading(false);
              _rewardedScore++;
              Get.to(()=>SetWallpaperScreen(wallpaper,value));
          } );
      _rewardedAd = null;

    }
    else{
      CustomSnackbar.show("Ad is not available at the moment. Try again later.", AppColors.red);
      createRewardedAd();
    }

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