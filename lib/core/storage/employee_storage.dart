import 'dart:convert';

import 'package:business_menagament/features/models/employee_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmployeeStorage {
  String appName = "business-management";
  SharedPreferences? preferences;
  final storage = const FlutterSecureStorage();

  addNewEmployee(EmployeeModel userModel) async {
    preferences = await SharedPreferences.getInstance();
    preferences!.setString("$appName-user", jsonEncode(userModel.toJson()));
  }

  Future<EmployeeModel?> getEmployeeFromStorage() async {
    preferences = await SharedPreferences.getInstance();
    var data = preferences!.getString("$appName-user");
    if(data != null){
      return  jsonDecode(data);
    }
    else{
      return null;
    }

  }

  removeEmployeeFromStorage() async {
    preferences = await SharedPreferences.getInstance();
    preferences!.remove("$appName-user");
  }

  Future addToken(token) async => await storage.write(key: 'token', value: token);

  Future getToken() async => await storage.read(key: 'token');

  Future removeToken() async => await storage.delete(key: 'token');
}