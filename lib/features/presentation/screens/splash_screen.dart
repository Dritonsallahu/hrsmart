import 'package:hr_smart/core/consts/dimensions.dart';
import 'package:hr_smart/core/storage/local_storage.dart';
import 'package:hr_smart/features/models/business_model.dart';
import 'package:hr_smart/features/models/employee_model.dart';
import 'package:hr_smart/features/models/user_model.dart';
import 'package:hr_smart/features/presentation/providers/current_user.dart';
import 'package:hr_smart/features/presentation/providers/employee_provider.dart';
import 'package:hr_smart/features/presentation/screens/credentials_screen.dart';
import 'package:hr_smart/features/presentation/screens/employee_screen/employee_home_page.dart';
import 'package:hr_smart/features/presentation/screens/super_admin/super_admin_home.dart';
import 'package:hr_smart/features/presentation/screens/business_admin/business_admin_navigation.dart';
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
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const CredentialsScreen()));
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
      body: Stack(
        children: [
          SizedBox(
            width: getPhoneWidth(context),
            height: getPhoneHeight(context),
            child: Hero(
                tag: "background-image-tag",
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      "assets/images/background.jpeg",
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                        child: Container(
                      width: getPhoneWidth(context),
                      height: getPhoneHeight(context),
                      decoration:
                          BoxDecoration(color: Colors.black.withOpacity(0.4)),
                    ))
                  ],
                )),
          ),
          Positioned(
              width: getPhoneWidth(context),
              height: getPhoneHeight(context),
              child: Center(
                child: Hero(
                    tag: "caffe-icon-tag",
                    child: Image.asset("assets/icons/caffee-icon-3.png")),
              ))
        ],
      ),
    );
  }
}
