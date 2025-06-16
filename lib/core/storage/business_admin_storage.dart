import 'dart:convert';

import 'package:business_menagament/features/models/business_admin_model.dart';
import 'package:business_menagament/features/models/user_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BusinessAdminStorage {
  String appName = "business-management";
  SharedPreferences? preferences;
  final storage = const FlutterSecureStorage();

  addNewAdminUser(BusinessAdminModel userModel) async {
    preferences = await SharedPreferences.getInstance();
    preferences!.setString("$appName-user", jsonEncode(userModel.toJson()));
  }

  Future<BusinessAdminModel?> getAdminUser() async {
    preferences = await SharedPreferences.getInstance();
    var data = preferences!.getString("$appName-user");
    print(data);
    if(data != null){
     return  BusinessAdminModel.fromJson(jsonDecode(data));
    }
    else{
      return null;
    }

  }

  removeAdminUser() async {
    preferences = await SharedPreferences.getInstance();
    preferences!.remove("$appName-user");
  }

  Future addToken(token) async => await storage.write(key: 'token', value: token);

  Future getToken() async => await storage.read(key: 'token');

  Future removeToken() async => await storage.delete(key: 'token');
}
