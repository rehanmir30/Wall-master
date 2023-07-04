import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallmaster/CustomWidgets/CommonWidget.dart';

import '../../../../../Constants/AppColors.dart';

class WeeklyScreen extends StatefulWidget {
  const WeeklyScreen({super.key});

  @override
  State<WeeklyScreen> createState() => _WeeklyScreenState();
}

class _WeeklyScreenState extends State<WeeklyScreen> {
  List<String> weeklyList = ['Abstract','Animals','Artistic','Astronomy','Autumn','Babies & Kids','Birds','Abstract','Animals','Artistic','Astronomy','Autumn','Babies & Kids','Birds','Abstract','Animals','Artistic','Astronomy','Autumn','Babies & Kids','Birds'];

  @override
  Widget build(BuildContext context) {
    return Scaffold();
    // return Scaffold(
    //   backgroundColor: AppColors.black,
    //   body: GridView.builder(
    //     shrinkWrap: true,
    //     primary: true,
    //     itemCount: weeklyList.length,
    //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    //       // crossAxisSpacing: 10.0,
    //         mainAxisSpacing: 1.0,
    //         mainAxisExtent: 200,
    //         crossAxisCount: 3),
    //     itemBuilder: (context, index) {
    //       return CommonWidget(weeklyList[index]);
    //
    //     },).marginSymmetric(horizontal: 10),
    // );
  }
}
