import 'package:business_menagament/features/models/user_model.dart';

class MonthCheckoutModel {
  dynamic id;
  dynamic business;
  UserModel? userModel;
  dynamic closedPrice;
  dynamic closedDebt;
  String? description;
  int? month;
  int? year;
  String? closedDate;
  bool? active;

  MonthCheckoutModel({
    this.id,
    this.business,
    this.userModel,
    this.closedPrice,
    this.closedDebt,
    this.description,
    this.month,
    this.year,
    this.closedDate,
    this.active,
  });

  factory MonthCheckoutModel.fromJson(Map<String, dynamic> json) {
    return MonthCheckoutModel(
      id: json['_id'],
      business: json['business'],
      userModel: UserModel.fromJson(json['user']),
      closedPrice: json['closed_price'],
      closedDebt: json['closed_debt'],
      description: json['description'],
      month: json['month'],
      year: json['year'],
      closedDate: json['closed_date'],
      active: json['active'],
    );
  }

  Map<String, dynamic> toJson() => {
    "business": business!.id,
    "user": userModel!.id,
    "closed_price": closedPrice,
    "closed_debt": closedDebt,
    "description": description,
    "month": month,
    "year": year,
    "closed_date": closedDate,
    "active": active,
  };
}
