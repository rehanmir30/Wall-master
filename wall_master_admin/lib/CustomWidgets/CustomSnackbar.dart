import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSnackbar {
  static void show(String message,Color coo, {Duration duration = const Duration(seconds: 4)}) {
    Get.snackbar(
      '',
      '',
      messageText: _buildContent(message,coo),
      duration: duration,
      backgroundColor: Colors.transparent,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  static Widget _buildContent(String message,coo) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: coo,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        children: [
          Icon(Icons.info, color: Colors.white),
          SizedBox(width: 8.0),
          Expanded(
            child: Text(
              message,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
