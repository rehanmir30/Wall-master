import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wall_master_admin/Controllers/CommonController.dart';
import 'package:wall_master_admin/CustomWidgets/LoadingAnimation.dart';

import '../../../../../Constants/AppColors.dart';
import '../../../../../Models/GetCategoryModel.dart';

class SortCategories extends StatefulWidget {
  SortCategories({super.key});

  @override
  State<SortCategories> createState() => _SortCategoriesState();
}

class _SortCategoriesState extends State<SortCategories> {
  CommonController commonController = Get.find<CommonController>();
  GlobalKey<ReorderableListState> listKey = GlobalKey<ReorderableListState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    listKey.currentState?.cancelReorder();
    listKey.currentState?.dispose();
    listKey.currentState?.deactivate();
    listKey.currentContext?.mounted;
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: AppColors.black,
        elevation: 0,
        title: Text("SortCategories".tr.toUpperCase(),style: TextStyle(color: AppColors.white,fontFamily: 'agency',letterSpacing: 1.0,),),
        centerTitle: true,

        actions: [
          InkWell(
            onTap: () async {
              await commonController.setLoading(true);
              await commonController.sendCategoryPriority(commonController.sortCategoriesList!);
              await commonController.setLoading(false);
            },
            child: Row(
              children: [
                Icon(Icons.save),
                SizedBox(width: 5,),
                Text('Save'.tr,style: TextStyle(color: AppColors.white,fontFamily: 'agency',letterSpacing: 1.0,),),
              ],
            ),
          ).marginSymmetric(horizontal: 10)
        ],
      ),

      body:GetBuilder<CommonController>(builder: (controller) {
        return Stack(
          children: [
            ReorderableListView(
              itemExtent: 200,
              key: listKey,
              onReorder: recorderData,
              children: <Widget>[
                for(final item in controller.sortCategoriesList!)
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 2,vertical: 2),
                    key: ValueKey(item.id),
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    decoration: BoxDecoration(
                      // image: DecorationImage(
                      //   fit: BoxFit.fill,
                      //   // image: NetworkImage(widget.categoryModel!.data![widget.index].image.toString()),
                      //   // image: FadeInImage(image: CachedNetworkImageProvider(), placeholder: ,),
                      // ),
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: FadeInImage(
                            height: 280,
                            width: MediaQuery.of(context).size.width,
                            placeholder:  const AssetImage("assets/images/circle_logo.png"),
                            image: CachedNetworkImageProvider(item.image.toString()),
                            fit: BoxFit.fill,
                            placeholderFit: BoxFit.contain,
                          ),
                        ),

                        Text(item.name.toString(),style: TextStyle(color: AppColors.white,fontSize: 20,fontFamily: 'agency',letterSpacing: 2.0,),),

                      ],
                    ),
                    // child: Text(widget.categoryModel!.data![widget.index].name.toString(),style: TextStyle(color: AppColors.white,fontSize: 20,fontFamily: 'agency',letterSpacing: 2.0,),),
                  )
                  // Container(
                  //   key: ValueKey(item.id),
                  //   alignment: Alignment.center,
                  //   decoration: BoxDecoration(
                  //     color: AppColors.white,
                  //     borderRadius: BorderRadius.circular(15),
                  //     image: DecorationImage(
                  //         image: NetworkImage("${item.image}"),
                  //         fit: BoxFit.fill
                  //     ),
                  //   ),
                  //   child:  Text('${item.name}',style: TextStyle(color: AppColors.white,fontSize: 22,fontWeight: FontWeight.bold),),
                  // ),

                  // ListTile(
                  //   tileColor: Colors.red,
                  //   key: ValueKey(item.id),
                  //   title: Text('${item.name}',style: TextStyle(color: AppColors.white,),),
                  // )

              ],

            ),

            Visibility(
                visible: controller.isLoading,
                child: LoadingAnimation()),
          ],
        );
      },),


    );
  }
  recorderData(int oldIndex, int newIndex) {
    setState(() {
      if(newIndex>oldIndex){
        newIndex-=1;
      }
      final items =commonController.sortCategoriesList!.removeAt(oldIndex);
      commonController.sortCategoriesList!.insert(newIndex, items);
      int j=0;
      for(var i in commonController.sortCategoriesList!){
        i.priority = j+1;
        j++;
      }

      for(var i in commonController.sortCategoriesList!){
        print("Category Name: ${i.name}");
        print("Priority: ${i.priority}");

      }

    });
  }
}

