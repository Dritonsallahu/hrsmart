import 'package:business_menagament/core/consts/dimensions.dart';
import 'package:business_menagament/core/errors/failure.dart';
import 'package:business_menagament/features/controllers/business_admin_controllers/checkout_controller.dart';
import 'package:business_menagament/features/controllers/super_admin_controllers/super_admin_controller.dart';
import 'package:business_menagament/features/models/business_model.dart';
import 'package:business_menagament/features/models/checkout_model.dart';
import 'package:business_menagament/features/models/month_checkout_model.dart';
import 'package:business_menagament/features/presentation/providers/business_provider.dart';
import 'package:business_menagament/features/presentation/widgets/error_widgets.dart';
import 'package:business_menagament/features/presentation/widgets/failures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

enum CheckoutStatus { checking, opened, closed, passed }

class CheckoutProvider extends ChangeNotifier {
  CheckoutModel? _activeCheckout;
  CheckoutStatus checkoutStatus = CheckoutStatus.checking;

  List<CheckoutModel> _checkoutList = [];
  final List<CheckoutModel> _checkoutListFilter = [];

  CheckoutModel? getCheckoutModel() => _activeCheckout;

  CheckoutModel? getCheckoutModelTwo() {
    if (_activeCheckout != null) return _activeCheckout;
    if(_checkoutList.isEmpty){
      return null;
    }
    return _checkoutList.first;
  }

  CheckoutStatus? getActiveCheckout() {
    if (_activeCheckout != null) {
      var checkoutDate =
          DateFormat('yyyy-MM-dd').parse(_activeCheckout!.startedDate!);
      var today = DateTime.now();
      var isOpen = checkoutDate.year == today.year &&
          checkoutDate.month == today.month &&
          checkoutDate.day == today.day;
      if (isOpen) {
        checkoutStatus = CheckoutStatus.opened;
      } else {
        checkoutStatus = CheckoutStatus.passed;
      }
    } else {
      checkoutStatus = CheckoutStatus.closed;
    }

    return checkoutStatus;
  }

  List<CheckoutModel> getCheckoutList() => _checkoutList;

  addCheckOut(CheckoutModel checkoutModel) {
    _activeCheckout = checkoutModel;
    notifyListeners();
  }

  removeCheckout() {
    _activeCheckout = null;
    notifyListeners();
  }

  getCheckoutt(BuildContext context) async {
    CheckoutController checkoutController = CheckoutController();
    var data = await checkoutController.getCheckout(context);
    data.fold((failure) {
      showFailureModal(context, failure);
    }, (result) {
      _activeCheckout = result;
      notifyListeners();
    });
  }

  getCheckouts(BuildContext context) async {
    CheckoutController checkoutController = CheckoutController();
    var data = await checkoutController.getCheckouts(context);
    data.fold((failure) {
      showFailureModal(context, failure);
    }, (result) {
      _checkoutList = result;
      notifyListeners();
    });
  }

  startCheckout(BuildContext context, CheckoutModel checkoutModel) async {
    var businessProvider =
    Provider.of<BusinessProvider>(context, listen: false);
    CheckoutController checkoutController = CheckoutController();
    var data = await checkoutController.startCheckout(context, checkoutModel);
    data.fold((failure) {
      showFailureModal(context, failure);
    }, (result) {
      _activeCheckout = result;
      businessProvider.getExpenses(context);
      notifyListeners();
      Navigator.of(context).pop();
    });
  }

  closeCheckout(BuildContext context, checkoutId, price) async {
    CheckoutController checkoutController = CheckoutController();
    var data =
        await checkoutController.closeCheckout(context, checkoutId, price);
    data.fold((failure) {
      showFailureModal(context, failure);
    }, (result) {
      removeCheckout();
      Navigator.of(context).pop();
    });
  }

  closeMonthCheckout(
      BuildContext context, MonthCheckoutModel monthCheckoutModel) async {
    var businessProvider =
        Provider.of<BusinessProvider>(context, listen: false);
    CheckoutController checkoutController = CheckoutController();
    var data = await checkoutController.closeMonthlyCheckout(
        context, monthCheckoutModel);
    data.fold((failure) {
      showFailureModal(context, failure);
    }, (result) {
      businessProvider.updateEmployeeMonthCheckout(result);
      Navigator.pop(context);
      showErroModal(context, "Mbyllja u krye me sukses");
    });
  }

  addNewBusiness(context, BusinessModel businessModel,
      {String? username, String? email, String? password}) async {
    SuperAdminController businessController = SuperAdminController();
    var data = await businessController.addNewBusiness(businessModel,
        email: email, username: username, password: password);
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
      // _checkoutList.add(_checkoutList);
      // _checkoutList.add(_checkoutList);
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

  filter(String emriBiznesit, int type) {
    _checkoutList = [];

    // if (type == 1) {
    //   for (int i = 0; i < _activeBusinessesFilter.length; i++) {
    //     if (_activeBusinessesFilter[i]
    //         .name!
    //         .toLowerCase()
    //         .contains(emriBiznesit)) {
    //       _activeBusinesses.add(_activeBusinessesFilter[i]);
    //     }
    //   }
    // }

    notifyListeners();
  }

  mapFailureMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return failure.props;
      case OfflineFailure:
        return failure.props;
      case DuplicateDataFailure:
        return failure.props;
      case EmptyDataFailure:
        return failure.props;
      case WrongFailure:
        return failure.props;
    }
  }
}
