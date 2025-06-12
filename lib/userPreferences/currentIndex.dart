// import 'package:business_menagament/model/user.dart';
// import 'package:business_menagament/userPreferences/user_preferences.dart';
// import 'package:get/get.dart';
//
// class CurrentIndex extends GetxController{
//   Rx<UserModel>currentUser = UserModel(id: 0,username: '',password: '',fullname: '',biznesid: '',puntoriAktiv: '',statusi: '',category: '',dataPageses: '',minusiLejuar: '',paga: '').obs;
//
//   UserModel get user=> currentUser.value;
//
//   getUserInfo()async{
//     UserModel? getUserInfoFromLocalStorage = await RememberUserPrefs.readUserInfo();
//     currentUser.value = getUserInfoFromLocalStorage!;
//   }
// }