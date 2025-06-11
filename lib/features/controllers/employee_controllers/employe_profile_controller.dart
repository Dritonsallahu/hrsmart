import 'dart:convert';

import 'package:hr_smart/core/api_urls.dart';
import 'package:hr_smart/core/errors/failure.dart';
import 'package:hr_smart/core/storage/local_storage.dart';
import 'package:hr_smart/features/models/employee_model.dart';
import 'package:hr_smart/features/models/transaction_model.dart';
import 'package:hr_smart/features/presentation/providers/employee_provider.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class EmployeeProfileController {
  static var headers = {"Content-Type": "application/json"};

  Future<Either<Failure, EmployeeModel>> updateProfile(context, body) async {
    var currentUser = Provider.of<EmployeeProvider>(context, listen: false);
    var token = await PersistentStorage().getToken();
    headers['Authorization'] = "Bearer $token";
    try {
      var response = await http.put(
          Uri.parse(EMP_DETAILS_URL),
          body: jsonEncode(body),
          headers: headers);
      print(response.body);
      print(response.statusCode);
      if (response.statusCode == 200) {
        var resBody = jsonDecode(response.body);
        if (resBody.toString().contains("employee")) {
          EmployeeModel employeeModel =
              EmployeeModel.fromJson(resBody['employee']);
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
