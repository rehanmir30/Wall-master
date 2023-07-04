import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:wall_master_admin/Constants/AppColors.dart';
import 'package:wall_master_admin/Views/Screens/HomeScreen/SubScreens/AllUserScreen/UserDetailScreen.dart';

import '../Models/GetAllUserModel.dart';

class UserWidget extends StatefulWidget {
  List<UserData>? _allUserModel;
  int index;
  UserWidget(this._allUserModel,this.index,{super.key});

  @override
  State<UserWidget> createState() => _UserWidgetState();
}

class _UserWidgetState extends State<UserWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Get.to(()=>UserDetailScreen(widget._allUserModel![widget.index]));
      },
      child: Container(
        child: ListTile(
          tileColor: Colors.black,
          leading: CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage("assets/images/logo.png"),
            backgroundColor: Colors.transparent,
          ),
          title: Text(widget._allUserModel![widget.index].name.toString(),style: TextStyle(color: AppColors.white),),
        ).marginSymmetric(vertical: 5),
      ),
    );
  }
}
