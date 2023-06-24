import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:wallmaster/Constants/AppColors.dart';
class PremiumPackage extends StatefulWidget {
  const PremiumPackage({super.key});

  @override
  State<PremiumPackage> createState() => _PremiumPackageState();
}

class _PremiumPackageState extends State<PremiumPackage> {
  bool agreement= false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        backgroundColor: AppColors.black,
        elevation: 0,
        leading: InkWell(
            onTap: (){
              Get.back();
            },
            child: Icon(Icons.arrow_back_ios_new_rounded,color: Colors.white,size: 20,)),

        title: const Text("Buy Premium"),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50,),
            Align(
              alignment: Alignment.center,
              child: CircleAvatar(
                radius: 40,
                backgroundColor: Colors.red,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.black,
                    image: DecorationImage(
                      image:  AssetImage("assets/images/logo.png"),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10,),

            Align(
                alignment: Alignment.center,
                child: Text("Wall Master",style: TextStyle(color: Colors.white,fontSize: 28),)),
            SizedBox(height: 40,),

            Text("Upgrade to our Premium Package and enjoy exclusive benefits that will elevate your wallpaper app experience. With unlimited access to a diverse library of high-quality wallpapers, you can easily personalize your device with stunning images that match your style and mood. Say goodbye to interruptions with our ad-free environment, allowing you to browse seamlessly and focus on discovering the perfect wallpapers. Plus, with an increased wallpaper limit, you can expand your collection and effortlessly switch between favorites. Gain early access to new releases and exclusive collections, staying ahead of trends and accessing unique wallpapers. Enjoy priority customer support, ensuring a smooth experience throughout your subscription. Upgrade today and unlock a world of possibilities for your wallpaper app journey.",style: TextStyle(fontSize: 14,color: Colors.white),),


            SizedBox(height: 40,),
            Text("What we provide:",style: TextStyle(color: Colors.white,fontSize: 22),),
            SizedBox(height: 10,),
            Row(
              children: [
              Icon(Icons.done_outlined,color: Colors.white,size: 18,),
                SizedBox(width: 10,),
                Text("Remove Ads",style: TextStyle(color: Colors.white,fontSize: 18),),
            ],),
            Row(
              children: [
                Icon(Icons.done_outlined,color: Colors.white,size: 18,),
                SizedBox(width: 10,),
                Text("Live Updates",style: TextStyle(color: Colors.white,fontSize: 18),),
              ],),
            Row(
              children: [
                Icon(Icons.done_outlined,color: Colors.white,size: 18,),
                SizedBox(width: 10,),
                Text("Unlimited Wallpapers",style: TextStyle(color: Colors.white,fontSize: 18),),
              ],),
            Row(
              children: [
                Icon(Icons.done_outlined,color: Colors.white,size: 18,),
                SizedBox(width: 10,),
                Text("Remove Ads",style: TextStyle(color: Colors.white,fontSize: 18),),
              ],),

            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [

                Checkbox(
                  activeColor: AppColors.red,
                    // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    checkColor: Colors.white,
                    // fillColor: MaterialStatePropertyAll(Colors.white),
                    overlayColor: MaterialStatePropertyAll(Colors.white),
                    side: BorderSide(
                      color: Colors.white, // Change the checkbox border color
                      width: 2.0, // Adjust the border width as desired
                    ),

                    value: agreement, onChanged: (val){
                   setState(() {
                     agreement =val!;
                   });

                }),

                RichText(
                  text: TextSpan(
                    text: 'I agree to ',
                    style: TextStyle(color: Colors.white,fontSize: 14),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'terms and conditions',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            // launch('https://example.com/terms'); // Replace with your terms and conditions URL
                          },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10,),

            (agreement)?Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width*0.9,
              height: 50,
              decoration: BoxDecoration(color: AppColors.red,borderRadius: BorderRadius.circular(10)),
              child: Text("Buy Now",style: TextStyle(color: Colors.white,fontSize: 18),),
            ):Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width*0.9,
              height: 50,
              decoration: BoxDecoration(color: AppColors.red.withOpacity(0.7),borderRadius: BorderRadius.circular(10)),
              child: Text("Buy Now",style: TextStyle(color: Colors.white,fontSize: 18),),
            ),

            SizedBox(height: 20,),


        ],).marginSymmetric(horizontal: 15),
      ),

    );
  }
}
