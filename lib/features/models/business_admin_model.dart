// ignore_for_file: overridden_fields

import 'package:hr_smart/features/models/business_model.dart';
import 'package:hr_smart/features/models/user_model.dart';

class BusinessAdminModel extends UserModel {
  dynamic id;
  String? fullName;
  BusinessModel? businessModel;
  String? username;
  String? email;
  dynamic role;
  String? statusi;

  BusinessAdminModel({
    this.id,
    this.fullName,
    this.username,
    this.email,
    this.role,
    this.statusi,
    this.businessModel,
  }) : super(
    id: id,
    fullName: fullName,
    username: username,
    email: email,
    role: role,
    statusi: statusi,
  );

  factory BusinessAdminModel.fromJson(Map<String, dynamic> json) {
    return BusinessAdminModel(
      id: json['_id'],
      fullName: json['fullName'],
      businessModel: BusinessModel.fromJson(json['business']),
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
    "businessModel": businessModel!.toJson(),
    "username": username,
    "email": email,
    "role": role,
    "statusi": statusi,
  };
}
