
import 'package:business_menagament/core/errors/failure.dart';
import 'package:business_menagament/core/storage/business_admin_storage.dart';
import 'package:business_menagament/features/models/business_admin_model.dart';
import 'package:business_menagament/features/models/user_model.dart';
import 'package:business_menagament/features/presentation/screens/credentials_screen.dart';
import 'package:flutter/material.dart';

class CurrentUser extends ChangeNotifier {
  BusinessAdminModel? _userModel;

  BusinessAdminModel? getBusinessAdmin() => _userModel;

  addNewBusinessAdmin(BusinessAdminModel userModel){
      _userModel = userModel;
    notifyListeners();
  }

  Future removeBusinessAdmin(context) async {
    BusinessAdminStorage persistentStorage = BusinessAdminStorage();
    await persistentStorage.removeAdminUser();
    await persistentStorage.removeToken();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const CredentialsScreen()), (route)=> false);
    _userModel = null;
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
