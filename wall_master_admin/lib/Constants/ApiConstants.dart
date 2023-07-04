import 'package:flutter/material.dart';

class ApiConstants{

  //Base Url
  static const baseUrl = "https://gwebsoft.org/";
  //Login Url for Admin
  static const loginUrl = "api/admin/login";
  //Logout Url for Admin
  static const logoutUrl = "api/logout";
  //Profile Update
  static const profileUpdateUrl = "api/profile/update";

  //Category Urls

  //Create Category Url
  static const createCategoryUrl = "api/admin/category/create";
  //Update Category Url
  static const updateCategoryUrl = "api/admin/category/update";
  //Delete Category Url
  static const deleteCategoryUrl = "api/admin/category/delete";
  //Get Category Url
  static const getCategoryListUrl = "api/category";


  //Product Urls

  //Create Product Url
  static const createProductUrl = "api/admin/product/create";
  //Update Product Url
  static const updateProductUrl = "api/admin/product/update";
  //Delete Product Url
  static const deleteProductUrl = "api/admin/product/delete";
  //Get Product List Url
  static const getProductListUrl = "api/product";

  //Client Urls

  //Get all Users
  static const getAllUsersUrl = "api/admin/user/list";


  //Like Product Urls
  static const getAllLikeProductUrl = "api/user/like/list";
  //Update Like Product Url
  static const updateLikeProductUrl = "api/user/update/like";

}