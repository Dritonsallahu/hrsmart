import 'package:business_menagament/features/models/business_model.dart';

class RoleModel {
  final String? id;
  final String? name;

  RoleModel({
    this.id,
    this.name,
  });

  factory RoleModel.fromJson(dynamic json) {
    if (json.runtimeType == String) {
      return RoleModel(id: json);
    }
    return RoleModel(
      id: json['_id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() => {'_id': id, 'name': name};
}
