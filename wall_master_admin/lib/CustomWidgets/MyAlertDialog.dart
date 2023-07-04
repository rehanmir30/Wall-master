import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../Constants/AppColors.dart';
import '../Controllers/LocalizationController.dart';

class MyAlertDialog extends StatefulWidget {
  @override
  _MyAlertDialogState createState() => _MyAlertDialogState();
}

class _MyAlertDialogState extends State<MyAlertDialog> {
  String selectedOption = Get.find<Localization>().dropdownValue["name"];

  // void _showDialog() {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {

  //   },
  // ).then((value) {
  //   // Handle selected option here
  //   if (value != null) {
  //     print('Selected option: $value');
  //     // Do something with the selected option
  //   }
  // });
  // }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.all(0),
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20,),
          RadioListTile(
            activeColor: AppColors.red,
            title: Text('English'),
            value: 'English',
            groupValue: selectedOption,
            onChanged: (value) {
              setState(() {
                selectedOption = value!;
              });
            },
          ),
          RadioListTile(
            activeColor: AppColors.red,
            title: Text('Spanish'),
            value: 'Spanish',
            groupValue: selectedOption,
            onChanged: (value) {
              setState(() {
                selectedOption = value!;
              });
            },
          ),
        ],
      ),
      actions: [

        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: AppColors.white,elevation: 0),
          child: Text('CANCEL',style: TextStyle(color: AppColors.red),),
          onPressed: () {
            Navigator.of(context).pop(selectedOption);
          },
        ),

        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: AppColors.white,elevation: 0),
          child: Text('OK',style: TextStyle(color: AppColors.red)),
          onPressed: () {
            Localization loacl = Get.find<Localization>();
            loacl.setSelectedLang(selectedOption);
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}