import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
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

import '../../../../../Constants/AppColors.dart';
import '../../../../../Models/CategoryModel.dart';
import '../../../../../Models/GetCategoryModel.dart';

class AddNewScreen extends StatefulWidget {
  CategoryModel _categoryModel;
  AddNewScreen(this._categoryModel, {super.key});

  @override
  State<AddNewScreen> createState() => _AddNewScreenState();
}

class _AddNewScreenState extends State<AddNewScreen> {
  CommonController commonController = Get.find<CommonController>();

  var _selectedImages = <File>[]; // List to hold selected images
  var _selectedImageNames = <String>[]; // List to hold names of selected images

  Future<void> _pickImage() async {
    final _picker = ImagePicker();
    List<XFile>? pickedFiles = await _picker.pickMultiImage();

    if (pickedFiles != null && pickedFiles.isNotEmpty) {
      setState(() {
        _selectedImages
            .addAll(pickedFiles.map((file) => File(file.path)).toList());
        _selectedImageNames.addAll(
            pickedFiles.map((file) => file.path.split('/').last).toList());
      });
    }
  }

  Datum? selectedCategory;
  bool premium = false;
  List<String> dataValues = [];
  bool Adding_Image = false;

  List<DataRow> rows = [];
  int currentRowId = 1;

  List<TextEditingController> textControllers = [];

  TextEditingController tagsController = TextEditingController();


