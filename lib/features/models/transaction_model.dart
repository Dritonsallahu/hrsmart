import 'package:hr_smart/features/models/business_admin_model.dart';
import 'package:hr_smart/features/models/checkout_model.dart';
import 'package:hr_smart/features/models/employee_model.dart';
import 'package:hr_smart/features/models/user_model.dart';

class TransactionModel {
  dynamic id;
  dynamic business;
  UserModel? user;
  EmployeeModel? employee;
  CheckoutModel? checkout;
  dynamic date;
  double? price;
  String? reason;
  String? status;
  String? description;
  dynamic createdAt;
  dynamic updatedAt;

  TransactionModel({
    this.id,
    this.business,
    this.user,
    this.employee,
    this.checkout,
    this.date,
    this.price,
    this.reason,
    this.status,
    this.description,
    this.createdAt,
    this.updatedAt,
  });


  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
        id: json['id'],
        business: json['business'],
        user: UserModel.fromJson(json['user']),
      employee: EmployeeModel.fromJson(json['employee']),
        // checkout: json['checkout'],
        date: json['date'],
        price: json['price'].toDouble(),
      reason: json['reason'],
        status: json['status'],
      description: json['description'],
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() => {
    'business': business,
    'user': user!.id,
    'employee': employee!.id,
    // 'checkout': checkout,
    'date': date,
    'price': price,
    'reason': reason,
    'status': status,
    'description': description,
  };
}
