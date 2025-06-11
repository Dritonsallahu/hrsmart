import 'package:hr_smart/Api/api.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hr_smart/features/presentation/screens/business_admin/home_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../model/user.dart';
import '../features/presentation/screens/business_admin/business_admin_navigation.dart';

class LoginController {
  Future<void> postLogin(
      BuildContext context,
      TextEditingController userController,
      TextEditingController passwordController) async {
    // Navigator.pushReplacement(
    //     context,
    //     MaterialPageRoute(
    //         builder: (context) => const BusinessAdminNavigation()));
    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
    // return;
    try {
      var response = await http.post(
        Uri.parse(Api.login),
        body: {
          'user_name': userController.text.trim(),
          'user_password': passwordController.text.trim(),
        },
      );

      if (response.statusCode == 200) {
        var resbody = jsonDecode(response.body);

        if (resbody['success'] == true) {
          var userData = resbody['userData'];
          if (userData != null) {
            UserModel? userinfo = UserModel.fromJson(userData);
            Fluttertoast.showToast(msg: 'You logged-in msg');
            Future.delayed(const Duration(milliseconds: 2000), () {
              if (userinfo != null) {
                // if (userinfo.category == 'thana') {
                //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainPage(index: 0)));
                // } else if (userinfo.category == 'menaxher') {
                //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainPage0()));
                // } else if (userinfo.category == 'kamarier') {
                //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => KamarieriPAge()));
                // } else {
                //   Fluttertoast.showToast(msg: 'msg');
                // }
              } else {
                Fluttertoast.showToast(msg: 'User data is missing or null');
              }
            });
          } else {
            Fluttertoast.showToast(msg: 'User data is missing or null');
          }
        } else {
          Fluttertoast.showToast(msg: 'Your account credentials are incorrect');
        }
      } else {
        Fluttertoast.showToast(msg: 'Invalid response from server');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'An error occurred: ' + e.toString());
      print('An error occurreddd: ' + e.toString());
    }
  }
}
