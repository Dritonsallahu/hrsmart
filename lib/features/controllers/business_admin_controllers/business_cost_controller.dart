import 'dart:convert';

import 'package:hr_smart/core/api_urls.dart';
import 'package:hr_smart/core/errors/failure.dart';
import 'package:hr_smart/core/storage/local_storage.dart';
import 'package:hr_smart/features/models/transaction_model.dart';
import 'package:hr_smart/features/presentation/providers/checkout_provider.dart';
import 'package:hr_smart/features/presentation/providers/current_user.dart';
import 'package:dartz/dartz.dart';

import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class BusinessCostController {
  static var headers = {"Content-Type": "application/json"};
  Future<Either<Failure, TransactionModel>> addNewExpense(cost) async {
    var token = await PersistentStorage().getToken();
    headers['Authorization'] = "Bearer $token";
    var response = await http.post(Uri.parse(ADD_EXPENSE_URL),
        body: cost, headers: headers);

    if (response.statusCode == 201) {
      if (response.body.contains("errors")) {
        return Left(WrongFailure());
      }
      var resBody = jsonDecode(response.body);
      if (resBody.toString().contains("expense")) {
        return Right(TransactionModel.fromJson(resBody['expense']));
      }
      return Left(ServerFailure());
    } else {
      if (response.statusCode == 409) {
        return Left(DuplicateDataFailure());
      }
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, List<TransactionModel>>> getExpenses(context) async {
    var userProvider = Provider.of<CurrentUser>(context, listen: false);
    var checkoutProvider = Provider.of<CheckoutProvider>(context, listen: false);
    var token = await PersistentStorage().getToken();
    headers['Authorization'] = "Bearer $token";
    var map = {
      'business': userProvider.getUser()!.businessModel!.id,
      'checkout': checkoutProvider.getActiveCheckout()!.id,
    };
    var response = await http.post(Uri.parse(EXPENSES_URL),
        body: jsonEncode(map), headers: headers);

    print(
      Uri.parse(EXPENSES_URL),
    );
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 201) {
      if (response.body.contains("errors")) {
        return Left(WrongFailure());
      }
      var resBody = jsonDecode(response.body);

      if (resBody.toString().contains("expenses")) {
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
  }

  Future<Either<Failure, List<TransactionModel>>> getEmployeeExpenses(
      context, id, year,
      {int? month}) async {
    var userProvider = Provider.of<CurrentUser>(context, listen: false);
    var token = await PersistentStorage().getToken();
    headers['Authorization'] = "Bearer $token";
    var editedUrl = "$EMPLOYEE_EXPENSES_URL/$id?year=$year";
    if (month != null) {
      editedUrl += "&month=$month";
    }
    var response = await http.get(Uri.parse(editedUrl), headers: headers);

    if (response.statusCode == 200) {
      if (response.body.contains("errors")) {
        return Left(WrongFailure());
      }
      var resBody = jsonDecode(response.body);
      if (resBody.toString().contains("expenses")) {
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
  }
}
