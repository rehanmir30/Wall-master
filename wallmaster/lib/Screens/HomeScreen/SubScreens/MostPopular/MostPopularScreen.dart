import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallmaster/CustomWidgets/CommonWidget.dart';

import '../../../../../Constants/AppColors.dart';

class MostPopularScreen extends StatefulWidget {
  const MostPopularScreen({super.key});

  @override
  State<MostPopularScreen> createState() => _MostPopularScreenState();
}

class _MostPopularScreenState extends State<MostPopularScreen> {
  List<String> mostPopularList = ['Abstract','Animals','Artistic','Astronomy','Autumn','Babies & Kids','Birds','Abstract','Animals','Artistic','Astronomy','Autumn','Babies & Kids','Birds','Abstract','Animals','Artistic','Astronomy','Autumn','Babies & Kids','Birds'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: GridView.builder(
        shrinkWrap: true,
        primary: true,
        itemCount: mostPopularList.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          // crossAxisSpacing: 10.0,
            mainAxisSpacing: 1.0,
            mainAxisExtent: 200,
            crossAxisCount: 3),
        itemBuilder: (context, index) {
          return CommonWidget(mostPopularList[index]);

        },).marginSymmetric(horizontal: 10),
    );
  }
}
