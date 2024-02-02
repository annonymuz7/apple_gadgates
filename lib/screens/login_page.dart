

import 'dart:convert';

import 'package:apple_gadgets/constants/strings.dart';
import 'package:apple_gadgets/models/auth_model.dart';
import 'package:apple_gadgets/screens/home_page.dart';
import 'package:colorful_circular_progress_indicator/colorful_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../utils/sharreed_preference.dart';
import 'package:http/http.dart' as http;

class Login_Page extends StatefulWidget {
  const Login_Page({super.key});

  @override
  State<Login_Page> createState() => _Login_PageState();
}

class _Login_PageState extends State<Login_Page> {

  late TextEditingController email;
  late TextEditingController pass;
  bool? ischecked = false;
  bool is_clicked = true;
  late bool login_success;
  String? uid = '';
  bool _isPasswordVisible = false;
  String token = '';


  @override
  void initState() {
    // TODO: implement initState
    email = TextEditingController();
    pass = TextEditingController();

    super.initState();



  }

  @override
  void dispose() {
    // TODO: implement dispose
    email.dispose();
    pass.dispose();
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    Size size = MediaQuery.of(context).size;


    return SafeArea(
      child:
      Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(height: size.height*0.15,),
                Container(
                  width: size.width*0.8,
                  child: RichText(
                      text: TextSpan(
                        style:  DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Welcome ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black, // Set the color for "Welcome"
                              fontSize: size.width*0.1,
                              decoration: TextDecoration.none,

                            ),
                          ),
                          TextSpan(
                            text: 'Back',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF00A669), // Set the color for "Back"
                              fontSize: size.width*0.1,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ],
                      )
                  ),
                ),

                SizedBox(height: size.height*0.1,),

                Container(
                  width: size.width * 0.8,

                  child: TextField(
                    controller: email,
                    decoration: InputDecoration(hintText: "Email",
                      prefixIcon: Icon(Icons.email, color: Color(0xFF00A669),),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF00A669)), // Border color when focused
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),

                  ),
                ),

                SizedBox(height: size.height*0.03,),

                Container(
                  width: size.width * 0.8,
                  child: TextField(
                    controller: pass,
                    obscureText: !_isPasswordVisible,
                    decoration: InputDecoration(
                      hintText: "Password",
                      prefixIcon: Icon(Icons.lock, color: Color(0xFF00A669),),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF00A669)), // Border color when focused
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),

                  ),
                ),
                SizedBox(height: size.height*0.02,),

                Container(
                  width: size.width*0.8,
                  child: Row(
                    children: [
                      Checkbox(
                        value: ischecked,
                        onChanged: (bool? value) {
                          setState(() {
                            ischecked = value ?? false;
                          });
                        },
                        activeColor: Color(0xFF00A669),
                      ),
                      Text("Keep me loged in")
                    ],
                  ),
                ),

                SizedBox(height: size.height*0.03,),

                Container(
                  width: size.width*0.8,
                  decoration: BoxDecoration(
                    color: Color(0xFF00A669), // Green color
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: TextButton(
                      onPressed: is_clicked ? () async{

                        showConfirmationDialog(context);

                        setState(() {
                          is_clicked = false;
                        });

                        login_success = await signIn(email.text, pass.text);

                        if(login_success){
                          Get.snackbar('Welcome!', 'User Logged In Successfully!!');
                          //print(uid);
                         // print('Display name: ${getDisplayName()}');

                          setState(() {
                            is_clicked = true;
                          });

                          Navigator.of(context).pop();
                          goto_home_page(context);

                        }
                        else {
                          Navigator.of(context).pop();
                          Get.snackbar('Oopps!', 'Invalid email or Password!');
                          setState(() {
                            is_clicked = true;
                          });
                        }

                      } : null,
                      child: Text("Log in", style: TextStyle(color: Colors.white, fontSize: size.width*0.8*0.06),)
                  ),
                ),

                SizedBox(height: size.height*0.05,),


              ],
            ),
          ),
        ),
      ),
    );
  }

  void goto_home_page(BuildContext context) async {
    await Shared_Prefference_Class.init();
    await Shared_Prefference_Class.set_Login_Status(true);
    await Shared_Prefference_Class.set_token_init(token);
    await Shared_Prefference_Class.set_login_id(email.text);
    Get.offAll(const Home_Page());
  }

  Future<void> showConfirmationDialog(BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const AlertDialog(
          title: Text('Loggin In'),
          content: Text('Please wait for a moment.'),
          actions: <Widget>[
            SizedBox(height: 10,),
            Center(
                child: ColorfulCircularProgressIndicator(
                  colors: [Color(0xFF00A669)],
                  strokeWidth: 5,
                  indicatorHeight: 40,
                  indicatorWidth: 40,
                )),
          ],
        );
      },
    );
  }


  Future<bool> signIn(String email, String pass) async {// Replace with your API endpoint

    try {

      print('Input : $email and $pass');

      Map<String, dynamic> requestBody = {
        "login": email,
        "password": pass,
        // Add more key-value pairs as needed
      };

      final response = await http.post(
        Uri.parse(Strings.login_url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        // Request was successful
        print('POST request successful');
        //print('Response: ${response.body}');

        final Map<String, dynamic> data = json.decode(response.body);

        bool result = data['result'];
        token = data['token'];

        print(result);
        print(token);

        return true;
      } else {
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


}
