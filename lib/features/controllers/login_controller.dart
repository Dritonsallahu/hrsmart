// ignore_for_file: use_build_context_synchronously

import 'package:hr_smart/Api/api.dart';
import 'package:hr_smart/core/api_urls.dart';
import 'package:hr_smart/core/storage/local_storage.dart';
import 'package:hr_smart/features/models/business_admin_model.dart';
import 'package:hr_smart/features/models/business_model.dart';
import 'package:hr_smart/features/models/employee_model.dart';
import 'package:hr_smart/features/models/super_admin_model.dart';
import 'package:hr_smart/features/models/user_model.dart';
import 'package:hr_smart/features/presentation/providers/current_user.dart';
import 'package:hr_smart/features/presentation/providers/employee_provider.dart';
import 'package:hr_smart/features/presentation/screens/employee_screen/employee_home_page.dart';
import 'package:hr_smart/features/presentation/screens/super_admin/super_admin_home.dart';
import 'package:hr_smart/features/presentation/widgets/bottom_message.dart';
import 'package:hr_smart/features/presentation/screens/business_admin/business_admin_navigation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:provider/provider.dart';

class LoginController {
  static Map<String, String> requestHeader = {
    "Content-Type": "application/json"
  };
  Future<void> authorize(
      BuildContext context, String username, String password) async {
    // Navigator.pushReplacement(
    //     context, MaterialPageRoute(builder: (context) => MainPage0()));

    var response = await http.post(
      Uri.parse(LOGIN_URL),
      headers: requestHeader,
      body: jsonEncode({
        'username': username,
        'password': password,
      }),
    );

    print(response.body);
    if (response.statusCode == 201) {
      var resbody = jsonDecode(response.body);

      var token = resbody['token'];
      if (resbody['user']['role']['role_name'] == 'superadmin') {
        var userProvider = Provider.of<CurrentUser>(context,listen: false);
        SuperAdminModel user = SuperAdminModel.fromJson(resbody['user']);
        PersistentStorage persistentStorage = PersistentStorage();
        await persistentStorage.addNewUser(user);
        await persistentStorage.addToken(token);
        userProvider.addNewUser(user);
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const AdminHome()));
      }
      else if (resbody['user']['role']['role_name'] == 'businessAdmin') {
        var userProvider = Provider.of<CurrentUser>(context,listen: false);
        UserModel user = UserModel.fromJson(resbody['user']);
        BusinessModel businessModel = BusinessModel.fromJson(resbody['user']['business']);
        user.businessModel = businessModel;

        PersistentStorage persistentStorage = PersistentStorage();
        await persistentStorage.addNewUser(user);
        await persistentStorage.addToken(token);
        userProvider.addNewUser(user);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const BusinessAdminNavigation()));
      }
      else if (resbody['user']['role']['role_name'] == 'manager') {
        var userProvider = Provider.of<EmployeeProvider>(context,listen: false);
        UserModel user = UserModel.fromJson(resbody['user']);
        EmployeeModel employeeModel = EmployeeModel.fromJson(resbody['user']['employee']);
        employeeModel.user = user;
        PersistentStorage persistentStorage = PersistentStorage();
        await persistentStorage.addNewUser(user);
        await persistentStorage.addToken(token);
        userProvider.addNewUser(employeeModel);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const EmployeeHomePage()));

      }
      else if (resbody['user']['role']['role_name'] == 'waiter') {

        print("kamaerier");
      }
      // if (userData != null) {
      //   UserModel? userinfo = UserModel().fromJson(userData);
      //   Fluttertoast.showToast(msg: 'You logged-in msg');
      //   Future.delayed(const Duration(milliseconds: 2000), () {
      //     if (userinfo != null) {
      //       if (userinfo.category == 'thana') {
      //         // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainPage(index: 0)));
      //       } else if (userinfo.category == 'menaxher') {
      //         // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainPage0()));
      //       } else if (userinfo.category == 'kamarier') {
      //         // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => KamarieriPAge()));
      //       } else {
      //         Fluttertoast.showToast(msg: 'msg');
      //       }
      //     } else {
      //       Fluttertoast.showToast(msg: 'User data is missing or null');
      //     }
      //   });
      // } else {
      //   Fluttertoast.showToast(msg: 'User data is missing or null');
      // }
    } else {
      showBottomMessage(context, title: "Te dhenat jane gabim!");
    }
  }
}
