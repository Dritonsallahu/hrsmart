

class UserModel {
  dynamic id;
  dynamic idUnike;
  String? fullname;
  String? username;
  String? password;
  String? paga;
  String? minusiLejuar;
  String? dataPageses;
  String? category;
  String? statusi;
  String? puntoriAktiv;

  UserModel({
    this.id,
    this.idUnike,
    this.fullname,
    this.username,
    this.password,
    this.paga,
    this.minusiLejuar,
    this.dataPageses,
    this.category,
    this.statusi,
    this.puntoriAktiv
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: int.tryParse(json['user_id']),
      idUnike: int.tryParse(json['unique_id']),
      fullname: json['fullname'],
      username: json['user_name'],
      password: json['user_password'],
      paga: json['paga'],
      minusiLejuar: json['minusiLejuar'],
      dataPageses: json['dataPageses'],
      category: json['category'],
      statusi: json['statusi'],
      puntoriAktiv: json['puntoriAktiv']
    );
  }

  Map<String,dynamic>toJson()=>
      {
        'user_id' : id?.toString(),
        'unique_id':idUnike?.toString(),
        'fullname': fullname?.toString(),
        'user_name':username,
        'user_password': password,
        'paga' : paga,
        'minusiLejuar':minusiLejuar,
        'dataPageses':dataPageses,
        'category':category,
        'statusi':statusi,
        'puntoriAktiv':puntoriAktiv
      };


}