  void addRow() {
    setState(() {
      TextEditingController textEditingController = TextEditingController();
      textControllers.add(textEditingController);

      DataRow? newRow = null;

      newRow = DataRow(
        cells: [
          DataCell(Text('TAG'.tr, style: TextStyle(color: Colors.white))),
          DataCell(
            Row(
              children: [
                Expanded(
                  child: TextField(
                    style: TextStyle(color: Colors.white),
                    controller: textEditingController,
                    decoration: InputDecoration(
                      hintText: 'EnterTag'.tr,
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
                        // rows.clear();
                        // dataValues.clear();

                        // SetTags();
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
    for (var i in dataValues) {
      // var responseJson = jsonDecode(i);
      print(i.toString());
      setState(() {
        TextEditingController textEditingController = TextEditingController();
        textEditingController.text = i;
        textControllers.add(textEditingController);

        DataRow? newRow = null;

        newRow = DataRow(
          cells: [
            DataCell(Text('TAG'.tr, style: TextStyle(color: Colors.white))),
            DataCell(
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      style: TextStyle(color: Colors.white),
                      controller: textEditingController,
                      decoration: InputDecoration(
                        hintText: 'EnterTag'.tr,
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
                          // da.removeAt(index);

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

  @override
  void initState() {
    // TODO: implement initState
    callCategory();
    // selectedCategory = commonController.categoryList![0];
    super.initState();
  }

  callCategory() async {
    for (var i in commonController.categoryList!) {
      if (i.id == widget._categoryModel.id) {
        selectedCategory = i;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CommonController>(builder: (controller) {
      return Stack(
        children: [
          Scaffold(
            backgroundColor: AppColors.black,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: AppColors.black,
              elevation: 0,
              title: Text(
                "AddWallpaper".tr,
                style: TextStyle(color: AppColors.white),
              ),
              centerTitle: true,
            ),
            body: Container(
              padding: EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: AppColors.black,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.end,
                    //   children: [
                    //     InkWell(
                    //       onTap: (){
                    //         _pickImage();
                    //       },
                    //       child: Text("PickWallpapers".tr,
                    //         style: TextStyle(color: Colors.white,fontSize: 15,decoration: TextDecoration.underline),
                    //       ),
                    //     ),
                    //   ],).marginOnly(bottom: 10),

                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          height: 300,
                          width: MediaQuery.of(context).size.width,
                          child: (_selectedImages.isEmpty)
                              ? Container(
                            alignment: Alignment.center,
                            child: Text(
                              "NoWallpaperSelected".tr,
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                              : Container(
                            alignment: Alignment.center,
                            height: 200,
                            width: MediaQuery.of(context).size.width * 0.6,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              // image: DecorationImage(
                              //   image: FileImage(_selectedImages),
                              //   fit: BoxFit.fill,
                              // ),
                            ),
                            // child: CarouselSlider.builder(
                            //     itemCount: _selectedImages.length,
                            //     options: CarouselOptions(
                            //       aspectRatio: 16 / 9,
                            //       viewportFraction: 0.8,
                            //       enlargeCenterPage: true,
                            //       enableInfiniteScroll: false,
                            //
                            //     ),
                            //     itemBuilder: (context, index, realIndex) {
                            //       return Container(
                            //         width: 80,
                            //         height: 100,
                            //         decoration: BoxDecoration(
                            //           borderRadius: BorderRadius.circular(10),
                            //           border: Border.all(width: 1,color: AppColors.white),
                            //         ),
                            //         child: FadeInImage(
                            //           placeholder: AssetImage('assets/images/modified_logo.png'),
                            //           image: FileImage(_selectedImages[index]),
                            //         ),
                            //       );
                            //
                            //     },
                            //     ),
                            child: GridView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: _selectedImages.length,
                              gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 1.0,
                                  crossAxisSpacing: 1.0,
                                  mainAxisExtent: 100),
                              itemBuilder: (context, index) {
                                return Container(
                                  width: 80,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        width: 1, color: AppColors.white),
                                  ),
                                  child: Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      Positioned.fill(
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(10),
                                          child: FadeInImage(
                                            placeholder: AssetImage(
                                                'assets/images/modified_logo.png'),
                                            image:
                                            FileImage(_selectedImages[index]),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),

                                      Positioned(
                                        right:5,
                                        top:5,
                                        child: InkWell(
                                          onTap:(){
                                            setState(() {
                                              _selectedImages.removeAt(index);
                                              _selectedImageNames.removeAt(index);
                                            });

                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            height: 25,
                                            width: 25,
                                            decoration: BoxDecoration(
                                                color: AppColors.black.withOpacity(0.3),
                                                shape: BoxShape.circle),

                                            child: Icon(Icons.clear,color: AppColors.white,size: 18,),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ).marginSymmetric(
                                    horizontal: 2, vertical: 2);
                              },
                            ),
                          ).marginSymmetric(horizontal: 5),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: InkWell(
                            onTap: () {
                              _pickImage();
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: 180,
                              height: 50,
                              decoration: BoxDecoration(
                                color: AppColors.red,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Text(
                                "PickWallpapers".tr,
                                style: TextStyle(
                                    color: AppColors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    DropdownButtonFormField<Datum>(
                      decoration: InputDecoration(
                        // labelText: 'Category',
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white, width: 1)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white, width: 1)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white, width: 1)),
                      ),
                      menuMaxHeight: 300,
                      dropdownColor: Colors.black,
                      value: selectedCategory,
                      onChanged: (Datum? newValue) {
                        setState(() {
                          selectedCategory = newValue;
                        });
                      },
                      items: commonController.categoryList
                          ?.map<DropdownMenuItem<Datum>>((Datum value) {
                        return DropdownMenuItem<Datum>(
                          value: value,
                          child: Text(
                            value.name!,
                            style: TextStyle(color: Colors.white),
                          ),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 20),

                    SizedBox(height: 16.0),

                    SwitchListTile(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(1),
                          side: BorderSide(width: 1, color: Colors.white)),
                      activeColor: AppColors.red,
                      title: Text(
                        "Premium".tr,
                        style: TextStyle(color: Colors.white),
                      ),
                      value: premium,
                      onChanged: (value) {
                        setState(() {
                          premium = value;
                        });
                      },
                    ),

                    SizedBox(
                      height: 20,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "TAGS".tr,
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ).marginOnly(left: 10),
                        // InkWell(
                        //     onTap: () {
                        //       addRow();
                        //     },
                        //     child: Icon(
                        //       Icons.add,
                        //       size: 24,
                        //       color: Colors.white,
                        //     ).marginOnly(right: 10))
                      ],
                    ),

                    SizedBox(
                      height: 20,
                    ),

                    // Container(
                    //   width: MediaQuery.of(context).size.width,
                    //   child: DataTable(
                    //     dataRowColor: MaterialStatePropertyAll(Colors.red),
                    //     decoration: BoxDecoration(
                    //         shape: BoxShape.rectangle,
                    //         border: Border.all(color: Colors.white, width: 1)),
                    //     columns: [
                    //       DataColumn(
                    //           label: Text(
                    //         'TAG'.tr,
                    //         style: TextStyle(color: Colors.white),
                    //       )),
                    //       DataColumn(
                    //           label: Text(
                    //         'Data'.tr,
                    //         style: TextStyle(color: Colors.white),
                    //       )),
                    //     ],
                    //     rows: rows,
                    //   ),
                    // ),

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


                    SizedBox(
                      height: 20,
                    ),

                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.red,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          onPressed: () async {
                            if ((_selectedImages == null || _selectedImages.length==0) ||
                                (tagsController.text==null)) {
                              CustomSnackbar.show(
                                  "WallpaperImageAndTagsAreRequired".tr,
                                  AppColors.red);

                            } else if (tagsController.text.isEmpty) {
                              CustomSnackbar.show(
                                  "YouCannotPassAnEmptyTag".tr, AppColors.red);
                            }
                            else {
                              await commonController.setLoading(true);
                              final split = tagsController.text.split(',');
                              if (premium == true) {
                                CreateProductModel model = CreateProductModel(
                                  "",
                                  name: _selectedImageNames,
                                  image: _selectedImages,
                                  category_id: selectedCategory?.id,
                                  for_premium: 1,
                                  tags: split,
                                );
                                await commonController.createProduct(
                                    model, widget._categoryModel, context);
                              } else {
                                final split = tagsController.text.split(',');
                                if(split.last ==" "  || split.last ==""){
                                  split.removeAt(split.length-1);
                                }
                                CreateProductModel model = CreateProductModel(
                                  "",
                                  name: _selectedImageNames,
                                  image: _selectedImages,
                                  category_id: selectedCategory?.id,
                                  for_premium: 0,
                                  tags: split,
                                );

                                await commonController.createProduct(
                                    model, widget._categoryModel, context);
                                // Navigator.pop(context);
                              }
                            }
                          },
                          child: Text("Upload".tr)),
                    )
                  ],
                ),
              ),
            ),
          ),

          Visibility(
              visible: controller.isLoading,
              child: LoadingAnimation()),
        ],
      );
    },);
  }
}
