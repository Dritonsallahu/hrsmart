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
  });

  factory BusinessModel.fromJson(Map<String, dynamic> json) {
    print("--");
    print(json);
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
    );
  }
  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "ownerName": ownerName,
        "city": city,
        "country": country,
        "businessNumber": businessNumber,
        "phoneNumber": phoneNumber,
        "comment": comment,
        "startingDate": startingDate,
        "status": status,
      };
}
