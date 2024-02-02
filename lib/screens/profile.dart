



import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/strings.dart';
import '../widgets/nav_bar.dart';
import 'package:http/http.dart' as http;

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {


  bool is_picture_loaded = false;
  String image_link = 'a';
  String name = 'Loading..';
  String cell = 'Loading..';
  String email = 'Loading..';
  String area = 'Loading..';
  String location = 'Loading..';
  bool is_loaded = true;

  String lm = 'null';

  String? token = '';
  String? id = '';
  bool is_todo_list_empty = false;

  Map<String, dynamic> data = {};


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_trade_list();
  }


  @override
  Widget build(BuildContext context) {

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    DateTime _dateTime = DateTime.now();


    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Navbar(),
        body: Column(
          children: [


            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  SizedBox(
                    height: height * 0.08,
                  ),

                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      height: height * 0.045,
                      width: width * 0.1,
                      //color: Colors.green,
                      child: Icon(Icons.arrow_back_sharp, size: height * 0.045,),
                    ),
                  ),

                  Container(
                    height: height * 0.045,
                    width: width * 0.05,
                    //color: Colors.orange,
                    child: Text(''),
                  ),

                  Row(
                    children: [
                      Container(
                        width: width*0.7,
                        child: Row(
                          children: [
                            Text("User ", style: TextStyle(fontSize: width*0.8*0.10, fontWeight: FontWeight.bold, color: Colors.black),),
                            Text("Profile", style: TextStyle(fontSize: width*0.8*0.10, fontWeight: FontWeight.bold, color: Color(0xFF00A669),),)
                          ],
                        ),
                      ),
                    ],
                  ),

                ],
              ),
            ),

            SizedBox(
              height: height * 0.025,
            ),


              Container(
                height: height * 0.3,
                width: width * 1,
                //color: Colors.green,
                child: Center(
                  child: Image.asset('assets/images/muslim.png'),
                ),
              ),


            SizedBox(
              height: height * 0.05,
            ),


              Container(
                height: height * 0.06,
                width: width * 1,
                //color: Colors.green,
                child: draw_user_info(
                  width * 0.06, width * 0.05,
                  width * 0.34, height * 0.05,
                  width * 0.02, height * 0.05,
                  width * 0.55, height * 0.05,
                  width * 0.025, height * 0.05,
                  height * 0.025,
                  'Name :', data['name'].toString(),
                ),
              ),


            SizedBox(
              height: height * 0.01,
            ),

            Container(
                height: height * 0.08,
                width: width * 1,
                //color: Colors.green,
                child: draw_user_info(
                  width * 0.06, width * 0.05,
                  width * 0.34, height * 0.05,
                  width * 0.02, height * 0.05,
                  width * 0.55, height * 0.05,
                  width * 0.025, height * 0.05,
                  height * 0.025,
                  'Last Digits :', lm,
                ),
              ),


            SizedBox(
              height: height * 0.01,
            ),

             Container(
                height: height * 0.06,
                width: width * 1,
                //color: Colors.green,
                child: draw_user_info(
                  width * 0.06, width * 0.05,
                  width * 0.34, height * 0.05,
                  width * 0.02, height * 0.05,
                  width * 0.55, height * 0.05,
                  width * 0.025, height * 0.05,
                  height * 0.025,
                  'Balance :', data['balance'].toString(),
                ),
              ),


            SizedBox(
              height: height * 0.01,
            ),

            Container(
                height: height * 0.06,
                width: width * 1,
                //color: Colors.green,
                child: draw_user_info(
                  width * 0.06, width * 0.05,
                  width * 0.34, height * 0.05,
                  width * 0.02, height * 0.05,
                  width * 0.55, height * 0.05,
                  width * 0.025, height * 0.05,
                  height * 0.025,
                  'Currency :', data['currency'].toString(),
                ),
              ),


            SizedBox(
              height: height * 0.01,
            ),

            Container(
                height: height * 0.08,
                width: width * 1,
                //color: Colors.green,
                child: draw_user_info(
                  width * 0.06, width * 0.05,
                  width * 0.34, height * 0.05,
                  width * 0.02, height * 0.05,
                  width * 0.55, height * 0.4,
                  width * 0.025, height * 0.05,
                  height * 0.025,
                  'Location :', '${data['country']}, ${data['city']}',
                ),
              ),


            SizedBox(
              height: height * 0.01,
            ),



          ],
        ),
      ),
    );
  }

  Widget draw_user_info(
      double left_space_width, double left_space_height,
      double key_space_width, double key_space_height,
      double middle_space_width, double middle_space_height,
      double value_space_width, double value_space_height,
      double right_space_width, double right_space_height,
      double text_size,
      String key, String value
      ){

    return Row(
      children: [

        Container(
          width: left_space_width,
          height: left_space_height,
          color: Colors.transparent,
          child: Text(''),
        ),

        Container(
          width: key_space_width,
          height: key_space_height,
          //color: Colors.blue,
          child: Row(
            children: [
              Center(
                child: Text(key,
                  style: TextStyle(
                      fontSize: text_size,
                      fontWeight: FontWeight.w600
                  ),
                ),
              ),
            ],
          ),
        ),

        Container(
          width: middle_space_width,
          height: middle_space_height,
          color: Colors.transparent,
          child: Text(''),
        ),

        Container(
          width: value_space_width,
          height: value_space_height,
          //color: Colors.red,
          child: Row(
            children: [
              Expanded(
                child: Text(value,
                  style: TextStyle(
                    fontSize: text_size,
                  ),
                ),
              ),
            ],
          ),
        ),

        Container(
          width: right_space_width,
          height: right_space_height,
          color: Colors.transparent,
          child: Text(''),
        ),

      ],
    );

  }


  Future<bool> get_trade_list() async {// Replace with your API endpoint

    try {
      print('API entered!!!');

      await get_token();

      print('API continues!!!');

      Map<String, dynamic> requestBody = {
        "login": id,
        "token": token,
        // Add more key-value pairs as needed
      };

      final response = await http.post(
        Uri.parse(Strings.account_url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        // Request was successful
        get_lastphone();

        print('POST request successful');
        print('Response: ${response.body}');

        data = json.decode(response.body);
        //final TradesModel? tm = TradesModel.fromMap(data);


        String? c = data['address'].toString();

        print('\Address : $c');

        setState(() {
          is_todo_list_empty = true;
        });


        return true;
      }

      else if(response.statusCode == 500){
        Get.snackbar('Token Expired!', 'Please Login Again!');
        return false;
      }

      else {
        // Request failed
        print('POST request failed with status: ${response.statusCode}');
        print('Response: ${response.body}');
        return false;
      }
    } catch (error) {
      print('Error making POST request: $error');
      return false;
    }
  }

  Future<bool> get_lastphone() async {// Replace with your API endpoint

    try {
      print('Phone digit entered!!!');

      Map<String, dynamic> requestBody = {
        "login": id,
        "token": token,
        // Add more key-value pairs as needed
      };

      final response = await http.post(
        Uri.parse(Strings.number_url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        // Request was successful
        print('POST request successful');
        print('Response: ${response.body}');

        lm = response.body.toString();

        print('\nLast Digit : $lm');

        setState(() {
          is_todo_list_empty = true;
        });


        return true;
      }

      else {
        // Request failed
        print('POST request failed with status: ${response.statusCode}');
        print('Response: ${response.body}');
        return false;
      }
    } catch (error) {
      print('Error making POST request: $error');
      return false;
    }
  }



  Future get_token() async{
    print('SP entered!!!');
    SharedPreferences preferences = await SharedPreferences.getInstance();
    token = preferences.getString('Token');
    id = preferences.getString('ID');
    print(token);
    print(id);
  }


}
