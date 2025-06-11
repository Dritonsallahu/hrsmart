import 'package:hr_smart/core/errors/failure.dart';
import 'package:hr_smart/core/storage/local_storage.dart';
import 'package:hr_smart/features/controllers/employee_controllers/emp_expenses_controller.dart';
import 'package:hr_smart/features/models/employee_model.dart';
import 'package:hr_smart/features/models/transaction_model.dart';
import 'package:hr_smart/features/presentation/screens/credentials_screen.dart';
import 'package:hr_smart/features/presentation/widgets/failures.dart';
import 'package:flutter/material.dart';

class EmployeeProvider extends ChangeNotifier {
  EmployeeModel? _employeeModel;

  List<TransactionModel> _transactions = [];

  List<TransactionModel> getExpenses() => _transactions;

  EmployeeModel? getUser() => _employeeModel;

  addNewUser(dynamic employeeModel) {
    _employeeModel = employeeModel;
    notifyListeners();
  }

  getAllExpenses(context, body) async {
    EmpExpensesController empExpensesController = EmpExpensesController();
    var data = await empExpensesController.getEmpExpenses(body);
    data.fold((failure) {
      showFailureModal(context, failure);
    }, (results) {
      _transactions = results;
      notifyListeners();
    });
  }

  getEmployeeDetails(context) async {
    EmpExpensesController empExpensesController = EmpExpensesController();
    var data = await empExpensesController.getEmployeeDetails(context);
    data.fold((failure) {
      showFailureModal(context, failure);
    }, (results) {
      _employeeModel = results;
      notifyListeners();
    });
  }

  mapFailureMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return "Something went wrong!";
      case OfflineFailure:
        return "No internet Connection!";
      case DuplicateDataFailure:
        return "Data already exists!";
      case EmptyDataFailure:
        return "Empty data";
      case WrongFailure:
        return "Something went wrong!";
    }
  }



  Future removeUser(context) async {
    PersistentStorage persistentStorage = PersistentStorage();
    await persistentStorage.removeUser();
    await persistentStorage.removeToken();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const CredentialsScreen()), (route)=> false);
    _employeeModel = null;
    notifyListeners();
  }
}
