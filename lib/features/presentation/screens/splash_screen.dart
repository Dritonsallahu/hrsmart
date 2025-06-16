import 'package:business_menagament/core/consts/dimensions.dart';
import 'package:business_menagament/core/storage/business_admin_storage.dart';
import 'package:business_menagament/core/storage/employee_storage.dart';
import 'package:business_menagament/core/storage/role_storage.dart';
import 'package:business_menagament/features/models/business_admin_model.dart';
import 'package:business_menagament/features/models/business_model.dart';
import 'package:business_menagament/features/models/employee_model.dart';
import 'package:business_menagament/features/models/user_model.dart';
import 'package:business_menagament/features/presentation/providers/current_user.dart';
import 'package:business_menagament/features/presentation/providers/employee_provider.dart';
import 'package:business_menagament/features/presentation/screens/business_admin/home_screen.dart';
import 'package:business_menagament/features/presentation/screens/credentials_screen.dart';
import 'package:business_menagament/features/presentation/screens/employee_screen/employee_home_page.dart';
import 'package:business_menagament/features/presentation/screens/super_admin/super_admin_home.dart';
import 'package:business_menagament/features/presentation/screens/business_admin/business_admin_navigation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      RoleStorage roleStorage = RoleStorage();
      String? role = await roleStorage.getRole();
      if (role == null) {
        Future.delayed(const Duration(microseconds: 1300)).then((value) {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const CredentialsScreen()));
        });
      } else {
        print("role: ${role}");
        if (role == "superAdmin") {
          //   Provider.of<CurrentUser>(context, listen: false).addNewBusinessAdmin(user);
          //
          //   Navigator.of(context).pushReplacement(
          //       MaterialPageRoute(builder: (_) => const AdminHome()));
        } else if (role == "businessAdmin") {
          BusinessAdminStorage businessAdminStorage = BusinessAdminStorage();
          BusinessAdminModel businessAdminModel =
              (await businessAdminStorage.getAdminUser())!;
          Provider.of<CurrentUser>(context, listen: false)
              .addNewBusinessAdmin(businessAdminModel);

          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (_) => const BusinessAdminNavigation()));
        } else if (role == "manager" ||
            role == "waiter" ||
            role == "employee") {
          EmployeeStorage employeeStorage = EmployeeStorage();
          EmployeeModel employeeModel =
              (await employeeStorage.getEmployeeFromStorage())!;

          Provider.of<EmployeeProvider>(context, listen: false)
              .addNewUser(employeeModel);
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const EmployeeHomePage()));
        } else {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const CredentialsScreen()));
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(38.0),
            child: Hero(
                tag: "caffe-icon-tag",
                child: Image.asset("assets/logos/logo.png")),
          ),
        ));
  }
}
