import 'package:flutter/material.dart';


class ApiConstants{

  //Base Url
  static const baseUrl = "http://wallmaster.gwebsoft.org/";

  //Login API
  static const loginApi = "api/user/login";

  //Register API
  static const registerApi = "api/user/register";

  //Logout API
  static const logoutApi = "api/logout";

  //Profile Update
  static const profileUpdateApi = "api/profile/update";

  //Change Language (Onlhy want to use language parameter and for clarity in the application code so we can specified the implementation )
  static const changeLanguageApi = "api/profile/update";

  //Forget Password
  static const forgetPasswordApi = "api/forgot/password";

  //Get User Detail
  static const getDetailApi =  "api/user/profile/detail";


  //Category Url
  //Get Category Url
  static const getCategoryListUrl = "api/category";


  //Product Urls
  //Get Product List Url
  static const getProductListUrl = "api/product";
  //Like Product Urls
  static const getAllLikeProductUrl = "api/user/like/list";
  //Update Like Product Url
  static const updateLikeProductUrl = "api/user/update/like";


}