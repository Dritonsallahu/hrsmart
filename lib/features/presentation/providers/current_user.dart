
import 'package:hr_smart/core/errors/failure.dart';
import 'package:hr_smart/core/storage/local_storage.dart';
import 'package:hr_smart/features/models/user_model.dart';
import 'package:hr_smart/features/presentation/screens/credentials_screen.dart';
import 'package:flutter/material.dart';

class CurrentUser extends ChangeNotifier {
  UserModel? _userModel;

  UserModel? getUser() => _userModel;

  addNewUser(dynamic userModel){
      _userModel = userModel;
    notifyListeners();
  }

  Future removeUser(context) async {
    PersistentStorage persistentStorage = PersistentStorage();
    await persistentStorage.removeUser();
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
