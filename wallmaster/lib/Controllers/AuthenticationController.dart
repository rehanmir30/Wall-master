import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallmaster/DB/DatabaseHelper.dart';
import 'package:wallmaster/Model/UserModel.dart';


class AuthenticationController extends GetxController{

  UserModel? _myUser;
  UserModel? get myUser=>_myUser;

  setUserData(UserModel userModel){
    _myUser = userModel;
    update();
  }

  SignUpUser(name,email,password)async{
    await DatabaseHelper().SignUp(name, email, password);
    update();
  }

  SignInUser(email,password)async{
    await DatabaseHelper().SignIn(email, password);
    update();
  }
  SignOut(UserModel model)async{
    await DatabaseHelper().SignOut(model);
    update();
  }



}