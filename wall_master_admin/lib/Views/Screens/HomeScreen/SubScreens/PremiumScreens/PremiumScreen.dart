import 'package:flutter/material.dart';

import '../../../../../Constants/AppColors.dart';


class PremiumScreen extends StatefulWidget {
  @override
  _PremiumScreenState createState() => _PremiumScreenState();
}

class _PremiumScreenState extends State<PremiumScreen> {
  String _title = '';
  String _subTitle = '';
  String _description = '';
  String _package = '';
  List<String> _checkboxes = [];

  void _savePremiumData() {
    // Perform actions to save premium data
    print('Title: $_title');
    print('Sub Title: $_subTitle');
    print('Description: $_description');
    print('Package: $_package');
    print('Checkboxes: $_checkboxes');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.black,
        elevation: 0,
        title: Text("Premium",style: TextStyle(color: AppColors.white),),
        centerTitle: true,
      ),
      body: Container(
        color: AppColors.black,
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextFormField(
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white,width: 1,),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white,width: 1,),
                  ),
                  labelText: "Title",
                  labelStyle: TextStyle(color: Colors.white)
              ),
              onChanged: (value) {
                setState(() {
                  _title = value;
                });
              },
            ),
            SizedBox(height: 16.0),
            TextFormField(
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white,width: 1,),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white,width: 1,),
                  ),
                  labelText: "Sub Title",
                  labelStyle: TextStyle(color: Colors.white)
              ),
              onChanged: (value) {
                setState(() {
                  _subTitle = value;
                });
              },
            ),
            SizedBox(height: 16.0),
            TextFormField(
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white,width: 1,),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white,width: 1,),
                  ),
                  labelText: "Description",
                  labelStyle: TextStyle(color: Colors.white)
              ),
              onChanged: (value) {
                setState(() {
                  _description = value;
                });
              },
              maxLines: null,
            ),
            SizedBox(height: 16.0),
            TextFormField(
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white,width: 1,),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white,width: 1,),
                  ),
                  labelText: "Package",
                  labelStyle: TextStyle(color: Colors.white)
              ),
              onChanged: (value) {
                setState(() {
                  _package = value;
                });
              },
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _savePremiumData,
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
