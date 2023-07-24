import 'dart:convert';
import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wall_master_admin/Controllers/CommonController.dart';
import 'package:wall_master_admin/CustomWidgets/CustomSnackbar.dart';
import 'package:wall_master_admin/CustomWidgets/LoadingAnimation.dart';
import 'package:wall_master_admin/Models/CreateProductModel.dart';
import 'package:wall_master_admin/Models/GetProductModel.dart';
import 'package:wall_master_admin/Models/UpdateProductModel.dart';

import '../../../../../Constants/AppColors.dart';
import '../../../../../Models/CategoryModel.dart';
import '../../../../../Models/GetCategoryModel.dart';

class EditWallpaperScreen extends StatefulWidget {
  ProductData _productData;
  EditWallpaperScreen(this._productData,{super.key});

  @override
  State<EditWallpaperScreen> createState() => _EditWallpaperScreenState();
}

class _EditWallpaperScreenState extends State<EditWallpaperScreen> {

  CommonController commonController = Get.find<CommonController>();
  var _selectedImages;
  var _selectedImageName;

  Future<void> _pickImage() async {
    final _picker = ImagePicker();
    final pickedFile  = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile  != null) {
      setState(() {
        _selectedImageName = pickedFile.path.split('/').last;
        _selectedImages = File(pickedFile.path);
      });
    }
  }

  Datum? selectedCategory ;
  bool premium= false;
  List<String> dataValues = [];
  bool Adding_Image = false;

  List<DataRow> rows = [];
  int currentRowId = 1;

  List<String> tags =[];



  List<TextEditingController> textControllers = [];
  TextEditingController tagsController = TextEditingController();

  void addRow() {
    setState(() {
      TextEditingController textEditingController = TextEditingController();
      textControllers.add(textEditingController);

      DataRow? newRow = null;

      newRow = DataRow(
        cells: [
          DataCell(Text('TAG ', style: TextStyle(color: Colors.white))),
          DataCell(
            Row(
              children: [
                Expanded(
                  child: TextField(
                    style: TextStyle(color: Colors.white),
                    controller: textEditingController,
                    decoration: InputDecoration(
                      hintText: 'Enter tag',
                      hintStyle: TextStyle(color: Colors.white),
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onChanged: (value) {
                      int index = rows.indexOf(newRow!);
                      dataValues[index] = value;
                      dataValues[index] = textEditingController.text;
                    },
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      int index = rows.indexOf(newRow!);
                      if (index >= 0) {
                        rows.removeAt(index);
                        dataValues.removeAt(index);
                        // tags.removeAt(index);

                        // Reassign row numbers
                        // for (int i = 0; i < rows.length; i++) {
                        //   rows[i] = DataRow(
                        //     cells: [
                        //       DataCell(Text('TAG ${i + 1}', style: TextStyle(color: Colors.white))),
                        //       rows[i].cells[1],
                        //     ],
                        //   );
                        // }
                        rows.clear();
                        dataValues.clear();
                        SetTags();


                      }
                    });
                  },
                  child: Icon(Icons.close, color: AppColors.white),
                ),
              ],
            ),
          ),
        ],
      );
      rows.add(newRow);
      dataValues.add('');
      currentRowId++;
    });
  }
  SetTags() async {
    tagsController.text = tags.join(",");
    for (var i in tags) {
      // var responseJson = jsonDecode(i);

      print(i.toString());
      setState(() {
        TextEditingController textEditingController = TextEditingController();
        textEditingController.text = i;
        textControllers.add(textEditingController);

        DataRow? newRow = null;

        newRow = DataRow(
          cells: [
            DataCell(Text('TAG', style: TextStyle(color: Colors.white))),
            DataCell(
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      style: TextStyle(color: Colors.white),
                      controller: textEditingController,
                      decoration: InputDecoration(
                        hintText: 'Enter tag',
                        hintStyle: TextStyle(color: Colors.white),
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onChanged: (value) {
                        int index = rows.indexOf(newRow!);
                        dataValues[index] = value;
                        dataValues[index] = textEditingController.text;
                      },
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        int index = rows.indexOf(newRow!);
                        if (index >= 0) {
                          rows.removeAt(index);
                          dataValues.removeAt(index);
                          tags.removeAt(index);

                          // Reassign row numbers
                          // for (int i = 0; i < rows.length; i++) {
                          //   rows[i] = DataRow(
                          //     cells: [
                          //       DataCell(Text('TAG ${i + 1}', style: TextStyle(color: Colors.white))),
                          //       rows[i].cells[1],
                          //     ],
                          //   );
                          // }
                              rows.clear();
                              dataValues.clear();
                             SetTags();


                        }
                      });
                    },
                    child: Icon(Icons.close, color: AppColors.white),
                  ),
                ],
              ),
            ),
          ],
        );
        rows.add(newRow);
        dataValues.add(textEditingController.text);
        currentRowId++;
      });
    }
  }





  getTags()async{
    for(var i in widget._productData.tags!){
      setState(() {
        tags.add(i['tag']);
      });
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    getTags();
    selectedCategory = commonController.categoryList![0];
    premium = (widget._productData.forPremium==0)?false:true;
    callCategory();
    SetTags();
    super.initState();
  }
  callCategory()async{
    for(var i in commonController.categoryList!){
      if(i.id ==widget._productData.categoryId){
        selectedCategory = i;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: AppColors.black,
          appBar: AppBar(
            automaticallyImplyLeading: true,
            backgroundColor: AppColors.black,
            elevation: 0,
            title: Text("Edit Wallpaper",style: TextStyle(color: AppColors.white),),
            centerTitle: true,
          ),

          body: Container(
            padding: EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: AppColors.black,
            child:  SingleChildScrollView(
              child: Column(
                children: [

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: (){
                          _pickImage();
                        },
                        child: Text("Pick Wallpapers",
                          style: TextStyle(color: Colors.white,fontSize: 15,decoration: TextDecoration.underline),
                        ),
                      ),
                    ],).marginOnly(bottom: 10),

                  Container(
                    height: 300,
                    child: (_selectedImages==null)
                        ?Container(
                      alignment: Alignment.center,
                      height: 200,
                      width: MediaQuery.of(context).size.width*0.6,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: NetworkImage(widget._productData.image!),
                          fit: BoxFit.fill,
                        ),
                      ),

                    ).marginSymmetric(horizontal: 5)
                        :Container(
                      alignment: Alignment.center,
                      height: 200,
                      width: MediaQuery.of(context).size.width*0.6,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: FileImage(_selectedImages),
                          fit: BoxFit.fill,
                        ),
                      ),

                    ).marginSymmetric(horizontal: 5),
                  ),
                  SizedBox(height: 20,),

                  DropdownButtonFormField<Datum>(
                    decoration: InputDecoration(
                      // labelText: 'Category',
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white,width: 1)
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white,width: 1)
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white,width: 1)
                      ),
                    ),
                    menuMaxHeight: 300,
                    dropdownColor: Colors.black,
                    value: selectedCategory,
                    onChanged: (Datum? newValue) {
                      setState(() {
                        selectedCategory = newValue;
                      });
                    },
                    items: commonController.categoryList?.map<DropdownMenuItem<Datum>>((Datum value) {
                      return DropdownMenuItem<Datum>(
                        value: value,
                        child: Text(value.name!,style: TextStyle(color: Colors.white),),
                      );
                    }).toList(),


                  ),
                  SizedBox(height: 20),

                  SizedBox(height: 16.0),

                  SwitchListTile(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(1),
                        side: BorderSide(width: 1,color: Colors.white)),
                    activeColor: AppColors.red,
                    title: Text("Premium",style: TextStyle(color: Colors.white),),
                    value: premium, onChanged: (value) {
                    setState(() {
                      premium = value;
                    });

                  },),

                  SizedBox(height: 20,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("TAGS",style: TextStyle(color: Colors.white,fontSize: 20),).marginOnly(left: 10),
                      InkWell(
                          onTap: (){
                            addRow();
                          },
                          child: Icon(Icons.add,size: 24,color: Colors.white,).marginOnly(right: 10))
                    ],
                  ),

                  SizedBox(height: 20,),

                  TextFormField(
                    minLines: 1,
                    maxLines: null,
                    controller: tagsController,
                    keyboardType: TextInputType.text,
                    cursorColor: AppColors.red,
                    style: TextStyle(color: AppColors.white),
                    decoration: InputDecoration(
                      hintText: 'Type here...'.tr,
                      hintStyle: TextStyle(color: AppColors.white.withOpacity(0.6)),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(color: AppColors.white,width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(color: AppColors.white,width: 1),
                      ),
                    ),
                  ),

                  // Container(
                  //   width: MediaQuery.of(context).size.width,
                  //   child: DataTable(
                  //     dataRowColor: MaterialStatePropertyAll(Colors.red),
                  //     decoration: BoxDecoration(
                  //         shape: BoxShape.rectangle,
                  //         border: Border.all(color: Colors.white,width: 1)
                  //     ),
                  //     columns: [
                  //       DataColumn(label: Text('TAG',style: TextStyle(color: Colors.white),)),
                  //       DataColumn(label: Text('Data',style: TextStyle(color: Colors.white),)),
                  //     ],
                  //     rows: rows,
                  //   ),
                  // ),


                  SizedBox(height: 20,),

                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.red,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                        ),
                        onPressed: () async {

                          if((tagsController.text==null || tagsController.text.isEmpty)){
                            CustomSnackbar.show("Tags are required", AppColors.red);
                          }
                          else{
                            commonController.setLoading(true);
                            final split = tagsController.text.split(",");
                            if(premium==true){
                              UpdateProductModel model = UpdateProductModel(
                                widget._productData.id,
                                name: (_selectedImageName==null)?widget._productData.name:_selectedImageName,
                                image: _selectedImages,
                                category_id: selectedCategory?.id,
                                for_premium: 1,
                                tags: split,
                              );
                              await commonController.updateProduct(model,context);

                            }else{
                              final split = tagsController.text.split(",");
                              UpdateProductModel model = UpdateProductModel(
                                widget._productData.id,
                                name: (_selectedImageName==null)?widget._productData.name:_selectedImageName,
                                image: _selectedImages,
                                category_id: selectedCategory?.id,
                                for_premium: 0,
                                tags: split,
                              );

                              await commonController.updateProduct(model,context);
                              commonController.setLoading(false);
                              // Navigator.pop(context);
                            }

                          }




                        }, child: Text("Update")),
                  )

                ],
              ),
            ),
          ),
        ),

        GetBuilder<CommonController>(builder: (controller) {
          return Visibility(
            visible: controller.isLoading,
              child: LoadingAnimation());
        },)
      ],
    );
  }
}
