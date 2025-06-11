import 'dart:convert';

import 'package:hr_smart/Api/api.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import '../model/user.dart';

class Signup{
  static int? i;

  Future<dynamic> regjistroUserin(int idBiznes,TextEditingController fullName,TextEditingController username,TextEditingController userpw,TextEditingController paga,TextEditingController minLej,TextEditingController dataPag,TextEditingController category,TextEditingController statusi,String puntoriAktiv) async {
  UserModel userModel = UserModel(
      id: 10,
      idUnike: 0,
      fullname: fullName.text.trim(),
      username : username.text.trim(),
      password: userpw.text.trim(),
      paga : paga.text.trim(),
      minusiLejuar: minLej.text.trim(),
      dataPageses: dataPag.text.trim(),
      category: category.text.trim(),
      statusi: statusi.text.trim(),
      puntoriAktiv: fullName.text.trim()
  );
    try{
    var res = await http.post(Uri.parse(Api.signup),
        body: userModel.toJson()
    );
    if( res.statusCode == 200){
      var resbody = jsonDecode(res.body);

      if(resbody['success'] == true){
        print('you\'re registred, welcome Bmanagment');
        Fluttertoast.showToast(msg: 'you\'re registred, welcome Bmanagment');
      }else{
        Fluttertoast.showToast(msg: 'your data are mising');
      }
    }
  }catch(e){
  print(e.toString());
  }
  }


}