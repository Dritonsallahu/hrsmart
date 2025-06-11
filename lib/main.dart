import 'package:hr_smart/features/presentation/providers/business_provider.dart';
import 'package:hr_smart/features/presentation/providers/checkout_provider.dart';
import 'package:hr_smart/features/presentation/providers/conectivity_provider.dart';
import 'package:hr_smart/features/presentation/providers/current_user.dart';
import 'package:hr_smart/features/presentation/providers/employee_provider.dart';
import 'package:hr_smart/features/presentation/providers/navigator_provider.dart';
import 'package:flutter/material.dart';
import 'package:hr_smart/features/presentation/screens/splash_screen.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BusinessProvider()),
        ChangeNotifierProvider(create: (_) => CheckoutProvider()),
        ChangeNotifierProvider(create: (_) => CurrentUser()),
        ChangeNotifierProvider(create: (_) => NavigatorProvider()),
        ChangeNotifierProvider(create: (_) => ConnectivityProvider()),
        ChangeNotifierProvider(create: (_) => EmployeeProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false, 
        theme: ThemeData(
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}

