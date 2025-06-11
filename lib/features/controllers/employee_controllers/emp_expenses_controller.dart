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

class EmpExpensesController {
  static var headers = {"Content-Type": "application/json"};

  Future<Either<Failure, List<TransactionModel>>> getEmpExpenses(body) async {
    var token = await PersistentStorage().getToken();
    headers['Authorization'] = "Bearer $token";
    try {
      var response = await http.post(Uri.parse(EMP_EXPENSES_URL),
          body: jsonEncode(body), headers: headers);

      if (response.statusCode == 201) {
        var resBody = jsonDecode(response.body);
        if (resBody.toString().contains("Conflict")) {
          return Left(DuplicateDataFailure());
        } else if (resBody.toString().contains("expenses")) {
          List<TransactionModel> transactionModel = resBody['expenses']
              .map<TransactionModel>((json) => TransactionModel.fromJson(json))
              .toList();
          return Right(transactionModel);
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

  Future<Either<Failure, EmployeeModel>> getEmployeeDetails(context) async {
    var currentUser = Provider.of<EmployeeProvider>(context,listen: false);
    var token = await PersistentStorage().getToken();
    headers['Authorization'] = "Bearer $token";
    try {
      var response =
          await http.get(Uri.parse("$EMP_DETAILS_URL/${currentUser.getUser()!.id}"), headers: headers);


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
