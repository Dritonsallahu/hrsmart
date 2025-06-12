import 'dart:convert';

import 'package:business_menagament/core/api_urls.dart';
import 'package:business_menagament/core/errors/exception.dart';
import 'package:business_menagament/core/errors/failure.dart';
import 'package:business_menagament/core/storage/local_storage.dart';
import 'package:business_menagament/features/models/transaction_category_model.dart';
import 'package:business_menagament/features/models/transaction_model.dart';
import 'package:business_menagament/features/presentation/providers/checkout_provider.dart';
import 'package:business_menagament/features/presentation/providers/current_user.dart';
import 'package:business_menagament/features/presentation/providers/transactions_provider.dart';
import 'package:dartz/dartz.dart';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class BusinessTransactionController {
  static var headers = {"Content-Type": "application/json"};

  Future<Either<Failure, TransactionModel>> addNewTransaction(cost) async {
    var token = await PersistentStorage().getToken();
    headers['Authorization'] = "Bearer $token";
    try{
      var response = await http.post(Uri.parse(ADD_EXPENSE_URL),
          body: cost, headers: headers);
      print(cost);
      print(response.body);
      print(response.statusCode);
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
    catch(e){
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, TransactionModel>> editTransaction(
      String tId, dynamic data) async {
    var token = await PersistentStorage().getToken();
    headers['Authorization'] = "Bearer $token";
    try{
      var response = await http.put(Uri.parse("$EDIT_EXPENSE_URL/$tId"),
          body: data, headers: headers);

      if (response.statusCode == 200) {
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
    catch(e){
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, String>> deleteTransaction(tId) async {
    var token = await PersistentStorage().getToken();
    headers['Authorization'] = "Bearer $token";
    try{
      var response = await http.delete(Uri.parse("$DELETE_EXPENSE_URL/$tId"),
          headers: headers);

      if (response.statusCode == 200) {
        if (response.body.contains("errors")) {
          return Left(WrongFailure());
        }
        var resBody = jsonDecode(response.body);
        if (resBody.toString().contains("expense")) {
          return const Right("Success");
          // return   Right(TransactionModel.fromJson(resBody['expense']));
        } else if (resBody.toString().contains("Not Found")) {
          return Left(EmptyDataFailure(message: "Ky shpenzim nuk ekziston!"));
        }
        return Left(ServerFailure());
      } else {
        if (response.statusCode == 409) {
          return Left(DuplicateDataFailure());
        }
        return Left(ServerFailure());
      }
    }
    catch(e){
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, List<TransactionModel>>> getTransactions(
      context) async {
    var userProvider = Provider.of<CurrentUser>(context, listen: false);
    var checkoutProvider =
        Provider.of<CheckoutProvider>(context, listen: false);
    if (checkoutProvider.getCheckoutModel() != null) {
      var token = await PersistentStorage().getToken();
      headers['Authorization'] = "Bearer $token";
      var map = {
        'business': userProvider.getUser()!.businessModel!.id,
        "checkout": checkoutProvider.getCheckoutModel()!.id
      };
      try{
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
      catch(e){
        return Left(ServerFailure());
      }
    } else {
      return Left(NothingFailure());
    }
  }

  Future<Either<Failure, List<TransactionModel>>> getAllTransactions(
      context, bool withDate,
      {DateTime? from, DateTime? to}) async {
    var userProvider = Provider.of<CurrentUser>(context, listen: false);
    var transactionsProvider =
        Provider.of<TransactionsProvider>(context, listen: false);
    var checkoutProvider =
        Provider.of<CheckoutProvider>(context, listen: false);

      var token = await PersistentStorage().getToken();print("sdf");
      headers['Authorization'] = "Bearer $token";
      var data = {"business": userProvider.getUser()!.businessModel!.id};
      if (withDate) {
        data['from'] = DateFormat('yyyy-MM-dd ').format(from!);
        data['to'] = DateFormat('yyyy-MM-dd ').format(to!);
      }
      try{
        var response = await http.post(Uri.parse(TRANSACTIONS_URL),
            body: jsonEncode(data), headers: headers);
        print(response.body);
        print(response.statusCode);
        if (response.statusCode == 201) {
          if (response.body.contains("errors")) {
            return Left(WrongFailure());
          }
          var resBody = jsonDecode(response.body);
          print(resBody);
          if (resBody.toString().contains("transactions")) {
            List<TransactionModel> transactionModel = resBody['transactions']
                .map<TransactionModel>((json) => TransactionModel.fromJson(json))
                .toList();
            transactionsProvider.addTotalPrice(resBody['totalPrice'].toDouble());
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
      catch(e){
        print(e);
        return Left(ServerFailure());
      }

  }

  Future<Either<Failure, List<TransactionModel>>> getTransactionsByCheckout(
      context, String id) async {
    var userProvider = Provider.of<CurrentUser>(context, listen: false);
    var token = await PersistentStorage().getToken();
    headers['Authorization'] = "Bearer $token";
    var map = {'business': userProvider.getUser()!.businessModel!.id};
    try{
      var response = await http.post(Uri.parse("$EXPENSES_BY_CHECKOUT_URL/$id"),
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
    catch(e){
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, List<TransactionModel>>> getEmployeeTransactions(
      context, id, year,
      {int? month}) async {
    var token = await PersistentStorage().getToken();
    headers['Authorization'] = "Bearer $token";
    var editedUrl = "$EMPLOYEE_EXPENSES_URL/$id?year=$year";
    if (month != null) {
      editedUrl += "&month=$month";
    }
    try{
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
    catch(e){
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, List<TransactionCategoryModel>>>
  getTransactionCategories(context) async {
    var userProvider = Provider.of<CurrentUser>(context, listen: false);
    var token = await PersistentStorage().getToken();
    headers['Authorization'] = "Bearer $token";
    var editedUrl = "$TRANSACTION_CATEGORY_URL/${userProvider.getUser()!.businessModel!.id}";

    try{
      var response =
      await http.get(Uri.parse(editedUrl),   headers: headers);
      print(response.body);
      print(response.statusCode);
      if (response.statusCode == 200) {

        if (response.body.contains("errors")) {
          return Left(WrongFailure());
        }
        var resBody = jsonDecode(response.body);
        if (resBody.toString().contains("categories")) {
          List<TransactionCategoryModel> transactionModel = resBody['categories']
              .map<TransactionCategoryModel>((json) => TransactionCategoryModel.fromJson(json))
              .toList();

          return Right(transactionModel);
        }
        return Left(ServerFailure());
      } else {

        if (response.body.contains("errors")) {
          return Left(WrongFailure());
        }
        if (response.statusCode == 409) {
          return Left(DuplicateDataFailure());
        }
        return Left(ServerFailure());
      }
    }
    catch(e){
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, TransactionCategoryModel>>
      addTransactionCategory(context, categoryName) async {
    var userProvider = Provider.of<CurrentUser>(context, listen: false);
    var token = await PersistentStorage().getToken();
    headers['Authorization'] = "Bearer $token";
    var editedUrl = TRANSACTION_CATEGORY_URL;
    var map = {
      "business": userProvider.getUser()!.businessModel!.id,
      "category_name": categoryName
    };
    try{
      var response =
      await http.post(Uri.parse(editedUrl), body: jsonEncode(map), headers: headers);
      print(response.body);
      print(response.statusCode);
      if (response.statusCode == 201) {

        if (response.body.contains("errors")) {
          return Left(WrongFailure());
        }
        var resBody = jsonDecode(response.body);
        if (resBody.toString().contains("category")) {
          TransactionCategoryModel transactionModel =
          TransactionCategoryModel.fromJson(resBody['category']);
          return Right(transactionModel);
        }
        return Left(ServerFailure());
      } else {

        if (response.body.contains("errors")) {
          return Left(WrongFailure());
        }
        if (response.statusCode == 409) {
          return Left(DuplicateDataFailure());
        }
        return Left(ServerFailure());
      }
    }
    catch(e){
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, TransactionCategoryModel>>
  deleteTransactionCategory(context, id) async {
    var userProvider = Provider.of<CurrentUser>(context, listen: false);
    var token = await PersistentStorage().getToken();
    headers['Authorization'] = "Bearer $token";
    var editedUrl = "$TRANSACTION_CATEGORY_URL/$id";
    try{
      var response =
      await http.delete(Uri.parse(editedUrl),  headers: headers);
      print(response.body);
      print(response.statusCode);
      if (response.statusCode == 200) {

        if (response.body.contains("errors")) {
          return Left(WrongFailure());
        }
        var resBody = jsonDecode(response.body);
        if (resBody.toString().contains("category")) {
          TransactionCategoryModel transactionModel = TransactionCategoryModel.fromJson(resBody['category']);
          return Right(transactionModel);
        }
        return Left(ServerFailure());
      } else {

        if (response.body.contains("errors")) {
          return Left(WrongFailure());
        }
        if (response.statusCode == 409) {
          return Left(DuplicateDataFailure());
        }
        return Left(ServerFailure());
      }
    }
    catch(e){
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, dynamic>> filter(context, DateTime from, DateTime to,
      {int? month}) async {
    var userProvider = Provider.of<CurrentUser>(context, listen: false);
    var token = await PersistentStorage().getToken();
    headers['Authorization'] = "Bearer $token";
    var map = {
      "from": DateFormat('yyyy-MM-dd ').format(from),
      "to": DateFormat('yyyy-MM-dd ').format(to),
      'business': userProvider.getUser()!.businessModel!.id
    };
    try{
      var response = await http.post(Uri.parse(FILTER_URL),
          body: jsonEncode(map), headers: headers);

      if (response.statusCode == 201) {
        if (response.body.contains("errors")) {
          return Left(WrongFailure());
        }
        if (response.body.contains("Not Found")) {
          return Left(EmptyDataFailure(message: "Nuk u gjet asnje e dhene!"));
        }
        var resBody = jsonDecode(response.body);
        if (resBody.toString().contains("result")) {
          return Right(resBody['result']);
        }
        return Left(ServerFailure());
      } else {
        if (response.statusCode == 409) {
          return Left(DuplicateDataFailure());
        }
        return Left(ServerFailure());
      }
    }
    catch(e){
      return Left(ServerFailure());
    }
  }
}
