//
//
//
// import 'dart:convert';
//
// import 'package:business_menagament/Api/api.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:business_menagament/model/user.dart';
// import 'package:flutter/cupertino.dart';
//
// class RememberUserPrefs{
//
//   static Future<void> storeUserInfo(UserModel userinfo)async{
//     SharedPreferences preferences = await SharedPreferences.getInstance();
//     String userJsonData = jsonEncode(userinfo.toJson());
//     await preferences.setString('currentUser', userJsonData);
//   }
//
//   static Future<UserModel?> readUserInfo() async{
//     UserModel? currUserInfo;
//     SharedPreferences preferences = await SharedPreferences.getInstance();
//     String? userInfo = preferences.getString('currentUser');
//     if(userInfo != null){
//       Map<String,dynamic> userDataMap = jsonDecode(userInfo);
//       currUserInfo = UserModel.fromJson(userDataMap);
//     }
//     return currUserInfo;
//   }
//   static Future<void> removeUserInfo()async{
//     SharedPreferences pref = await SharedPreferences.getInstance();
//     await pref.remove('currentUser');
//   }
//
//
// }