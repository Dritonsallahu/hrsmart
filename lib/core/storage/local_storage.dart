import 'dart:convert';

import 'package:hr_smart/features/models/user_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PersistentStorage {
  String appName = "business-management";
  SharedPreferences? preferences;
  final storage = const FlutterSecureStorage();

  addNewUser(UserModel userModel) async {
    preferences = await SharedPreferences.getInstance();
    preferences!.setString("$appName-user", jsonEncode(userModel.toJson()));
  }

  Future<dynamic> getUser() async {
    preferences = await SharedPreferences.getInstance();
    var data = preferences!.getString("$appName-user");
    if(data != null){
     return  jsonDecode(data);
    }
    else{
      return null;
    }

  }

  removeUser() async {
    preferences = await SharedPreferences.getInstance();
    preferences!.remove("$appName-user");
  }

  Future addToken(token) async => await storage.write(key: 'token', value: token);

  Future getToken() async => await storage.read(key: 'token');

  Future removeToken() async => await storage.delete(key: 'token');
}
