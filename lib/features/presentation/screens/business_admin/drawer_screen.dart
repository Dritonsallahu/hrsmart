import 'package:hr_smart/features/presentation/providers/current_user.dart';
import 'package:hr_smart/features/presentation/screens/business_admin/about_us_screen.dart';
import 'package:hr_smart/features/presentation/screens/business_admin/business_admin_navigation.dart';
import 'package:hr_smart/features/presentation/screens/business_admin/new_employee.dart';
import 'package:hr_smart/features/presentation/screens/business_admin/employees_list_screen.dart';
import 'package:hr_smart/features/presentation/widgets/error_widgets.dart';
import 'package:hr_smart/view/chart2.dart';
import 'package:hr_smart/features/presentation/screens/business_admin/add_new_cost_screen.dart';
import 'package:hr_smart/features/presentation/screens/business_admin/checkout_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BusinessDrawerWidget extends StatelessWidget {
  final CurrentUser? currentUser;
  const BusinessDrawerWidget({Key? key, this.currentUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print(currentUser!.getUser()!);
    return Drawer(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: ListView(
            children: [
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        image: const DecorationImage(
                            fit: BoxFit.cover,
                            image:
                                AssetImage("assets/images/background.jpeg"))),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        // currentUser!.getUser()!.fullName!,
                        currentUser!.getUser() == null
                            ? ""
                            : currentUser!.getUser()!.fullName!,
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 19),
                      ),
                      Text(
                        currentUser!.getUser() == null
                            ? ""
                            : currentUser!.getUser()!.email!,
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
              const SizedBox(
                height: 32,
              ),
              GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const EmployeesListScreen())),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    color: Colors.transparent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          "assets/icons/card.svg",
                          width: 20,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          "Kartela e punetorve",
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                  )),
              GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddNewCostScreen())),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    color: Colors.transparent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          "assets/icons/add-square.svg",
                          width: 20,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          "Shto shpenzim",
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                  )),
              GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CheckoutScreen())),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    color: Colors.transparent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          "assets/icons/add-square.svg",
                          width: 20,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          "Arka",
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                  )),
              GestureDetector(
                  onTap: () {
                    showErroModal(context,
                        "Jemi duke pergaditur versionin e radhes me perditesimet e fundit, shpresojme mirekuptimin tuaj.");
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) => const ChartTwo())),
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    color: Colors.transparent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          "assets/icons/activity.svg",
                          width: 20,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          "Raporti ditor",
                          style: TextStyle(fontSize: 15, color: Colors.grey),
                        ),
                      ],
                    ),
                  )),
              GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NewEmployee(
                                newPage: true,
                              ))),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    color: Colors.transparent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          "assets/icons/user.svg",
                          width: 20,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          "Shto Punëtor",
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                  )),
              GestureDetector(
                  onTap: () {
                    showErroModal(context,
                        "Jemi duke pergaditur versionin e radhes me perditesimet e fundit, shpresojme mirekuptimin tuaj.");

                    // Navigator.push(
                    // context,
                    // MaterialPageRoute(
                    //     builder: (context) => const AboutUseScreen()));
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    color: Colors.transparent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          "assets/icons/info-circle.svg",
                          width: 20,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          "Rreth nesh",
                          style: TextStyle(fontSize: 15, color: Colors.grey),
                        ),
                      ],
                    ),
                  )),
              GestureDetector(
                  onTap: () async {
                    await currentUser!.removeUser(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    color: Colors.transparent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          "assets/icons/log-out.svg",
                          width: 20,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          "Dil",
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
