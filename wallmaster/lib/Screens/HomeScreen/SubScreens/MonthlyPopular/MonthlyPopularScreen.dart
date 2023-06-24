import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallmaster/CustomWidgets/CommonWidget.dart';

import '../../../../../Constants/AppColors.dart';

class MonthlyPopularScreen extends StatefulWidget {
  const MonthlyPopularScreen({super.key});

  @override
  State<MonthlyPopularScreen> createState() => _MonthlyPopularScreenState();
}

class _MonthlyPopularScreenState extends State<MonthlyPopularScreen> {
  List<String> MonthlyPopularList = ['Abstract','Animals','Artistic','Astronomy','Autumn','Babies & Kids','Birds','Abstract','Animals','Artistic','Astronomy','Autumn','Babies & Kids','Birds','Abstract','Animals','Artistic','Astronomy','Autumn','Babies & Kids','Birds'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: GridView.builder(
        shrinkWrap: true,
        primary: true,
        itemCount: MonthlyPopularList.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          // crossAxisSpacing: 10.0,
            mainAxisSpacing: 1.0,
            mainAxisExtent: 200,
            crossAxisCount: 3),
        itemBuilder: (context, index) {
          return CommonWidget(MonthlyPopularList[index]);

        },).marginSymmetric(horizontal: 10),
    );
  }
}
