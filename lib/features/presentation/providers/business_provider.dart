import 'package:hr_smart/core/consts/dimensions.dart';
import 'package:hr_smart/core/errors/failure.dart';
import 'package:hr_smart/features/controllers/business_admin_controllers/business_admin_controller.dart';
import 'package:hr_smart/features/controllers/business_admin_controllers/business_cost_controller.dart';
import 'package:hr_smart/features/controllers/super_admin_controllers/super_admin_controller.dart';
import 'package:hr_smart/features/models/business_model.dart';
import 'package:hr_smart/features/models/employee_model.dart';
import 'package:hr_smart/features/models/month_checkout_model.dart';
import 'package:hr_smart/features/models/transaction_model.dart';
import 'package:hr_smart/features/presentation/providers/checkout_provider.dart';
import 'package:hr_smart/features/presentation/widgets/error_widgets.dart';
import 'package:hr_smart/features/presentation/widgets/failures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class BusinessProvider extends ChangeNotifier {
  List<BusinessModel> _activeBusinesses = [];
  List<BusinessModel> _activeBusinessesFilter = [];

  List<BusinessModel> _expiredBusinesses = [];
  List<BusinessModel> _expiredBusinessesFilter = [];

  List<BusinessModel> _requestBusinesses = [];
  List<BusinessModel> _requestBusinessesFilter = [];

  List<BusinessModel> _testBusinesses = [];
  List<BusinessModel> _testBusinessesFilter = [];

  List<EmployeeModel> _employeesList = [];
  List<EmployeeModel> _employeesListFilter = [];

  List<TransactionModel> _expensesList = [];
  List<TransactionModel> _expensesListFilter = [];

  List<BusinessModel> getActiveBusinesses() => _activeBusinesses;
  List<BusinessModel> getExpiredBusinesses() => _expiredBusinesses;
  List<BusinessModel> getRequestBusinesses() => _requestBusinesses;
  List<BusinessModel> getTestBusinesses() => _testBusinesses;
  List<EmployeeModel> getEmployeeList() => _employeesList;
  List<TransactionModel> getExpensesList() => _expensesList;



  addNewBusiness(context, BusinessModel businessModel,
      {String? username, String? email, String? password}) async {

    SuperAdminController businessController = SuperAdminController();
    var data = await businessController.addNewBusiness(businessModel,
        email: email, username: username, password: password);
    data.fold((failure) {
      showFailureModal(context, failure);
    }, (result) {
      _activeBusinesses.add(businessModel);
      _activeBusinessesFilter.add(businessModel);
      notifyListeners();
      showModalBottomSheet(
          backgroundColor: Colors.transparent,
          context: context,
          builder: (context) {
            return Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
              child: Container(
                width: getPhoneWidth(context),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(
                        "Data added successully.",
                        style: GoogleFonts.poppins(
                            fontSize: 17, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: getPhoneWidth(context) * 0.5,
                            height: 45,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.blue),
                            child: TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                "Largo",
                                style: GoogleFonts.poppins(color: Colors.white),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          }).then((value) {
        Navigator.pop(context);
      });
    });
  }

  getAllEmployees(context) async {
    BusinessAdminController businessController = BusinessAdminController();
    var data = await businessController.getEmployees(context);
    data.fold((failure) {
      showFailureModal(context, failure);
    }, (results) {
      _employeesList = results;
      _employeesListFilter = results;
      notifyListeners();
    });
  }

  updateEmployeeMonthCheckout(MonthCheckoutModel monthCheckoutModel) {
    for (var element in _employeesList) {
      if (element.id == element) {
        element.closedMonths.add(monthCheckoutModel);
      }
    }
    notifyListeners();
  }

  countBilance(context) {
    var checkoutProvider =
        Provider.of<CheckoutProvider>(context, listen: false);
    double count = 0.0;
    for (var element in _employeesList) {
      element.transactions.forEach((transaction) {
        var dbDate = DateTime.parse(transaction['updatedAt']);
        if (dbDate.month == DateTime.now().month &&
            dbDate.year == DateTime.now().year &&
            dbDate.day == DateTime.now().day) {
          var price = transaction['price'].toDouble();
          count += price;
        }
      });
    }
    if (checkoutProvider.getActiveCheckout() != null) {
      return (checkoutProvider.getActiveCheckout()!.startPrice - count);
    } else {
      return (0.0).toString();
    }
  }

  addNewExpense(context, encodedData) async {
    BusinessCostController businessCostController = BusinessCostController();
    var result = await businessCostController.addNewExpense(encodedData);
    result.fold((failure) {
      showFailureModal(context, failure);
    }, (results) {
      Navigator.pop(context);
      showErroModal(context, "Shpenzimi u shtua me sukses");
    });
  }

  updateExpense(TransactionModel transactionModel) {
    for (var element in _employeesList) {
      if (element.id == transactionModel.employee!.id) {
        element.transactions!.add(transactionModel.toJson());
      }
    }
    notifyListeners();
  }

  getExpenses(context) async {
    BusinessCostController businessCostController = BusinessCostController();
    var result = await businessCostController.getExpenses(context);
    return result.fold((failure) {
      showFailureModal(context, failure);
    }, (results) {
      _expensesList = results;
      _expensesListFilter = results;
      notifyListeners();
    });
  }

  calculateAllExpenses() {
    double count = 0.0;
    for (var element in _expensesList) {
      var elementDate = DateTime.parse(element.updatedAt);
      var today = DateTime.now();
      if (elementDate.month == today.month && elementDate.day == today.day) {
        count += element.price as double;
      }
    }
    return count;
  }

  Future<List<TransactionModel>?> getEmployeeExpenses(context, id, year,
      {int? month}) async {
    BusinessCostController businessCostController = BusinessCostController();
    var result = await businessCostController
        .getEmployeeExpenses(context, id, year, month: month);
    return result.fold((failure) {
      showFailureModal(context, failure);
    }, (results) {
      return results;
    });
  }

  Future<List<TransactionModel>> getExpensesByEmployee(context, id) async {
    List<TransactionModel> list = [];
    for (var element in _expensesList) {
      list.add(element);
    }
    return list;
  }

  getAllBusinesses(context) async {
    _activeBusinesses = [];
    _activeBusinessesFilter = [];

    _expiredBusinesses = [];
    _expiredBusinessesFilter = [];

    _requestBusinesses = [];
    _requestBusinessesFilter = [];

    _testBusinesses = [];
    _testBusinessesFilter = [];
    SuperAdminController businessController = SuperAdminController();
    var data = await businessController.getAllBusinesses();
    data.fold((failure) {
      showModalBottomSheet(
          backgroundColor: Colors.transparent,
          context: context,
          builder: (context) {
            return Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
              child: Container(
                width: getPhoneWidth(context),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(
                        mapFailureMessage(failure),
                        style: GoogleFonts.poppins(
                            fontSize: 17, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: getPhoneWidth(context) * 0.5,
                            height: 45,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.blue),
                            child: TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                "Largo",
                                style: GoogleFonts.poppins(color: Colors.white),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          });
    }, (result) {
      for (var element in result) {
        print(element.status);
        if (element.status == "approved") {
          _activeBusinesses.add(element);
          _activeBusinessesFilter.add(element);
        } else if (element.status == "waiting") {
          _requestBusinesses.add(element);
          _requestBusinessesFilter.add(element);
        } else if (element.status == "expired") {
          _expiredBusinesses.add(element);
          _expiredBusinessesFilter.add(element);
        }else if (element.status == "testing") {
          _testBusinesses.add(element);
          _testBusinessesFilter.add(element);
        }
      }

      notifyListeners();
    });
  }

  filter(String emriBiznesit, int type) {
    _activeBusinesses = [];
    _expiredBusinesses = [];
    _requestBusinesses = [];

    if (type == 1) {
      for (int i = 0; i < _activeBusinessesFilter.length; i++) {
        if (_activeBusinessesFilter[i]
            .name!
            .toLowerCase()
            .contains(emriBiznesit)) {
          _activeBusinesses.add(_activeBusinessesFilter[i]);
        }
      }
    } else if (type == 2) {
      for (int i = 0; i < _expiredBusinessesFilter.length; i++) {
        if (_expiredBusinessesFilter[i]
            .name!
            .toLowerCase()
            .contains(emriBiznesit)) {
          _expiredBusinesses.add(_expiredBusinessesFilter[i]);
        }
      }
    } else if (type == 3) {
      for (int i = 0; i < _requestBusinessesFilter.length; i++) {
        if (_requestBusinessesFilter[i]
            .name!
            .toLowerCase()
            .contains(emriBiznesit)) {
          _requestBusinesses.add(_requestBusinessesFilter[i]);
        }
      }
    }

    notifyListeners();
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
}
