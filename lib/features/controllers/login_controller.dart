// ignore_for_file: use_build_context_synchronously

import 'package:business_menagament/core/api_urls.dart';
import 'package:business_menagament/core/storage/employee_storage.dart';
import 'package:business_menagament/core/storage/business_admin_storage.dart';
import 'package:business_menagament/core/storage/role_storage.dart';
import 'package:business_menagament/features/models/branch_model.dart';
import 'package:business_menagament/features/models/business_admin_model.dart';
import 'package:business_menagament/features/models/business_model.dart';
import 'package:business_menagament/features/models/employee_model.dart';
import 'package:business_menagament/features/models/super_admin_model.dart';
import 'package:business_menagament/features/models/user_model.dart';
import 'package:business_menagament/features/presentation/providers/current_user.dart';
import 'package:business_menagament/features/presentation/providers/employee_provider.dart';
import 'package:business_menagament/features/presentation/screens/employee_screen/employee_home_page.dart';
import 'package:business_menagament/features/presentation/screens/super_admin/super_admin_home.dart';
import 'package:business_menagament/features/presentation/widgets/bottom_message.dart';
import 'package:business_menagament/features/presentation/screens/business_admin/business_admin_navigation.dart';
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
    var response = await http.post(
      Uri.parse(LOGIN_URL),
      headers: requestHeader,
      body: jsonEncode({
        'username': username,
        'password': password,
      }),
    );

    RoleStorage roleStorage = RoleStorage();
    if (response.statusCode == 201) {
      var resbody = jsonDecode(response.body);
      var user = resbody['user'];
      print(user['admin']['user']);
      var token = resbody['token']['access_token'];
      if (user['admin']['user']['role']['role_name'] == 'superadmin') {
        var userProvider = Provider.of<CurrentUser>(context, listen: false);
        SuperAdminModel user = SuperAdminModel.fromJson(resbody['user']);
        roleStorage.addNewRole("superAdmin");
        BusinessAdminStorage persistentStorage = BusinessAdminStorage();
        // await persistentStorage.addNewAdminUser(user);
        await persistentStorage.addToken(token);
        // userProvider.addNewBusinessAdmin(user);
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const AdminHome()));
      } else if (user['admin']['user']['role']['role_name'] ==
          'businessAdmin') {
        var userProvider = Provider.of<CurrentUser>(context, listen: false);
        BusinessAdminModel businessAdminModel =
            BusinessAdminModel.fromJson(user['admin']);
        roleStorage.addNewRole("businessAdmin");
        BusinessAdminStorage persistentStorage = BusinessAdminStorage();
        await persistentStorage.addNewAdminUser(businessAdminModel);
        await persistentStorage.addToken(token);
        userProvider.addNewBusinessAdmin(businessAdminModel);

        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const BusinessAdminNavigation()));
      } else if (resbody['user']['role']['role_name'] == 'manager' ||
          resbody['user']['role']['role_name'] == 'waiter' ||
          resbody['user']['role']['role_name'] == 'employee') {
        var userProvider =
            Provider.of<EmployeeProvider>(context, listen: false);
        UserModel user = UserModel.fromJson(resbody['user']);
        EmployeeModel employeeModel =
            EmployeeModel.fromJson(resbody['user']['employee']);
        employeeModel.user = user;
        EmployeeStorage persistentStorage = EmployeeStorage();
        roleStorage.addNewRole("employee");
        await persistentStorage.addNewEmployee(employeeModel);
        await persistentStorage.addToken(token);
        userProvider.addNewUser(employeeModel);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const EmployeeHomePage()));
      } else if (resbody['user']['role']['role_name'] == 'waiter') {}
    } else {
      showBottomMessage(context, title: "Te dhenat jane gabim!");
    }
  }
}
