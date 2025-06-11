// ignore_for_file: use_build_context_synchronously

import 'package:hr_smart/Api/api.dart';
import 'package:hr_smart/core/api_urls.dart';
import 'package:hr_smart/core/errors/failure.dart';
import 'package:hr_smart/core/storage/local_storage.dart';
import 'package:hr_smart/features/models/business_admin_model.dart';
import 'package:hr_smart/features/models/business_model.dart';
import 'package:hr_smart/features/models/super_admin_model.dart';
import 'package:hr_smart/features/models/user_model.dart';
import 'package:hr_smart/features/presentation/providers/current_user.dart';
import 'package:hr_smart/features/presentation/screens/super_admin/super_admin_home.dart';
import 'package:hr_smart/features/presentation/widgets/bottom_message.dart';
import 'package:hr_smart/features/presentation/screens/business_admin/business_admin_navigation.dart';
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
