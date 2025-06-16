import 'package:business_menagament/features/models/business_model.dart';

class BranchModel {
  final String? id;
  final BusinessModel? business;
  final String? name;
  final String? address;
  final String? city;
  final String? country;
  final String? phoneNumber;
  final String? addedBy;
  final String? description;
  final String? status;
  final bool? active;

  BranchModel({
      this.id,
      this.business,
      this.name,
      this.address,
      this.city,
      this.country,
      this.phoneNumber,
      this.addedBy,
      this.description,
      this.status,
      this.active,
  });

  factory BranchModel.fromJson(dynamic json) {
    if(json.runtimeType == String){
      return BranchModel(id: json);
    }
    return BranchModel(
      id: json['_id'] ?? json['id'],
      business: BusinessModel.fromJson(json['business']),
      name: json['name'],
      address: json['address'],
      city: json['city'],
      country: json['country'],
      phoneNumber: json['phoneNumber'],
      addedBy: json['addedBy'],
      description: json['description'],
      status: json['status'],
      active: json['active'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'business': business,
      'name': name,
      'address': address,
      'city': city,
      'country': country,
      'phoneNumber': phoneNumber,
      'addedBy': addedBy,
      'description': description,
      'status': status,
      'active': active,
    };
  }
}
