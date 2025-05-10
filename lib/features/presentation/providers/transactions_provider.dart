import 'package:business_menagament/features/controllers/business_admin_controllers/business_transaction_controller.dart';
import 'package:business_menagament/features/controllers/employee_controllers/emp_expenses_controller.dart';
import 'package:business_menagament/features/models/transaction_category_model.dart';
import 'package:business_menagament/features/models/transaction_model.dart';
import 'package:business_menagament/features/presentation/widgets/error_widgets.dart';
import 'package:business_menagament/features/presentation/widgets/failures.dart';
import 'package:flutter/material.dart';

class TransactionsProvider extends ChangeNotifier {
  List<TransactionModel> _transactions = [];
  List<TransactionCategoryModel> _transactionsCategories = [];
  double _totalPrice = 0.0;

  List<TransactionModel> getTransactions() => _transactions;
  List<TransactionCategoryModel> getTransactionsCategories() =>
      _transactionsCategories;

  double getTotalPrice() => _totalPrice;

  addNewTransaction(TransactionModel transactionModel) {
    _transactions.add(transactionModel);
    notifyListeners();
  }

  addNewTransactionCategory(TransactionCategoryModel transactionCategoryModel) {
    _transactionsCategories.add(transactionCategoryModel);
    notifyListeners();
  }

  addTotalPrice(double price) {
    print(price);
    _totalPrice = price;
    notifyListeners();
  }

  getAllTransactions(context, bool withDate,
      {DateTime? from, DateTime? to}) async {
    BusinessTransactionController businessTransactionController =
        BusinessTransactionController();
    var data = await businessTransactionController
        .getAllTransactions(context, withDate, from: from, to: to);
    data.fold((failure) {
      showFailureModal(context, failure);
    }, (results) {
      _transactions = results;
      notifyListeners();
    });
  }

  getAllTransactionsCategories(context) async {
    BusinessTransactionController businessTransactionController =
        BusinessTransactionController();
    var data = await businessTransactionController
        .getTransactionCategories(context);
    data.fold((failure) {
      showFailureModal(context, failure);
    }, (results) {
      _transactionsCategories = results;
      notifyListeners();
    });
  }

  addTransactionCategory(context, String categoryName ) async {
    BusinessTransactionController businessTransactionController =
        BusinessTransactionController();
    var data = await businessTransactionController
        .addTransactionCategory(context, categoryName);
    data.fold((failure) {
      showFailureModal(context, failure);
    }, (results) {
      _transactionsCategories.add(results);
      notifyListeners();
    });
  }

  deleteTransactionCategory(context, String id ) async {
    BusinessTransactionController businessTransactionController =
        BusinessTransactionController();
    var data = await businessTransactionController
        .deleteTransactionCategory(context, id);
    data.fold((failure) {
      showFailureModal(context, failure);
    }, (results) {
      _transactionsCategories.removeWhere((element) => element.id.toString() == id.toString());
      showErroModal(context, "Kategoria u fshi me sukses.");
      notifyListeners();
    });
  }
}
