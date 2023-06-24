import 'package:flutter/material.dart';
import 'package:wallmaster/Constants/AppColors.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        title: const Text('Privacy Policy'),
        centerTitle: true,
        backgroundColor: AppColors.black,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            SizedBox(height: 16),
            Text(
              'Introduction',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.white,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Thank you for using the Wallpaper App ("App") developed by [Your Company Name] ("We," "Us," or "Our"). We are committed to protecting your privacy and ensuring the security of your personal information. This Privacy Policy outlines how we collect, use, store, and disclose information when you use our App. By accessing or using the App, you agree to the terms of this Privacy Policy.',style: TextStyle(color: AppColors.white,),
            ),
            // Add the remaining sections of the privacy policy here...
          ],
        ),
      ),
    );
  }
}