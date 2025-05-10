// ignore_for_file: use_build_context_synchronously

import 'package:business_menagament/core/api_urls.dart';
import 'package:business_menagament/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:provider/provider.dart';

class RegistrationController {
  static Map<String, String> requestHeader = {
    "Content-Type": "application/json"
  };
  Future<Either<Failure,String>> register(BuildContext context, body) async {
    var response = await http.post(
      Uri.parse(REGISTRATION_URL),
      headers: requestHeader,
      body: jsonEncode(body),
    );
    print(response.body);
    if (response.statusCode == 201) {
      if (response.body.contains("errors")) {
        return Left(WrongFailure());
      }
      var resBody = jsonDecode(response.body);

      if (resBody.toString().contains("success")) {

        return   const Right("success");
      }
      return Left(ServerFailure());
    } else {
      return Left(UnfilledDataFailure());
    }
  }
}
