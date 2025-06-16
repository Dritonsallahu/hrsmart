import 'package:shared_preferences/shared_preferences.dart';

class RoleStorage{
  String role = "";
  SharedPreferences? preferences;

  addNewRole(String role) async {
    preferences = await SharedPreferences.getInstance();
    preferences!.setString("role", role);
  }

  Future<String?> getRole() async {
    preferences = await SharedPreferences.getInstance();
    var data = preferences!.getString("role");
      return  data;
  }

  removeRole() async {
    preferences = await SharedPreferences.getInstance();
    await preferences!.remove("role");
  }

}