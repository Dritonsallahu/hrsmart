import 'package:business_menagament/features/models/business_admin_model.dart';
import 'package:business_menagament/features/models/business_model.dart';
import 'package:business_menagament/features/models/employee_model.dart';

class UserModel {
  dynamic id;
  String? fullName;
  String? username;
  String? email;
  dynamic role;
  String? statusi;
  String? createdAt;
  String? updatedAt;

  UserModel(
      {this.id,
      this.fullName,
      this.username,
      this.email,
      this.role,
      this.statusi,
      this.createdAt,
      this.updatedAt,
      });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'],
      fullName: json['fullName'],
      username: json['username'],
      email: json['email'],
      role: json['role'],
      statusi: json['statusi'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "fullName": fullName,
        "username": username,
        "email": email, 
        "role": role,
        "statusi": statusi,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
      };
}
