

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home_Page extends StatefulWidget {
  const Home_Page({super.key});

  @override
  State<Home_Page> createState() => _Home_PageState();
}

class _Home_PageState extends State<Home_Page> {

  String? token = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_token();
  }


  @override
  Widget build(BuildContext context) {


    return SafeArea(
        child: Scaffold(
          body: Column(
            children: [



            ],
          ),
        )
    );
  }

  void get_token() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    token = preferences.getString('Token');
    print(token);
  }



}
