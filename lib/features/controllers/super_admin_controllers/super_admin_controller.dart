import 'dart:convert';
import 'package:business_menagament/core/api_urls.dart';
import 'package:business_menagament/core/errors/failure.dart';
import 'package:business_menagament/features/models/business_model.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class SuperAdminController {
  static var headers = {"Content-Type": "application/json"};
  Future<Either<Failure, BusinessModel>> addNewBusiness(
      BusinessModel businessModel,
      {String? username,
      String? email,
      String? password}) async {
    Map<String, dynamic> map = businessModel.toJson();
    map['username'] = username;
    map['email'] = email;
    map['password'] = password;
    try {
      var response = await http.post(Uri.parse(ADD_BUSINESS_URL), body: jsonEncode(map),headers: headers);

      if (kDebugMode) {
        print(response.body);
      }
      if (response.statusCode == 201) {
        var resBody = jsonDecode(response.body)['business'];
        return Right(BusinessModel.fromJson(resBody));
      } else {
        if (response.statusCode == 409) {
          return Left(DuplicateDataFailure());
        }
        return Left(ServerFailure());
      }
    } catch (e) {

      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, List<BusinessModel>>> getAllBusinesses() async {
    try {
      var response = await http.get(Uri.parse(GET_ALL_BUSINESSES_URL));

      if (response.statusCode == 200) {
        var resBody = jsonDecode(response.body);
        List<BusinessModel> businessModel = resBody
            .map<BusinessModel>((json) => BusinessModel.fromJson(json))
            .toList();
        return Right(businessModel);
      } else {
        if (response.statusCode == 409) {
          return Left(DuplicateDataFailure());
        }
        return Left(ServerFailure());
      }
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, BusinessModel>> acceptBusinessRequest(id, body) async {

    try {
      var response = await http.post(Uri.parse("$ACCEPT_BUSINESS_URL/$id"),
          body: jsonEncode(body), headers: headers);

      if (response.statusCode == 201) {
        var resBody = jsonDecode(response.body);
        if (resBody.toString().contains("Conflict")) {
          return Left(DuplicateDataFailure(message: "Ky perdorues tashme ekziston!"));
        }
        BusinessModel businessModel =
            BusinessModel.fromJson(resBody['business']);
        return Right(businessModel);
      } else {
        if (response.statusCode == 409) {
          return Left(DuplicateDataFailure());
        }
        return Left(ServerFailure());
      }
    } catch (e) {

      return Left(ServerFailure());
    }
  }

}
