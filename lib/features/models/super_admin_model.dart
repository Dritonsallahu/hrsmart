import 'package:hr_smart/features/models/business_model.dart';
import 'package:hr_smart/features/models/user_model.dart';

class SuperAdminModel extends UserModel {
  dynamic id;
  String? fullName;
  String? username;
  String? email;
  dynamic role;
  String? statusi;

  SuperAdminModel({
    this.id,
    this.fullName,
    this.username,
    this.email,
    this.role,
    this.statusi,
  }) : super(
          id: id,
          fullName: fullName,
          username: username,
          email: email,
          role: role,
          statusi: statusi,
        );

  factory SuperAdminModel.fromJson(Map<String, dynamic> json) {
    return SuperAdminModel(
      id: json['id'],
      fullName: json['fullName'],
      username: json['username'],
      email: json['email'],
      role: json['role'],
      statusi: json['statusi'],
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "fullName": fullName,
        "username": username,
        "email": email,
        "role": role,
        "statusi": statusi,
      };
}
