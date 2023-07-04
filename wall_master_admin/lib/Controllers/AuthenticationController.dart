import 'package:get/get.dart';
import 'package:wall_master_admin/DatabaseHelper/DatabaseHelper.dart';
import 'package:wall_master_admin/Models/AdminModel.dart';

class AuthenticationController extends GetxController{

  AdminModel? _adminModel;
  AdminModel? get adminModel=>_adminModel;


  setAdminData(AdminModel adminModel)async{
    _adminModel = adminModel;
    update();
  }

  signIn(email,password)async{
    await DatabaseHelper().signIn(email, password);
    update();
  }

  signOut(AdminModel adminModel)async{
    await DatabaseHelper().signOut(adminModel);
    update();
  }

}