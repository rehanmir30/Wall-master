import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:wallmaster/Controllers/CommonController.dart';

class ReliventImages extends StatefulWidget {
  const ReliventImages({super.key});

  @override
  State<ReliventImages> createState() => _ReliventImagesState();
}

class _ReliventImagesState extends State<ReliventImages> {

  // CommonController commonController  = Get.find<CommonController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: GetBuilder<CommonController>(builder: (controller) {
        return  Stack(
          children: [
            Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(controller.productReliventData![0].image!),
                      fit: BoxFit.fill,
                    )
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 50.0, sigmaY: 50.0),
                  child: Container(
                    decoration: BoxDecoration(color: Colors.white.withOpacity(0.0)),
                  ),
                )
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height*0.7,
                  child: PageView(
                    controller: PageController(initialPage: 0),
                    scrollDirection: Axis.horizontal,
                    onPageChanged: (int index){

                    },
                    children: controller.productReliventData!
                        .map((e) => Container(
                      color: Colors.transparent,
                      child: Image.network(e.image!,fit: BoxFit.fill,))
                    ).toList(),
                  ),
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
        InkWell(
        onTap: () async {
        await controller.setLoading(true);
        // await controller.updateLikeProduct(widget.productData.id, widget.notFromLike);
        await controller.setLiked(true);
        await controller.setLoading(false);
        },
        child: (controller.isLiked==true)
        ?Icon(CupertinoIcons.heart_fill,color: Colors.white,)
            :Icon(CupertinoIcons.heart,color: Colors.white,)).marginSymmetric(horizontal: 5),
                    Container(
                      padding: EdgeInsets.all(17),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white
                      ),
                      child: Icon(Icons.download,size: 30,),
                    ).marginSymmetric(horizontal: 5),
                    Icon(Icons.mobile_screen_share_outlined,size: 34,color: Colors.white,).marginSymmetric(horizontal: 5)

                  ],),
              ],).marginSymmetric(horizontal: 40,vertical: 10),
          ],);
      },),
    );
  }
}
