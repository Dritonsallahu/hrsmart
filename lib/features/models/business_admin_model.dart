// ignore_for_file: overridden_fields

import 'package:business_menagament/features/models/branch_model.dart';
import 'package:business_menagament/features/models/business_model.dart';
import 'package:business_menagament/features/models/user_model.dart';

class  BusinessAdminModel {
  String? id;
  UserModel? user;
  BusinessModel? business;

  BusinessAdminModel({
    this.id,
    this.user,
    this.business,
  });

  factory BusinessAdminModel.fromJson(Map<String, dynamic> json) {
    return BusinessAdminModel(
      id: json['_id'],
      business: BusinessModel.fromJson(json['business']),
      user: UserModel.fromJson(json['user']),
    );
  }

  @override
  Map<String, dynamic> toJson() => {
    "id": id,
    "business": business!.toJson(),
    "user": user!.toJson(),
  };
}
