import 'dart:convert';

import 'package:business_menagament/core/api_urls.dart';
import 'package:business_menagament/core/errors/failure.dart';
import 'package:business_menagament/core/storage/business_admin_storage.dart';
import 'package:business_menagament/features/models/employee_model.dart';
import 'package:business_menagament/features/models/transaction_model.dart';
import 'package:business_menagament/features/presentation/providers/employee_provider.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class EmployeeProfileController {
  static var headers = {"Content-Type": "application/json"};

  Future<Either<Failure, EmployeeModel>> updateProfile(context, body) async {
    var currentUser = Provider.of<EmployeeProvider>(context, listen: false);
    var token = await BusinessAdminStorage().getToken();
    headers['Authorization'] = "Bearer $token";

      var response = await http.put(
          Uri.parse(EMP_DETAILS_URL),
          body: jsonEncode(body),
          headers: headers);
      print(Uri.parse(EMP_DETAILS_URL));
      print(response.body);
      print(response.statusCode);
      if (response.statusCode == 200) {
        var resBody = jsonDecode(response.body);
          EmployeeModel employeeModel =
              EmployeeModel.fromJson(resBody['employee']);
          return Right(employeeModel);

      } else {
        if (response.statusCode == 409) {
          return Left(DuplicateDataFailure());
        }
        return Left(ServerFailure());
      }

  }
}
