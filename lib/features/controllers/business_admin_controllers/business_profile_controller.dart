
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:business_menagament/core/api_urls.dart';
import 'package:business_menagament/core/errors/failure.dart';
import 'package:business_menagament/core/storage/local_storage.dart';
import 'package:business_menagament/features/models/employee_model.dart';
import 'package:business_menagament/features/presentation/providers/employee_provider.dart';
import 'package:dartz/dartz.dart';
import 'package:provider/provider.dart';

class BusinessProfileController{
  static var headers = {"Content-Type": "application/json"};
  Future<Either<Failure, EmployeeModel>> updateProfile(context, body) async {
    var token = await PersistentStorage().getToken();
    headers['Authorization'] = "Bearer $token";
    try {
      var response = await http.put(
          Uri.parse(BUSINESS_PROFILE_URL),
          body: jsonEncode(body),
          headers: headers);
      if (response.statusCode == 200) {
        var resBody = jsonDecode(response.body);
        if (resBody.toString().contains("business")) {
          EmployeeModel employeeModel =
          EmployeeModel.fromJson(resBody['business']);
          return Right(employeeModel);
        }
        return Left(ServerFailure());
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