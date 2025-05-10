import 'package:business_menagament/features/models/user_model.dart';

class CheckoutModel {
  dynamic id;
  dynamic business;
  UserModel? userModel;
  dynamic? startPrice;
  String? description;
  String? startedDate;
  String? closedDate;
  dynamic? closedPrice;
  bool? active;
  bool? closed;
  String? updatedAt;
  String? createdAt;

  CheckoutModel({
    this.id,
    this.business,
    this.userModel,
    this.startPrice,
    this.description,
    this.startedDate,
    this.closedDate,
    this.closedPrice,
    this.active,
    this.closed,
    this.updatedAt,
    this.createdAt,
  });

  factory CheckoutModel.fromJson(Map<String, dynamic> json) {
    return CheckoutModel(
      id: json['_id'],
      business: json['business'],
      userModel: json['user'] == null ? null : UserModel.fromJson(json['user']),
      startPrice: json['start_price'],
      description: json['description'],
      startedDate: json['started_date'],
      closedDate: json['closed_date'],
      closedPrice: json['closed_price'],
      active: json['active'],
      closed: json['closed'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() => {
    "business": business!.id,
    "user": userModel!.id,
    "start_price": startPrice,
    "description": description,
    "started_date": startedDate,
    // "closed_date": closedDate,
    "active": active,
    "closed": closed,
  };
}
