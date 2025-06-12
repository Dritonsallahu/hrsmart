import 'package:business_menagament/core/consts/dimensions.dart';
import 'package:business_menagament/core/storage/local_storage.dart';
import 'package:business_menagament/features/models/business_model.dart';
import 'package:business_menagament/features/models/employee_model.dart';
import 'package:business_menagament/features/models/user_model.dart';
import 'package:business_menagament/features/presentation/providers/current_user.dart';
import 'package:business_menagament/features/presentation/providers/employee_provider.dart';
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
      PersistentStorage persistentStorage = PersistentStorage();
      dynamic data = await persistentStorage.getUser();
      if (data == null) {
        Future.delayed(const Duration(microseconds: 1300)).then((value) {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const CredentialsScreen()));
        });

      } else {
        UserModel? user = UserModel.fromJson(data);
        Future.delayed(const Duration(microseconds: 1300)).then((value) {
          if (user != null) {
            if (user.role['role_name'] == "superadmin") {
              Provider.of<CurrentUser>(context, listen: false).addNewUser(user);

              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => const AdminHome()));
            } else if (user.role['role_name'] == "businessAdmin") {
              BusinessModel businessModel =
                  BusinessModel.fromJson(data['business']);
              user.businessModel = businessModel;
              Provider.of<CurrentUser>(context, listen: false).addNewUser(user);
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const BusinessAdminNavigation()));
            } else if (user.role['role_name'] == "manager" ||
                user.role['role_name'] == "waiter") {
              EmployeeModel employeeModel =
                  EmployeeModel.fromJson(data['employee']);
              employeeModel.user = user;
              user.employeeModel = employeeModel;
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
          } else {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const CredentialsScreen()));
          }
        });
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
