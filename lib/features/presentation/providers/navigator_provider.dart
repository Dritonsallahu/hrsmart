import 'package:flutter/material.dart';

enum NavigatorItems { home, cart, newEmployee, newDay, profile }

class NavigatorProvider extends ChangeNotifier {
  NavigatorItems _navigatorItems = NavigatorItems.home;

  NavigatorItems getNavigatorItem () => _navigatorItems;

  changeNavigatorItem(NavigatorItems navigatorItem){
    _navigatorItems = navigatorItem;
    notifyListeners();
  }
}
