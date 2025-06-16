import 'package:business_menagament/features/models/branch_model.dart';

class BusinessModel {
  dynamic id;
  String? name;
  dynamic? ownerName;
  String? city;
  String? country;
  String? businessNumber;
  String? phoneNumber;
  String? comment;
  String? startingDate;
  String? status;
  bool? active;
  List<BranchModel>? branches;

  BusinessModel({
    this.id,
    this.name,
    this.ownerName,
    this.city,
    this.country,
    this.businessNumber,
    this.phoneNumber,
    this.comment,
    this.startingDate,
    this.status,
    this.active,
    this.branches,
  });

  factory BusinessModel.fromJson(dynamic json) {
    if (json.runtimeType == String) {
      return BusinessModel(id: json);
    }
    return BusinessModel(
      id: json['_id'],
      name: json['name'],
      ownerName: json['owner'],
      city: json['city'],
      country: json['country'],
      businessNumber: json['businessNumber'],
      phoneNumber: json['phoneNumber'],
      comment: json['comment'],
      startingDate: json['startingDate'],
      status: json['status'],
      active: json['active'],
      branches: json['branches'] != null
          ? List<BranchModel>.from(
          json['branches'].map((x) => BranchModel.fromJson(x)))
          : null,
    );
  }

  addBranches(List<BranchModel> branches){
    this.branches = branches;
  }

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "owner": ownerName,
    "city": city,
    "country": country,
    "businessNumber": businessNumber,
    "phoneNumber": phoneNumber,
    "comment": comment,
    "startingDate": startingDate,
    "status": status,
    "active": active,
    "branches": branches?.map((x) => x.toJson()).toList(),
  };
}
