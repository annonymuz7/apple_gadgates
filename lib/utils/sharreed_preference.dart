


import 'package:shared_preferences/shared_preferences.dart';

class Shared_Prefference_Class {

  static SharedPreferences? preferences;


  static Future init() async{
    preferences = await SharedPreferences.getInstance();
  }


  static Future set_Login_Status(bool status) async{
    await preferences?.setBool('Login_Status', status).then((value) {
      print('Successfully saved data for Login!!------');
    });
  }


  static Future set_token_init(String token) async{
    await preferences?.setString('Token', token).then((value) {
      print('Successfully saved data for Token!!------');
    });
  }

  static Future set_token_dispose(String token) async{
    await preferences?.setString('Token', token).then((value) {
      print('Successfully saved data for Token!!------');
    });
  }

  static Future set_login_id(String token) async{
    await preferences?.setString('ID', token).then((value) {
      print('Successfully saved data for ID!!------');
    });
  }


  static Future set_role_Status(String role) async{
    await preferences?.setString('Role', role).then((value) {
      print('Successfully saved data for User Role!!------');
    });
  }


  static Future set_area(String area) async{
    await preferences?.setString('Role', area).then((value) {
      print('Successfully saved data for User Location !!------');
    });
  }



  static Future set_user_Status(String user) async{
    await preferences?.setString('Us', user).then((value) {
      print('Successfully saved data for User!!------');
    });
  }


  static Future set_user_id(String id) async{
    await preferences?.setString('iD', id).then((value) {
      print('Successfully saved data for ID!!------');
    });
  }

  static Future set_user_DC(String dc) async{
    await preferences?.setString('Dc', dc).then((value) {
      print('Successfully saved data for Dc!!------');
    });
  }

  static Future<bool?> get_OnBoarding_Status() async{
    return await preferences?.getBool('OnBS');
  }

  static Future<bool?> get_Role_Status() async{
    return await preferences?.getBool('Role');
  }

  static Future<bool?> get_Login_Status() async{
    return await preferences?.getBool('Log');
  }

  static Future<String?> get_User_Status() async{
    return await preferences?.getString('Us');
  }

  static Future<String?> get_User_Workplace() async{
    return await preferences?.getString('Wp');
  }

  static Future<String?> get_User_id() async{
    return await preferences?.getString('iD');
  }

  static Future<String?> get_User_Dc() async{
    return await preferences?.getString('Dc');
  }

}