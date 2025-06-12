
import 'package:business_menagament/features/models/user_model.dart';

class EmployeeModel {
  dynamic id;
  dynamic business;
  UserModel? user;
  dynamic salary;
  dynamic type;
  String? image;
  dynamic transactions;
  dynamic closedMonths;
  dynamic allowedDebt;
  bool? withinSalary;
  dynamic startedDate;
  String? status;
  String? createdAt;
  String? updatedAt;

  bool selected = false;

  EmployeeModel({
    this.id,
    this.business,
    this.user,
    this.salary,
    this.type,
    this.image,
    this.transactions,
    this.closedMonths,
    this.allowedDebt,
    this.withinSalary,
    this.startedDate,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory EmployeeModel.fromJson(Map<String, dynamic> json) {
    UserModel? userModel;

    try {
      userModel = UserModel.fromJson(json['user']);
    } catch (e) {}
    return EmployeeModel(
      id: json['_id'],
      business: json['business'],
      user: userModel,
      type: json['type'],
      status: json['status'],
      salary: json['salary'],
      withinSalary: json['within_salary'],
      image: json['image'],
      transactions: json['transactions'],
      closedMonths: json['monthCheckouts'],
      allowedDebt: json['allowed_debt'],
      startedDate: json['started_date'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  double countTransactions() {
    var currentDate = DateTime.now();
    double count = 0.0;
    if(transactions != null){
      for (var element in (transactions as List)) {
        var dbDate = DateTime.parse(element['updatedAt']);
        if (dbDate.month == currentDate.month) {
          count += element['price'];
        }
      }

    }
   return count;
  }

  double countAllTransactions() {
    var currentDate = DateTime.now();
    double count = 0.0;
    for (var element in (transactions as List)) {
      var dbDate = DateTime.parse(element['updatedAt']);
      if (dbDate.month < currentDate.month) {
        count += element['price'];
      }
    }
    return count;
  }

  double? countPastDebt(){
    double count = 0.0;
    var currentDate = DateTime.now();
    if(closedMonths != null){
      for (var element in (closedMonths )) {
        var dbDate = DateTime.parse(element['updatedAt']);

        if (dbDate.month < currentDate.month && dbDate.year <= currentDate.year) {
          count += element['closed_debt'];
        }
      }
    }

    return count;
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "type": type,
        "business": business,
        "salary": salary,
        "within_salary": withinSalary,
        "image": image,
        "allowed_debt": allowedDebt,
        "started_date": startedDate,
        "status": status,
      };
}
