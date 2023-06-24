import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallmaster/CustomWidgets/CommonWidget.dart';

import '../../../../../Constants/AppColors.dart';

class RandomScreen extends StatefulWidget {
  const RandomScreen({super.key});

  @override
  State<RandomScreen> createState() => _RandomScreenState();
}

class _RandomScreenState extends State<RandomScreen> {
  List<String> randomList = ['Abstract','Animals','Artistic','Astronomy','Autumn','Babies & Kids','Birds','Abstract','Animals','Artistic','Astronomy','Autumn','Babies & Kids','Birds','Abstract','Animals','Artistic','Astronomy','Autumn','Babies & Kids','Birds'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: GridView.builder(
        shrinkWrap: true,
        primary: true,
        itemCount: randomList.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          // crossAxisSpacing: 10.0,
            mainAxisSpacing: 1.0,
            mainAxisExtent: 200,
            crossAxisCount: 3),
        itemBuilder: (context, index) {
          return CommonWidget(randomList[index]);

        },).marginSymmetric(horizontal: 10),
    );
  }
}
