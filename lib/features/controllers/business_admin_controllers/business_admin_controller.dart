import 'dart:convert';

import 'package:hr_smart/Api/api.dart';
import 'package:hr_smart/core/api_urls.dart';
import 'package:hr_smart/core/errors/failure.dart';
import 'package:hr_smart/core/storage/local_storage.dart';
import 'package:hr_smart/features/models/business_model.dart';
import 'package:hr_smart/features/models/employee_model.dart';
import 'package:hr_smart/features/presentation/providers/business_provider.dart';
import 'package:hr_smart/features/presentation/providers/current_user.dart';
import 'package:hr_smart/model/biznesi.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BusinessAdminController {
  static var headers = {"Content-Type": "application/json"};
  Future<Either<Failure, String>> addNewEmployee(employee) async {
    var token = await PersistentStorage().getToken();
    headers['Authorization'] = "Bearer $token";
    var response = await http.post(Uri.parse(EMPLOYEE_URL),
        body: employee, headers: headers);
    if (response.statusCode == 201) {
      var resBody = jsonDecode(response.body);
      if (resBody.toString().contains("Conflict")) {
        return Left(DuplicateDataFailure());
      } else if (resBody.toString().contains("Success")) {
        return const Right("Success");
      }
      return Left(ServerFailure());
    } else {
      if (response.statusCode == 409) {
        return Left(DuplicateDataFailure());
      }
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, List<EmployeeModel>>> getEmployees(context) async {
    var userProvider = Provider.of<CurrentUser>(context, listen: false);
    var business = userProvider.getUser()!.businessModel!.id;
    var token = await PersistentStorage().getToken();
    headers['Authorization'] = "Bearer $token";

      var response = await http.get(
          Uri.parse("$EMPLOYEES_LIST_URL?business=$business"),
          headers: headers).timeout(const Duration(seconds: 15));

        var resBody = jsonDecode(response.body);

        List<EmployeeModel> employeeModel = resBody
            .map<EmployeeModel>((json) => EmployeeModel.fromJson(json))
            .toList();
        return Right(employeeModel);

  }

  Future<Either<Failure, List<EmployeeModel>>> getEmployeeDetails(
      context, employeeID) async {
    var userProvider = Provider.of<CurrentUser>(context, listen: false);
    var business = userProvider.getUser()!.businessModel!.id;
    var response = await http
        .get(Uri.parse("$EMPLOYEE_DETAILS_URL/$employeeID"), headers: headers);
    if (response.statusCode == 200) {
      var resBody = jsonDecode(response.body);
      List<EmployeeModel> employeeModel = resBody
          .map<EmployeeModel>((json) => EmployeeModel.fromJson(json))
          .toList();
      return Right(employeeModel);
    } else {
      if (response.statusCode == 409) {
        return Left(DuplicateDataFailure());
      }
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

//get
  Future<List<BiznesModel>> fetchData(var statusi) async {
    final response = await http.get(
      Uri.parse(Api.fetchBiz),
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);

      if (jsonData['dataBizn'] is List) {
        List<BiznesModel> dataBiz =
            jsonData['dataBizn'].map<BiznesModel>((json) {
          return BiznesModel.fromJson(json);
        }).toList();
        return dataBiz;
      } else {
        return [];
      }
    } else {
      throw Exception('Failed to load data');
    }
  }
}
