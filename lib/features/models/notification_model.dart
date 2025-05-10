import 'package:business_menagament/features/models/business_admin_model.dart';
import 'package:business_menagament/features/models/business_model.dart';
import 'package:business_menagament/features/models/employee_model.dart';
import 'package:business_menagament/features/models/user_model.dart';

class NotificationModel {
  dynamic id;
  UserModel? sender;
  UserModel? reciever;
  String? title;
  String? message;
  bool? read;
  String? createdAt;
  String? updatedAt;

  NotificationModel({
    this.id,
    this.sender,
    this.reciever,
    this.title,
    this.message,
    this.read,
    this.createdAt,
    this.updatedAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['_id'],
      sender: UserModel.fromJson(json['sender']),
      reciever: UserModel.fromJson(json['receiver']),
      title: json['title'],
      message: json['message'],
      read: json['read'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "sender": sender,
        "reciever": reciever,
        "read": read,
        "title": title,
        "message": message,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
      };
}
