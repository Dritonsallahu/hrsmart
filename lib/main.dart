// ignore_for_file: library_private_types_in_public_api

import 'package:business_menagament/features/presentation/providers/business_provider.dart';
import 'package:business_menagament/features/presentation/providers/checkout_provider.dart';
import 'package:business_menagament/features/presentation/providers/conectivity_provider.dart';
import 'package:business_menagament/features/presentation/providers/current_user.dart';
import 'package:business_menagament/features/presentation/providers/employee_provider.dart';
import 'package:business_menagament/features/presentation/providers/language_provider.dart';
import 'package:business_menagament/features/presentation/providers/navigator_provider.dart';
import 'package:business_menagament/features/presentation/providers/notification_provider.dart';
import 'package:business_menagament/features/presentation/providers/transactions_provider.dart';
import 'package:business_menagament/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:business_menagament/features/presentation/screens/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
String? langId ;
void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
  static _MyAppState? of(BuildContext context) => context.findAncestorStateOfType<_MyAppState>();
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;

  Locale? getLocale() => _locale;

  void setLocale(Locale value) async {
    var preferences = await SharedPreferences.getInstance();
    setState(() {
      _locale = value;
    });
    preferences.setString("langID", value.languageCode);
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var preferences = await SharedPreferences.getInstance();
      setState(() {
        _locale =   Locale(preferences.getString("langID") ?? "sq");
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BusinessProvider()),
        ChangeNotifierProvider(create: (_) => CheckoutProvider()),
        ChangeNotifierProvider(create: (_) => CurrentUser()),
        ChangeNotifierProvider(create: (_) => NavigatorProvider()),
        ChangeNotifierProvider(create: (_) => ConnectivityProvider()),
        ChangeNotifierProvider(create: (_) => EmployeeProvider()),
        ChangeNotifierProvider(create: (_) => LanguageProvider(),), // Add this line
        ChangeNotifierProvider(create: (_) => NotificationProvider(),), // Add this line
        ChangeNotifierProvider(create: (_) => TransactionsProvider(),), // Add this line
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: _locale ?? const Locale("sq"),
        theme: ThemeData(
          useMaterial3: true,
        ),
        home: _locale == null ? SizedBox():const SplashScreen(),
      ),
    );
  }
}

