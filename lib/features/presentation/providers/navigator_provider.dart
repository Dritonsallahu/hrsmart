import 'package:flutter/material.dart';

enum NavigatorItems { home, employees, newTransaction, statistics, checkout }

class NavigatorProvider extends ChangeNotifier {
  final PageController _pageController = PageController(initialPage: 0);
  NavigatorItems _navigatorItems = NavigatorItems.home;

  NavigatorItems getNavigatorItem () => _navigatorItems;
  PageController getPageController () => _pageController;

  changeNavigatorItem(NavigatorItems navigatorItem){
    _navigatorItems = navigatorItem;
    notifyListeners();
  }

  changePage(int index){
    _pageController.jumpToPage(index);
    notifyListeners();
  }

}
