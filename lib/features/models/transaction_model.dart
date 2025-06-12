import 'package:business_menagament/features/models/business_admin_model.dart';
import 'package:business_menagament/features/models/employee_model.dart';
import 'package:business_menagament/features/models/transaction_category_model.dart';
import 'package:business_menagament/features/models/user_model.dart';

class TransactionModel {
  dynamic id;
  dynamic business;
  UserModel? user;
  EmployeeModel? employee;
  dynamic transactionCategory;
  dynamic checkout;
  dynamic date;
  double? price;
  String? reason;
  String? status;
  String? type;
  String? description;
  dynamic createdAt;
  dynamic updatedAt;

  TransactionModel({
    this.id,
    this.business,
    this.user,
    this.employee,
    this.transactionCategory,
    this.checkout,
    this.date,
    this.price,
    this.reason,
    this.type,
    this.status,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['_id'],
      business: json['business'],
      user: json['user'] == null ? null:UserModel.fromJson(json['user']),
      employee: json['employee'] == null ? null:EmployeeModel.fromJson(json['employee']),
      transactionCategory:  json['transaction_category'],
      checkout: json['checkout'],
      date: json['date'],
      price: json['price'].toDouble(),
      reason: json['reason'],
      status: json['status'],
      type: json['type'],
      description: json['description'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() => {
        'business':business,
        'user':   user!.id,
        'employee':  employee!.id,
        'checkout': checkout,
        'date': date,
        'price': price,
        'reason': reason,
        'type': type,
        'status': status,
        'description': description,
      };
  Map<String, dynamic> toJson2() => {
        'business':business,
        'checkout': checkout,
        'transaction_category':  transactionCategory!.id,
        'date': date,
        'price': price,
        'reason': reason,
        'type': type,
        'status': status,
        'description': description,
      };
}
