import 'package:business_menagament/features/models/business_admin_model.dart';
import 'package:business_menagament/features/models/employee_model.dart';
import 'package:business_menagament/features/models/user_model.dart';

class TransactionCategoryModel {
  dynamic id;
  dynamic business;
  String? categoryName;
  bool selected = false;
  dynamic createdAt;
  dynamic updatedAt;

  TransactionCategoryModel({
    this.id,
    this.business,
    this.categoryName,
    this.createdAt,
    this.updatedAt,
  });

  factory TransactionCategoryModel.fromJson(Map<String, dynamic> json) {
    return TransactionCategoryModel(
      id: json['_id'],
      business: json['business'],
      categoryName: json['category_name'],
    );
  }

  Map<String, dynamic> toJson() => {
        'business': business,
        'category_name': categoryName,
      };
}
