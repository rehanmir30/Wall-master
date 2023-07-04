import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:wall_master_admin/Constants/AppColors.dart';
import 'package:wall_master_admin/Controllers/CommonController.dart';
import 'package:wall_master_admin/CustomWidgets/UserWidget.dart';
import 'package:wall_master_admin/Models/GetAllUserModel.dart';

class AllUserScreen extends StatefulWidget {
  const AllUserScreen({super.key});

  @override
  State<AllUserScreen> createState() => _AllUserScreenState();
}

class _AllUserScreenState extends State<AllUserScreen> {
  CommonController commonController = Get.find<CommonController>();
  final searchController = TextEditingController();


  List<UserData>? filteredUsers = [];
  bool searhing = false;

   performSearch(String query)async{
    if (query.isEmpty) {
      // If the search query is empty, display all users
      setState(() {
        searhing = false;
        filteredUsers = commonController.allUserModel?.data;
      });
    } else {
      // Perform the search based on the query
      setState(() {
        filteredUsers = commonController.allUserModel?.data?.where((user) =>
            user.name!.toLowerCase().contains(query.toLowerCase())).toList();
        searhing = true;
      });
    }
    print(filteredUsers!.length.toString());
  }

  @override
  void initState() {
    // TODO: implement initState

    searhing =false;
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        backgroundColor: AppColors.black,
        elevation: 0,
        title: Text("Users".tr),
        centerTitle: true,

      ),

      body: Container(
        color: AppColors.black,
        child: Column(
          children: [
            Container(
              height: 50,
              child: TextFormField(
                controller: searchController,
                autofocus: false,
                style: TextStyle(color: Colors.white,letterSpacing: 1),
                onChanged: (val) async {
                   await  performSearch(val);


                },

                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 15),
                  hintText: "Search".tr,
                  hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
                  suffixIcon: Icon(Icons.search,color: Colors.white,),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Colors.white,width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: AppColors.red,width: 1),
                  ),

                ),
              )
            ).marginOnly(bottom: 10,top: 10,right: 10,left: 10),
            GetBuilder<CommonController>(builder: (controller) {
              return (controller.allUserModel!.data!.length==0||controller.allUserModel!.data!.length==null)
                  ?Center(child: Text("NoUserFound".tr,style: TextStyle(color: AppColors.white,fontSize: 24),),)
                  :(filteredUsers!.length==0 && searhing==true)?Center(child: Text("NoSearchedFound".tr,style: TextStyle(color: Colors.white,fontSize: 18),),):Expanded(
                child: ListView.builder(
                  itemCount: (searhing==false)?controller.allUserModel!.data!.length:filteredUsers!.length,
                  itemBuilder: (context, index) {
                    return (searhing==false)?UserWidget(controller.allUserModel!.data,index):UserWidget(filteredUsers, index);
                  },).marginSymmetric(horizontal: 10),
              );
            },)
          ],
        ),
      ),
    );
  }
}
