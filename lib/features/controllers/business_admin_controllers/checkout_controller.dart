import 'dart:convert';

import 'package:hr_smart/core/api_urls.dart';
import 'package:hr_smart/core/errors/failure.dart';
import 'package:hr_smart/core/storage/local_storage.dart';
import 'package:hr_smart/features/models/checkout_model.dart';
import 'package:hr_smart/features/models/month_checkout_model.dart';
import 'package:hr_smart/features/models/transaction_model.dart';
import 'package:hr_smart/features/presentation/providers/checkout_provider.dart';
import 'package:hr_smart/features/presentation/providers/current_user.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CheckoutController {
  static var headers = {"Content-Type": "application/json"};
  Future<Either<Failure, CheckoutModel>> startCheckout(
      context, CheckoutModel checkoutModel) async {
    var checkoutProvider =
        Provider.of<CheckoutProvider>(context, listen: false);
    var token = await PersistentStorage().getToken();
    headers['Authorization'] = "Bearer $token";
    var map = checkoutModel.toJson();

    var response = await http.post(Uri.parse(START_CHECKOUT_URL),
        body: jsonEncode(map), headers: headers);

    if (response.statusCode == 201) {
      if (response.body.contains("errors")) {
        return Left(WrongFailure());
      } else if (response.body.contains("Conflict")) {
        var resBody = jsonDecode(response.body)['checkout'];
        checkoutProvider.addCheckOut(CheckoutModel.fromJson(resBody));
        return Left(
            DuplicateDataFailure(message: "Dita tashme eshte e hapur!"));
      }
      var resBody = jsonDecode(response.body);
      if (resBody.toString().contains("checkout")) {
        CheckoutModel transactionModel =
            CheckoutModel.fromJson(resBody['checkout']);

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

  Future<Either<Failure, CheckoutModel>> closeCheckout(
      context, checkoutId, double price) async {
    var checkoutProvider =
        Provider.of<CheckoutProvider>(context, listen: false);
    var token = await PersistentStorage().getToken();
    headers['Authorization'] = "Bearer $token";

    var response = await http.post(Uri.parse(CLOSE_CHECKOUT_URL),
        body: jsonEncode({
          "id": checkoutId,
          "closed_date": DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
              .format(DateTime.now().toUtc()),
          "price": price
        }),
        headers: headers);

    if (response.statusCode == 201) {
      if (response.body.contains("errors")) {
        return Left(WrongFailure());
      } else if (response.body.contains("Conflict")) {
        var resBody = jsonDecode(response.body)['checkout'];
        checkoutProvider.removeCheckout();
        return Left(
            DuplicateDataFailure(message: "Dita tashme eshte e mbyllur!"));
      }
      var resBody = jsonDecode(response.body);
      CheckoutModel checkoutModel = CheckoutModel.fromJson(resBody['checkout']);
      if (resBody.toString().contains("checkout")) {
        return Right(checkoutModel);
      }
      return Left(ServerFailure());
    } else {
      if (response.statusCode == 409) {
        return Left(DuplicateDataFailure());
      }
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, CheckoutModel>> getCheckout(context) async {
    var userProvider = Provider.of<CurrentUser>(context, listen: false);
    var checkoutProvider = Provider.of<CheckoutProvider>(context, listen: false);
    var token = await PersistentStorage().getToken();
    headers['Authorization'] = "Bearer $token";

    var response = await http.post(Uri.parse(CHECKOUT_URL),
        body: jsonEncode({
          "business": userProvider.getUser()!.businessModel!.id,
        }),
        headers: headers);
    if (response.statusCode == 201) {
      if (response.body.contains("errors")) {
        return Left(WrongFailure());
      } else if (response.body.contains("Not Found")) {
        checkoutProvider.removeCheckout();
        return Left(NothingFailure());
      }
      var resBody = jsonDecode(response.body);
      if (resBody.toString().contains("checkout")) {
        CheckoutModel checkoutModel =
            CheckoutModel.fromJson(resBody['checkout']);

        return Right(checkoutModel);
      }
      return Left(ServerFailure());
    } else {
      if (response.statusCode == 409) {
        return Left(DuplicateDataFailure());
      }
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, List<CheckoutModel>>> getCheckouts(context) async {
    var userProvider = Provider.of<CurrentUser>(context, listen: false);
    var business = userProvider.getUser()!.businessModel!.id;
    var token = await PersistentStorage().getToken();
    headers['Authorization'] = "Bearer $token";

    var response = await http.get(Uri.parse("$CHECKOUTS_URL/$business"),
        headers: headers);
    if (response.statusCode == 200) {
      if (response.body.contains("errors")) {
        return Left(WrongFailure());
      } else if (response.body.contains("Not Found")) {
        return Left(NothingFailure());
      }
      var resBody = jsonDecode(response.body);
      if (resBody.toString().contains("checkout")) {
        List<CheckoutModel> checkoutList = resBody['checkout']
            .map<CheckoutModel>((json) => CheckoutModel.fromJson(json))
            .toList();
        return Right(checkoutList);
      }
      return Left(ServerFailure());
    } else {
      if (response.statusCode == 409) {
        return Left(DuplicateDataFailure());
      }
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, MonthCheckoutModel>> closeMonthlyCheckout(
      context, MonthCheckoutModel monthCheckoutModel) async {
    var checkoutProvider =
        Provider.of<CheckoutProvider>(context, listen: false);
    var token = await PersistentStorage().getToken();
    headers['Authorization'] = "Bearer $token";

    var response = await http.post(Uri.parse(CLOSE_MONTHLY_CHECKOUT_URL),
        body: jsonEncode(monthCheckoutModel.toJson()), headers: headers);
    if (response.statusCode == 201) {
      if (response.body.contains("errors")) {
        return Left(WrongFailure());
      } else if (response.body.contains("Conflict")) {
        return Left(DuplicateDataFailure(
            message: "Muaji tashme eshte e mbyllur per kete punetor!"));
      }
      var resBody = jsonDecode(response.body);
      if (resBody.toString().contains("checkout")) {
        MonthCheckoutModel checkoutModel =
        MonthCheckoutModel.fromJson(resBody['checkout']);
        return Right(checkoutModel);
      }
      return Left(ServerFailure());
    } else {
      if (response.statusCode == 409) {
        return Left(DuplicateDataFailure(
            message: "Muaji tashme eshte e mbyllur per kete punetor!"));
      }
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, List<TransactionModel>>> getExpenses(context) async {
    var userProvider = Provider.of<CurrentUser>(context, listen: false);
    var token = await PersistentStorage().getToken();
    headers['Authorization'] = "Bearer $token";
    var map = {'business': userProvider.getUser()!.businessModel!.id};
    var response = await http.post(Uri.parse(EXPENSES_URL),
        body: jsonEncode(map), headers: headers);

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
