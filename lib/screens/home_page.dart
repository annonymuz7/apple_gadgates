

import 'dart:async';
import 'dart:convert';

import 'package:apple_gadgets/screens/profile.dart';
import 'package:apple_gadgets/widgets/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:swipe_refresh/swipe_refresh.dart';

import '../constants/strings.dart';
import '../models/trades_model.dart';

class Home_Page extends StatefulWidget {
  const Home_Page({super.key});

  @override
  State<Home_Page> createState() => _Home_PageState();
}

class _Home_PageState extends State<Home_Page> {

  String? token = '';
  String? id = '';

  bool is_todo_list_empty = false;

  List<dynamic> data = [];

  final _controller = StreamController<SwipeRefreshState>.broadcast();

  Stream<SwipeRefreshState> get _stream => _controller.stream;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //get_token();
    get_trade_list();
  }


  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          bottomNavigationBar: Navbar(),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Color(0xFF00A669),
            onPressed: () {
              // Add your action here
              print('Floating Action Button Pressed');
              showConfirmationDialog(context, size);
            },
            child: Text('Profit', style: TextStyle(color: Colors.white),)
          ),
          body: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: size.height*0.05,),
                  Container(
                    width: size.width*0.9,

                    //First Line of the page
                    child: Row(
                      children: [
                        Container(
                          width: size.width*0.9*0.6,
                          child: RichText(
                              text: TextSpan(
                                style:  DefaultTextStyle.of(context).style,
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'Dashboard',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black, // Set the color for "Welcome"
                                      fontSize: size.width*0.09,
                                      decoration: TextDecoration.none,


                                    ),
                                  ),
                                  TextSpan(
                                    text: '',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF00A669), // Set the color for "Back"
                                      fontSize: size.width*0.08,
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                ],
                              )
                          ),
                        ),

                        SizedBox(width: size.width*0.9*0.15,),

                        InkWell(
                          onTap: () async{

                            // List<Map<String, dynamic>> result = await dbHelper.getData();
                            // print(result);
                            Get.to(Profile());

                          },
                          child: Container(
                            width: size.width*0.9*0.25,
                            child: Image.asset('assets/images/muslim.png'),
                          ),
                        ),



                      ],
                    ),
                  ),

                  SizedBox(height: size.height*0.05,),

                  is_todo_list_empty ? Container(
                    height: size.height * 0.67,
                    width: size.width * 1,
                    //color: Colors.green,
                    child: RefreshIndicator(
                      onRefresh: _refresh,
                      child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 20),
                            child: GestureDetector(
                              onTap: (){

                              },
                              child: Card(
                                elevation: 5.0,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 5, bottom: 5),
                                  child: Container(

                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [

                                        Container(
                                          width: size.width * 0.7,
                                          //height: size.height * 0.1,
                                          //color: Colors.green,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [

                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      '${data[index]['symbol']} \nCurrentPrice: ${data[index]['currentPrice']}'
                                                      ,
                                                      style: TextStyle(
                                                          fontSize: size.height * 0.03,
                                                          fontWeight: FontWeight.w600
                                                      ),
                                                      maxLines: 2,
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      'Open Price: ${data[index]['openPrice']}\n'
                                                          'Open time: ${data[index]['openTime']}\n'
                                                          'Digits: ${data[index]['digits']}\n'
                                                          'Profit: ${data[index]['profit']}\n'
                                                          'Ticket: ${data[index]['ticket']}\n'
                                                          'Swaps: ${data[index]['swaps']}\n'
                                                          'Type: ${data[index]['type']}\n'
                                                          'Volume: ${data[index]['volume']}\n'

                                                      ,
                                                      style: TextStyle(
                                                          fontSize: size.height * 0.02,
                                                          fontWeight: FontWeight.w400
                                                      ),
                                                      //maxLines: 1,
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ],
                                              ),

                                            ],
                                          ),
                                        ),

                                      ],
                                    ),




                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  )
                      :
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      SizedBox(height: size.height * 0.1,),

                      Container(
                        alignment: Alignment.center,
                        child: Center(
                          child: Text('No Data Available Yet !',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: size.height * 0.03
                            ),),

                        ),
                      ),


                    ],
                  ),



                ],
              ),
            ),
          ),
        )

    );
  }

  Future<void> showConfirmationDialog(BuildContext context, Size size) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Profit Details'),
          content: get_profit(size),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Close the dialog and perform the action

                print('Done Clicked!!');
                Navigator.of(context).pop();
                //goto_login_page(context);
              },
              child: Text('Done'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _refresh() async {
    // Simulate a delay for refreshing data
    await Future.delayed(Duration(seconds: 2));

    await get_trade_list();
    // Update the data or perform any other refresh logic here
    setState(() {

    });
  }

  Widget get_profit(Size size) {
    double profit = 0.0;
    double? temp = 0.0;
    return Container(
      height: size.height * 0.17,
      width: size.width * 1,
      //color: Colors.redAccent,
      child: Center(
          child: ListView.builder(
            itemCount: data.length + 1,
            itemBuilder: (context, index) {
              temp =  (index<data.length) ? double.tryParse(data[index]['profit'].toString()) : 0.0;
              profit = profit + temp!;
              return (index<data.length) ?
              Text('Wallet ${index+1} profit: ${data[index]['profit']}')
              :
              Text('\nTotal profit : ${profit.toStringAsFixed(4)}', style: const TextStyle(
                fontWeight: FontWeight.w800
              ),);
            },
          ),
      ),
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
        Uri.parse(Strings.trades_url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        // Request was successful
        print('POST request successful');
        print('Response: ${response.body}');

        data = json.decode(response.body);
        //final TradesModel? tm = TradesModel.fromMap(data);


        String? c = data[0]['openTime'].toString();

        print('\currentPrice: $c');

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



  Future get_token() async{
    print('SP entered!!!');
    SharedPreferences preferences = await SharedPreferences.getInstance();
    token = preferences.getString('Token');
    id = preferences.getString('ID');
    print(token);
    print(id);
  }



}
